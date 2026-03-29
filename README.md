# LVU

一个面向旅游计划与行程管理的 iOS 应用项目。

An iOS app project for travel planning and itinerary management.

## 项目定位 / Project Positioning

- 目标平台 / Target platform: iOS
- 核心场景 / Core scenario: 旅游计划、行程组织、路线协同 / Trip planning, itinerary organization, and route coordination
- 工作方式 / Working mode: 基于 GitHub 的持续迭代 / Iterative development with GitHub version control

## 当前范围 / Current Scope

1. 明确产品需求与核心流程 / Define product requirements and core user flows
2. 搭建 iOS 项目结构 / Set up the iOS project structure
3. 做出首个可用版本 / Build the first usable version
4. 持续优化功能与体验 / Iterate features and experience over time

## 语言策略 / Language Strategy

- 说明文档：中文、英文双语维护
- iOS App：首版支持简体中文和英文

## 产品文档 / Product Docs

### 中文

- [MVP 需求文档](docs/product/prd-mvp.zh-CN.md)
- [信息架构与优先级](docs/product/information-architecture.zh-CN.md)

### English

- [MVP PRD](docs/product/prd-mvp.md)
- [Information Architecture and MVP Priority](docs/product/information-architecture.md)

## Project Status / 项目状态

### 中文

- [项目进展状态](docs/project/status.zh-CN.md)

### English

- [Project Status](docs/project/status.md)

## iOS Skeleton / iOS 骨架

### 中文

- [iOS 项目骨架说明](docs/ios/bootstrap.zh-CN.md)

### English

- [iOS App Skeleton Notes](docs/ios/bootstrap.md)

## Stage Testing / 阶段测试

### 中文

- [阶段性测试清单](docs/testing/stage-checklist.zh-CN.md)

### English

- [Stage Test Checklist](docs/testing/stage-checklist.md)

## Project Bootstrap

This repository uses `XcodeGen` to generate the Xcode project.

```bash
xcodegen generate
```

## Collaboration Flow

### 中文

1. 通过 Issue 模板创建需求或缺陷。
2. 使用分支开发并提交 Pull Request。
3. 在 PR 中填写变更摘要、验证方式和风险说明。
4. 合并前由 CI 自动执行基础构建检查。

### English

1. Create work items using issue templates (feature/bug).
2. Implement changes in a branch and open a pull request.
3. Fill PR summary, validation notes, and risks.
4. CI runs baseline build checks before merge.
