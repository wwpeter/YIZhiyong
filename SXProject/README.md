# SXProject
扫地机 iOS 项目源代码。

## 概览

- 语言： Swift 5.5
- 开发模式：MVVM
- 数据库：UserDefaults + @UserDefault
- 网络： Moya
- 代码规范：swiftlint
- 资源管理： swiftgen

## 注意事项

* 不要使用 Objective-C，合作方 SDK 除外；
* 不要导入额外的第三方代码；
* 项目提交时，需解决完所有⚠️(第三方的⚠️除外)；
* 使用 git-flow 工作流方式，合并分支为 develop。；
* 严格遵循编码规范（如禁止滥用缩写，私有方法和属性，请使用 private 等，Swiftlint 会提示不规范的地方。）；
* 使用 MVVM 模式
* 尽量使用 UICollectionView 及 UICollectionViewCompositionalLayout 完成复杂页面的布局（可参考我的/设置页面）。
* 使用 SwiftGen 管理资源文件
* 遇到问题，及时反馈获取帮助。
