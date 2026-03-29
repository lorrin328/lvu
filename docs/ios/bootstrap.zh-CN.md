# iOS 项目骨架说明

## 核心结论

1. 当前仓库已经包含基于 `SwiftData` 的 SwiftUI 应用骨架。
2. 项目继续按中英双语结构维护，满足首版国际化要求。
3. 现在已经支持在 App 内新建旅行，并在详情页新增行程日和地点。

## 当前结构

- `project.yml`：XcodeGen 工程定义
- `App/`：SwiftUI 源码
- `App/Models/`：SwiftData 模型
- `Resources/en.lproj/Localizable.strings`：英文文案
- `Resources/zh-Hans.lproj/Localizable.strings`：中文文案
- `Resources/Assets.xcassets/`：资源目录

## 已落地页面

- 旅行列表
- 新建旅行
- 行程详情
- 新增行程日
- 新增地点
- 新增路线
- 消费记录
- 新增消费
- 设置

## 已落地模型

- `Trip`
- `ItineraryDay`
- `Place`
- `RoutePlan`
- `Expense`

## 已落地能力

- `TabView` 主导航
- `SwiftData` 模型容器
- 首次启动自动播种样例数据
- 中英双语本地化资源
- 金额与日期格式化

## 在 Mac 上如何生成工程

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

## 当前限制

- 当前 Windows 环境无法编译或运行 iOS App
- 实际运行验证仍需要 macOS + Xcode

## 下一步建议

1. 增加路线编辑
2. 增加消费与旅行的关联
3. 增加截图 OCR 占位流程
4. 把路线说明从自由文本逐步改为结构化字段
