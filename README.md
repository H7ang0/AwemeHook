# 抖音画集 Tweak

一个基于 theos 开发的抖音插件，实现自动播放、关闭弹窗等功能。

## 功能特性

- ✨ 自动连续播放视频
- 🚫 关闭各类弹窗提示
- 🔒 关闭青少年模式弹窗
- ⚙️ 设置界面可控制功能开关
- 🔄 支持有根和无根设备

## 逆向分析过程

### 工具准备
- Reveal：分析界面层级和控件结构
- Flex：快速定位关键类和方法
- Frida：动态调试和跟踪方法调用

### 关键类分析
- `AWEFeedTableViewController`: 负责视频列表控制
- `AWEVideoPlayerController`: 视频播放控制器
- `AWESettingsTableViewController`: 设置界面控制器
- `AWETeenModeAlertView`: 青少年模式弹窗

## 安装方法

### 有根设备
1. 添加源并安装
2. 重启抖音应用
3. 进入设置开启功能

### 无根设备
1. 下载无根版本
2. 安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries`
3. 重启抖音应用

## 开发环境

- theos
- iOS 14.0+
- arm64/arm64e 架构

## 使用方法

1. 安装插件后重启抖音
2. 进入设置页面
3. 找到"画集功能"开关
4. 打开开关即可启用全部功能

## 编译方法

```bash
make clean
make package