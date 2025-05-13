//
//  TabBarController.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/2.
//
//  根tabBar控制器

import UIKit

enum TabBarModule: CaseIterable {
    case home
    case my
}
extension TabBarModule {
    var controller: UIViewController {
        switch self {
        case .home:
            if kShowHhtPage == true {
                return setUpChild(HomeController(),  "首页", AssetImages.home.image, AssetImages.homeSel.image)
            } else {
                return setUpChild(HomePageVC(),  "首页", AssetImages.home.image, AssetImages.homeSel.image)
            }
          
        case .my:
            return setUpChild(MyController(),  "我的", AssetImages.my.image, AssetImages.mySel.image)
        }
    }
}

class TabBarController: UITabBarController {

//    let playerView = MusicPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加控制器
        let modules = TabBarModule.allCases
        setViewControllers(modules.map { $0.controller }, animated: false)
        
        // 设置tab外观
        tabBar.isTranslucent = false
        tabBar.backgroundImage = AssetImages.write.image
        tabBar.backgroundColor = .white
        
        // 创建一个字典来设置字体属性
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)]
        let attributesSel = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)]
        // 将字体属性应用于所有的 UITabBarItem
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attributesSel, for: .selected)
        
//        self.selectedIndex = 1
      
    }
    
    func refresh() {
        
    }
}

private func setUpChild(_ rootViewcontroller: UIViewController, _ title: String, _ image: UIImage, _ selectedImage: UIImage) -> NavigationController {
    let con = NavigationController(rootViewController: rootViewcontroller)
    con.tabBarItem.title = title
    con.tabBarItem.image = image
    con.tabBarItem.selectedImage = selectedImage
    return con
}
