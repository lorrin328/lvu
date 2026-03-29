# iOS 项目骨架说明

## 核心结论

1. 当前仓库已加入一个可生成的 SwiftUI iOS 工程骨架。
2. 工程从第一版起即按中英双语结构组织。
3. 当前环境无法在本机编译，需在 macOS + Xcode 环境下生成并运行。

## 当前结构

- `project.yml`：XcodeGen 工程定义
- `App/`：SwiftUI 源码
- `Resources/en.lproj/Localizable.strings`：英文文案
- `Resources/zh-Hans.lproj/Localizable.strings`：中文文案
- `Resources/Assets.xcassets/`：资源目录

## 已落地页面骨架

- 旅行列表
- 行程详情
- 消费记录
- 设置

## 已落地模型

- `Trip`
- `Expense`

## 已落地能力

- `TabView` 主导航
- 双语本地化资源
- 旅行卡片示例数据
- 消费记录示例数据
- 金额与日期格式化

## 在 Mac 上怎么生成工程

### Step 1

安装 XcodeGen：

```bash
brew install xcodegen
```

### Step 2

在项目根目录执行：

```bash
xcodegen generate
```

### Step 3

打开生成后的 `LVU.xcodeproj`

### Step 4

选择模拟器并运行

## 下一步建议

1. 接入 SwiftData，替换示例数据
2. 建立 Trip 创建页和编辑页
3. 建立 ItineraryDay 和 Place 模型
4. 建立截图 OCR 流程占位页
