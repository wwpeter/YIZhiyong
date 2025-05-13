# DHModule

[![CI Status](https://img.shields.io/travis/王威/DHModule.svg?style=flat)](https://travis-ci.org/王威/DHModule)
[![Version](https://img.shields.io/cocoapods/v/DHModule.svg?style=flat)](https://cocoapods.org/pods/DHModule)
[![License](https://img.shields.io/cocoapods/l/DHModule.svg?style=flat)](https://cocoapods.org/pods/DHModule)
[![Platform](https://img.shields.io/cocoapods/p/DHModule.svg?style=flat)](https://cocoapods.org/pods/DHModule)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DHModule is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DHModule'
```

## Author

王威, 1091695310@qq.com

## License

DHModule is available under the MIT license. See the LICENSE file for more info.

## The sample

   1、当模块中需要有接口需要向外暴露的时候用ServiceProtocol
   
   @objc public protocol IDHHomePageSupport: DHServiceProtocol {

    /// 首页willAppear时的处理
    func homePageWillAppear(controller: UIViewController, animated: Bool)
    
    /// 首页willDisappear时的处理
    func homePageWillDisappear(controller: UIViewController, animated: Bool)
}

通过遵守DHServiceProtocol的协议来实现对模块中接口的暴露（函数属性都可以）,

这里是注册：

（1）Swift 带ServiceProtocol的注册

DHModule.registerService(IDHHomePageSupport.self, implClass: 《这个类是当前遵守暴漏接口的协议IDHHomePageSupport》)

 （2）Swift实现
 
     DHRouter.registerURLPattern("对应定义的key") { (_) -> Any? in
            let controller = DCGroupListVC()
            controller.hidesBottomBarWhenPushed = true
            return controller
        }
        
（3）OC 实现
       
  [DHRouter registerURLPattern:@"imou://lechange/test?value=123&number=0" toHandler:^(NSDictionary *routerParameters) {
        DHRouterCompletionHandler handler = routerParameters[DHRouterParameterCompletion];
        if (handler) {
            handler(@"Call native registerTest");
        }
    }];

这里是调用：

（1）OC实现

    UIViewController *vc = [DHRouter objectForURL:@"/lechange/video/playLiveVC" withUserInfo: userInfo];
    vc.hidesBottomBarWhenPushed = YES;
    vc.automaticallyAdjustsScrollViewInsets = NO;
    DHNavigationController *nav = (DHNavigationController *)self.selectedViewController;

（2）Swift实现

    if let controller = DHRouter.object(forURL: "/lechange/video/playLiveVC", withUserInfo: userInfo) as? UIViewController {
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
这里是调用ServiceProtocol 暴露的接口

(1)Swift的实现

let deviceListManager = DHModule.impl(forService: IDHDeviceListManager.self) as? IDHDeviceListManager
这样就取到了自己写的protocol 协议，可以进行访问它的属性、函数等等

（2）OC实现

    id<IDHDeviceListManager> listManager = [DHModule implForService:@protocol(IDHDeviceListManager)];
    DHORMDeviceObject *object = [listManager getDeviceWithDeviceId:devcieId];
