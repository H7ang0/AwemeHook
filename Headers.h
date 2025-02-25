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