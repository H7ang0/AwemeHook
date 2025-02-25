#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AWEGeneralSettingViewModel : NSObject
- (id)sectionDataArray;
- (void)setSectionDataArray:(id)arg1;
@end

@interface AWESettingSectionModel : NSObject
@property(retain, nonatomic) NSArray *itemArray;
@end

@interface AWESettingItemModel : NSObject
@property(copy, nonatomic) NSString *title;
@property(nonatomic) long long cellType;
@property(nonatomic) BOOL isSwitchOn;
@property(copy, nonatomic) id switchChangedBlock;
@end

@interface AWEFeedTableViewController : UIViewController
@property (nonatomic, assign) NSInteger currentPlayIndex;
@end

// 在文件开头的接口声明部分添加
@interface AWESettingsTableViewController : UIViewController
- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;
@end

@interface AWEVideoPlayerController : NSObject
- (void)playerItemDidReachEnd:(id)arg1;
@end

@interface AWETeenModeAlertView : NSObject
- (bool)show;
@end

@interface AWETeenModeSimpleAlertView : NSObject
- (bool)show;
@end

%config(generator=internal)

static NSString * const VideoPlayEndedNotiName = @"VideoPlayEndedNotiName";
static NSString * const OpenAutoPlay = @"画集功能";

// 关闭弹窗
%hook UIViewController
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(id)completion {
    if([viewControllerToPresent isKindOfClass:UIAlertController.class]) {
        return;
    }
    %orig;
}
%end

// 自动播放相关
%hook AWEFeedTableViewController
- (BOOL)pureMode {
    return YES;
}

%new
- (void)playNext {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:OpenAutoPlay] == NO) {
        return;
    }
    UITableView *tableView = [self valueForKey:@"_tableView"];
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.currentPlayIndex + 1 inSection:0];
    [tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)_addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playNext) name:VideoPlayEndedNotiName object:nil];
    %orig;
}
%end

%hook AWEVideoPlayerController
- (void)playerItemDidReachEnd:(id)arg1 {
    NSLog(@"--------------------------------");
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlayEndedNotiName object:nil];
    %orig;
}
%end

// 设置界面相关
%hook AWESettingsTableViewController
- (void)refreshView {
    AWEGeneralSettingViewModel *model = [self valueForKey:@"_viewModel"];
    NSMutableArray *sectionArr = [NSMutableArray arrayWithArray:model.sectionDataArray];
    AWESettingSectionModel *secModel = sectionArr[1];
    NSMutableArray *secArr = [NSMutableArray arrayWithArray:secModel.itemArray];
    AWESettingItemModel *lastItem = secArr.lastObject;

    if(![lastItem.title isEqualToString:@"画集功能"]) {
        AWESettingItemModel *item = [[objc_getClass("AWESettingItemModel") alloc] init];
        item.title = @"画集功能";
        item.cellType = 4;
        item.isSwitchOn = [[NSUserDefaults standardUserDefaults] boolForKey:OpenAutoPlay];
        item.switchChangedBlock = ^(BOOL ison) {
            [[NSUserDefaults standardUserDefaults] setBool:ison forKey:OpenAutoPlay];
        };
        
        [secArr addObject:item];
        secModel.itemArray = secArr;
        [sectionArr replaceObjectAtIndex:1 withObject:secModel];
        [model setSectionDataArray:sectionArr];
        [self setValue:model forKey:@"_viewModel"];
    }
    %orig;
}
%end


%hook AWETeenModeAlertView
- (bool)show {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:OpenAutoPlay]) {
        return NO;
    }
    return %orig;
}
%end

%hook AWETeenModeSimpleAlertView
- (bool)show {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:OpenAutoPlay]) {
        return NO;
    }
    return %orig;
}
%end

%ctor {
    NSLog(@"抖音画集 Tweak 已加载");
}