# AwemeHook
抖音的hook教程
 AwemeHook 开源库使用指南

 目录
1. 环境准备  
2. 核心工具链  
3. 快速上手  
   - Frida Hook 示例  
   - Block 参数解析技巧  
4. 高级技巧  
5. 注意事项

---

 1. 环境准备
 工具  版本要求  安装命令 

 macOS  12.0+   
 Xcode  14.0+  `xcodeselect install` 
 越狱设备  iOS 15.0+   
 MonkeyDev  2.0.0+  `brew install monkeydev` 

---# AwemeHook
抖音的hook教程
 AwemeHook 开源库使用指南

 目录
1. 环境准备  
2. 核心工具链  
3. 快速上手  
   - Frida Hook 示例  
   - Block 参数解析技巧  
4. 高级技巧  
5. 注意事项

---

 1. 环境准备
 工具  版本要求  安装命令 

 macOS  12.0+   
 Xcode  14.0+  `xcodeselect install` 
 越狱设备  iOS 15.0+   
 MonkeyDev  2.0.0+  `brew install monkeydev` 

---

 2. 核心工具链
 🔧 MonkeyDev 安装配置bash
 安装 MonkeyDev
brew install monkeydev

 创建工程模板
monkeydev create -name AwemeHookDemo -proj AwemeHookDemo

 启用 Frida 支持
open -a Xcode AwemeHookDemo.xcodeproj
🔍 Reveal 调试集成
1. 在 `Build Phases` 添加 `Run Script`:bash
/Applications/Reveal.app/Contents/Resources/reveal-macOS.sh
2. 运行时自动注入调试器

---

 3. 快速上手
 🎯 Frida Hook 示例javascript
// hook AWESettingsTableViewController 的 refreshView 方法
frida.attach('com.ss.android.ugc.aweme', {
  onMessage: function(msg) {
    console.log('$ RefreshView called with:', msg.args0);
  },
  code: `
    ObjC.classes.AWESettingsTableViewController.prototype.refreshView = function() {
      this.$super.refreshView();
      console.log('$ Custom refresh logic');
    };
  `
});
🔍 Block 参数解析技巧
 传统方案（Debugserver + LLDB）lldb
(lldb) image list -o | grep AWESettingsItemModel
(lldb) br set -n AWESettingsItemModel.switchChangedBlock
(lldb) process continue
🚀 优化方案（CTObjectiveCRuntimeAdditions）objc
import <CTObjectiveCRuntimeAdditions.h>

// 获取 block 参数类型
NSArray *paramTypes = CTBlockDescriptionGetParameterTypes(self.switchChangedBlock);

// 打印详细信息
NSLog(@"Block Signature: %@", CTBlockDescriptionGetTypeEncoding(self.switchChangedBlock));
NSLog(@"Parameter Types: %@", paramTypes);
---

 4. 高级技巧
 💎 美化 Block 属性objc
// 原始定义
@property(copy, nonatomic) CDUnknownBlockType switchChangedBlock;

// 优化方案
typedef void (^AWESwitchChangedBlock)(BOOL isSelected);

@interface AWESettingItemModel : NSObject
@property(copy, nonatomic) AWESwitchChangedBlock switchChangedBlock;
@end

// 使用示例
self.switchChangedBlock = ^(BOOL isSelected) {
  NSLog(@"$ Switch state changed to %@", @(isSelected));
};
---

 5. 注意事项
⚠️ 法律风险  
- 越狱设备违反 Apple 官方条款
- 逆向工程可能涉及法律风险
- 仅限测试环境使用

🔒 安全建议  
- 使用 `--no-pull` 参数防止自动注入
- hook 代码需添加 `__attribute__((used)))` 防止优化
- 调试时启用 `Debug executable` 选项

💡 性能优化  
- 优先使用 `dlopen` 方式加载 Frida 脚本
- 避免在主线程执行 heavy-weight hook 操作
- 使用 `FridaScriptFilter` 过滤无关进程

> 📌 文档持续更新：https://github.com/H7ang0/AwemeHook/wiki  
> 📧 技术支持：h7ang0@gmail.com 



 2. 核心工具链
 🔧 MonkeyDev 安装配置bash
 安装 MonkeyDev
brew install monkeydev

 创建工程模板
monkeydev create -name AwemeHookDemo -proj AwemeHookDemo

 启用 Frida 支持
open -a Xcode AwemeHookDemo.xcodeproj
🔍 Reveal 调试集成
1. 在 `Build Phases` 添加 `Run Script`:bash
/Applications/Reveal.app/Contents/Resources/reveal-macOS.sh
2. 运行时自动注入调试器

---

 3. 快速上手
 🎯 Frida Hook 示例javascript
// hook AWESettingsTableViewController 的 refreshView 方法
frida.attach('com.ss.android.ugc.aweme', {
  onMessage: function(msg) {
    console.log('$ RefreshView called with:', msg.args0);
  },
  code: `
    ObjC.classes.AWESettingsTableViewController.prototype.refreshView = function() {
      this.$super.refreshView();
      console.log('$ Custom refresh logic');
    };
  `
});
🔍 Block 参数解析技巧
 传统方案（Debugserver + LLDB）lldb
(lldb) image list -o | grep AWESettingsItemModel
(lldb) br set -n AWESettingsItemModel.switchChangedBlock
(lldb) process continue
🚀 优化方案（CTObjectiveCRuntimeAdditions）objc
import <CTObjectiveCRuntimeAdditions.h>

// 获取 block 参数类型
NSArray *paramTypes = CTBlockDescriptionGetParameterTypes(self.switchChangedBlock);

// 打印详细信息
NSLog(@"Block Signature: %@", CTBlockDescriptionGetTypeEncoding(self.switchChangedBlock));
NSLog(@"Parameter Types: %@", paramTypes);
---

 4. 高级技巧
 💎 美化 Block 属性objc
// 原始定义
@property(copy, nonatomic) CDUnknownBlockType switchChangedBlock;

// 优化方案
typedef void (^AWESwitchChangedBlock)(BOOL isSelected);

@interface AWESettingItemModel : NSObject
@property(copy, nonatomic) AWESwitchChangedBlock switchChangedBlock;
@end

// 使用示例
self.switchChangedBlock = ^(BOOL isSelected) {
  NSLog(@"$ Switch state changed to %@", @(isSelected));
};
---

 5. 注意事项
⚠️ 法律风险  
- 越狱设备违反 Apple 官方条款
- 逆向工程可能涉及法律风险
- 仅限测试环境使用

🔒 安全建议  
- 使用 `--no-pull` 参数防止自动注入
- hook 代码需添加 `__attribute__((used)))` 防止优化
- 调试时启用 `Debug executable` 选项

💡 性能优化  
- 优先使用 `dlopen` 方式加载 Frida 脚本
- 避免在主线程执行 heavy-weight hook 操作
- 使用 `FridaScriptFilter` 过滤无关进程

> 📌 文档持续更新：https://github.com/H7ang0/AwemeHook/wiki  
> 📧 技术支持：h7ang0@gmail.com 

