// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
    internal static let aaaaaa = ColorAsset(name: "AAAAAA")
    internal static let b000 = ColorAsset(name: "b000")
    internal static let b00030 = ColorAsset(name: "b00030%")
    internal static let b00065 = ColorAsset(name: "b00065%")
    internal static let b0008 = ColorAsset(name: "b0008%")
    internal static let b00080 = ColorAsset(name: "b00080%")
    internal static let b0077C020 = ColorAsset(name: "b0077C020%")
    internal static let b0077C04 = ColorAsset(name: "b0077C04%")
    internal static let b0Ac190 = ColorAsset(name: "b0AC190")
    internal static let b16Bebe = ColorAsset(name: "b16BEBE")
    internal static let b2564Ff10 = ColorAsset(name: "b2564FF10")
    internal static let b298Aff = ColorAsset(name: "b298AFF")
    internal static let b364E94 = ColorAsset(name: "b364E94")
    internal static let b459Cf9 = ColorAsset(name: "b459CF9")
    internal static let b459Cf945 = ColorAsset(name: "b459CF945%")
    internal static let b4Bbc4B = ColorAsset(name: "b4BBC4B")
    internal static let b60Eae6 = ColorAsset(name: "b60EAE6 ")
    internal static let b6D2E83 = ColorAsset(name: "b6D2E83")
    internal static let b7A6Ddf = ColorAsset(name: "b7A6DDF")
    internal static let b7Fbbdf = ColorAsset(name: "b7FBBDF")
    internal static let b9232Ec = ColorAsset(name: "b9232EC")
    internal static let b979797 = ColorAsset(name: "b979797")
    internal static let b9Bcbff = ColorAsset(name: "b9BCBFF")
    internal static let b9D2872 = ColorAsset(name: "b9D2872")
    internal static let b9D287240 = ColorAsset(name: "b9D287240%")
    internal static let bacafb9 = ColorAsset(name: "bACAFB9")
    internal static let bbc54C7 = ColorAsset(name: "bBC54C7")
    internal static let bccc = ColorAsset(name: "bCCC")
    internal static let bd5E0Fd = ColorAsset(name: "bD5E0FD")
    internal static let bdc5542 = ColorAsset(name: "bDC5542")
    internal static let bdfeafd = ColorAsset(name: "bDFEAFD")
    internal static let be0E9Fd = ColorAsset(name: "bE0E9FD")
    internal static let be0Eeff = ColorAsset(name: "bE0EEFF")
    internal static let be7E8E9 = ColorAsset(name: "bE7E8E9")
    internal static let be8Efff = ColorAsset(name: "bE8EFFF")
    internal static let bea6360 = ColorAsset(name: "bEA6360")
    internal static let becf2Ff = ColorAsset(name: "bECF2FF")
    internal static let beda646 = ColorAsset(name: "bEDA646")
    internal static let beda7B4 = ColorAsset(name: "bEDA7B4")
    internal static let befefef = ColorAsset(name: "bEFEFEF")
    internal static let bf1F2F3 = ColorAsset(name: "bF1F2F3 ")
    internal static let bf1F6Ff = ColorAsset(name: "bF1F6FF")
    internal static let bf2F4F7 = ColorAsset(name: "bF2F4F7")
    internal static let bf4F4Fb = ColorAsset(name: "bF4F4FB")
    internal static let bf4F5F9 = ColorAsset(name: "bF4F5F9")
    internal static let bf4F5Fc = ColorAsset(name: "bF4F5FC ")
    internal static let bf5F6F7 = ColorAsset(name: "bF5F6F7")
    internal static let bf5F8Ff = ColorAsset(name: "bF5F8FF")
    internal static let bf6F7F9 = ColorAsset(name: "bF6F7F9")
    internal static let bf6F8Fa = ColorAsset(name: "bF6F8FA")
    internal static let bf6Faff = ColorAsset(name: "bF6FAFF ")
    internal static let bf7E4Bf = ColorAsset(name: "bF7E4BF")
    internal static let bf8F8F8 = ColorAsset(name: "bF8F8F8")
    internal static let bf9F9F9 = ColorAsset(name: "bF9F9F9")
    internal static let bfbfbfd = ColorAsset(name: "bFBFBFD")
    internal static let bfcf3E1 = ColorAsset(name: "bFCF3E1")
    internal static let bff000010 = ColorAsset(name: "bFF000010")
    internal static let bff9800 = ColorAsset(name: "bFF9800")
    internal static let bffaa00 = ColorAsset(name: "bFFAA00")
    internal static let bffc519 = ColorAsset(name: "bFFC519")
    internal static let bfff = ColorAsset(name: "bFFF")
    internal static let bfff20 = ColorAsset(name: "bFFF20")
    internal static let bfff5F5 = ColorAsset(name: "bFFF5F5 ")
    internal static let bffffff = ColorAsset(name: "bFFFFFF")
    internal static let be2e2e2 = ColorAsset(name: "be2e2e2")
    internal static let be6e6e6 = ColorAsset(name: "be6e6e6")
    internal static let becf0fc = ColorAsset(name: "becf0fc")
    internal static let bf16363 = ColorAsset(name: "bf16363")
    internal static let bf2 = ColorAsset(name: "bf2")
    internal static let bf8 = ColorAsset(name: "bf8")
    internal static let bfff10 = ColorAsset(name: "bfff10%")
    internal static let bfff50 = ColorAsset(name: "bfff50")
    internal static let bfff64 = ColorAsset(name: "bfff64%")
    internal static let bfff80 = ColorAsset(name: "bfff80%")
    internal static let blogin1 = ColorAsset(name: "blogin1")
    internal static let blogin2 = ColorAsset(name: "blogin2")
    internal static let borigon = ColorAsset(name: "borigon")
    internal static let broom1 = ColorAsset(name: "broom1")
    internal static let broom2 = ColorAsset(name: "broom2")
    internal static let broom3 = ColorAsset(name: "broom3")
    internal static let broom4 = ColorAsset(name: "broom4")
    internal static let kbe0e0e0 = ColorAsset(name: "kbe0e0e0")
    internal static let messageleft = ColorAsset(name: "messageleft")
    internal static let messageright = ColorAsset(name: "messageright")
    internal static let t000 = ColorAsset(name: "t000")
    internal static let t0F1119 = ColorAsset(name: "t0F1119")
    internal static let t2564ff = ColorAsset(name: "t2564ff")
    internal static let t333 = ColorAsset(name: "t333")
    internal static let t532B0B = ColorAsset(name: "t532B0B")
    internal static let t5E6677 = ColorAsset(name: "t5E6677")
    internal static let t666 = ColorAsset(name: "t666")
    internal static let t777 = ColorAsset(name: "t777")
    internal static let t9D2872 = ColorAsset(name: "t9D2872")
    internal static let tc4A264 = ColorAsset(name: "tC4A264")
    internal static let tcfd2D6 = ColorAsset(name: "tCFD2D6")
    internal static let tfbf4E5 = ColorAsset(name: "tFBF4E5")
    internal static let tff0000 = ColorAsset(name: "tFF0000")
    internal static let tffaa00 = ColorAsset(name: "tFFAA00")
    internal static let tfff = ColorAsset(name: "tFFF")
    internal static let taaa = ColorAsset(name: "taaa")
    internal static let tmain = ColorAsset(name: "tmain")
  }
  internal enum Images {
    internal static let aBannerImg1 = ImageAsset(name: "a_banner_img_1")
    internal static let aBannerImg2 = ImageAsset(name: "a_banner_img_2")
    internal static let aBannerImg3 = ImageAsset(name: "a_banner_img_3")
    internal static let aBannerImg4 = ImageAsset(name: "a_banner_img_4")
    internal static let aCompangIcon = ImageAsset(name: "a_compang_icon")
    internal static let aHomeIcon1 = ImageAsset(name: "a_home_icon_1")
    internal static let aHomeIcon2 = ImageAsset(name: "a_home_icon_2")
    internal static let aHomeIcon3 = ImageAsset(name: "a_home_icon_3")
    internal static let aHomeIcon4 = ImageAsset(name: "a_home_icon_4")
    internal static let aLoanIcon1 = ImageAsset(name: "a_loan_icon_1")
    internal static let productCallIocn = ImageAsset(name: "product_call_iocn")
    internal static let productLove0 = ImageAsset(name: "product_love_0")
    internal static let productLove1 = ImageAsset(name: "product_love_1")
    internal static let addCloseEye = ImageAsset(name: "add_close_eye")
    internal static let addHandDeseleced = ImageAsset(name: "add_hand_deseleced")
    internal static let addHandSel = ImageAsset(name: "add_hand_sel")
    internal static let addOpenEye = ImageAsset(name: "add_open_eye")
    internal static let addQrDesel = ImageAsset(name: "add_qr_desel")
    internal static let addQrSel = ImageAsset(name: "add_qr_sel")
    internal static let defaultEmpty = ImageAsset(name: "defaultEmpty")
    internal static let addTopIcon = ImageAsset(name: "add_top_icon")
    internal static let alertViewGround = ImageAsset(name: "alertView_ground")
    internal static let alertClose = ImageAsset(name: "alert_close")
    internal static let appIcon = ImageAsset(name: "app_icon")
    internal static let cellIcon = ImageAsset(name: "cell_icon")
    internal static let cellRight = ImageAsset(name: "cell_right")
    internal static let detailIcon = ImageAsset(name: "detail_icon")
    internal static let diquIcon = ImageAsset(name: "diqu_icon")
    internal static let failIcon = ImageAsset(name: "fail_icon")
    internal static let failSubmit = ImageAsset(name: "fail_submit")
    internal static let fangzhaBack = ImageAsset(name: "fangzha_back")
    internal static let fangzhazhinanIcon = ImageAsset(name: "fangzhazhinan_icon")
    internal static let helpCellIcon = ImageAsset(name: "help_cell_icon")
    internal static let homeBottom1 = ImageAsset(name: "home_bottom_1")
    internal static let homeBottom2 = ImageAsset(name: "home_bottom_2")
    internal static let homeBottom3 = ImageAsset(name: "home_bottom_3")
    internal static let homeBottomCenter = ImageAsset(name: "home_bottom_center")
    internal static let homeBottomLeft = ImageAsset(name: "home_bottom_left")
    internal static let homeBottomRight = ImageAsset(name: "home_bottom_right")
    internal static let homeLaba = ImageAsset(name: "home_laba")
    internal static let homeMoneyGround = ImageAsset(name: "home_money_ground")
    internal static let homeTop1 = ImageAsset(name: "home_top_1")
    internal static let homeTop2 = ImageAsset(name: "home_top_2")
    internal static let leftIcon = ImageAsset(name: "left_icon")
    internal static let moneyIcon = ImageAsset(name: "money_icon")
    internal static let moneySubmit = ImageAsset(name: "money_submit")
    internal static let rightIcon = ImageAsset(name: "right_icon")
    internal static let shenheTongguo = ImageAsset(name: "shenhe_tongguo")
    internal static let shenhezhongIcon = ImageAsset(name: "shenhezhong_icon")
    internal static let sucIcon = ImageAsset(name: "suc_icon")
    internal static let systemIcon = ImageAsset(name: "system_icon")
    internal static let whiteBack = ImageAsset(name: "white_back")
    internal static let yzyIcon = ImageAsset(name: "yzy_icon")
    internal static let deviceDetailDesel = ImageAsset(name: "device_detail_desel")
    internal static let deviceDetailSel = ImageAsset(name: "device_detail_sel")
    internal static let down = ImageAsset(name: "down")
    internal static let iotLoginCheck = ImageAsset(name: "iot_login_check")
    internal static let iotRegistRight = ImageAsset(name: "iot_regist_right")
    internal static let iotReturn = ImageAsset(name: "iot_return")
    internal static let loginSelected = ImageAsset(name: "login_selected")
    internal static let loginStopGif = ImageAsset(name: "login_stop_gif")
    internal static let projectIcon = ImageAsset(name: "project_icon")
    internal static let logo = ImageAsset(name: "Logo")
    internal static let bankCard = ImageAsset(name: "bank_card")
    internal static let bankManager = ImageAsset(name: "bank_manager")
    internal static let cellAddCard = ImageAsset(name: "cell_add_card")
    internal static let cellSettting = ImageAsset(name: "cell_settting")
    internal static let customImg = ImageAsset(name: "custom_img")
    internal static let heandImg = ImageAsset(name: "heand_img")
    internal static let hkRecord = ImageAsset(name: "hk_record")
    internal static let huankImg = ImageAsset(name: "huank_img")
    internal static let jiekImg = ImageAsset(name: "jiek_img")
    internal static let jkRecord = ImageAsset(name: "jk_record")
    internal static let myGroundImg = ImageAsset(name: "my_ground_img")
    internal static let noBankCard = ImageAsset(name: "no_bank_card")
    internal static let requestIcon = ImageAsset(name: "request_icon")
    internal static let serverImg = ImageAsset(name: "server_img")
    internal static let settingImg = ImageAsset(name: "setting_img")
    internal static let navigationBack = ImageAsset(name: "navigationBack")
    internal static let refreshDiscover = ImageAsset(name: "refresh_discover")
    internal static let refreshIcon = ImageAsset(name: "refresh_icon")
    internal static let refreshIcon1 = ImageAsset(name: "refresh_icon_1")
    internal static let refreshIcon2 = ImageAsset(name: "refresh_icon_2")
    internal static let refreshIcon3 = ImageAsset(name: "refresh_icon_3")
    internal static let refreshKiss = ImageAsset(name: "refresh_kiss")
    internal static let refreshLoading1 = ImageAsset(name: "refresh_loading_1")
    internal static let refreshLoading2 = ImageAsset(name: "refresh_loading_2")
    internal static let refreshLoading3 = ImageAsset(name: "refresh_loading_3")
    internal static let refreshNormal = ImageAsset(name: "refresh_normal")
    internal static let refreshWillRefresh = ImageAsset(name: "refresh_will_refresh")
    internal static let home = ImageAsset(name: "home")
    internal static let homeSel = ImageAsset(name: "homeSel")
    internal static let my = ImageAsset(name: "my")
    internal static let mySel = ImageAsset(name: "mySel")
    internal static let nodata = ImageAsset(name: "nodata")
    internal static let startupPageBottom = ImageAsset(name: "startupPage_bottom")
    internal static let startupPageCenter = ImageAsset(name: "startupPage_center")
    internal static let deviceUpdate = ImageAsset(name: "device_update")
    internal static let updateArrow = ImageAsset(name: "update_arrow")
    internal static let updateBg = ImageAsset(name: "update_bg")
    internal static let updateClose = ImageAsset(name: "update_close")
    internal static let updateProgress = ImageAsset(name: "update_progress")
    internal static let write = ImageAsset(name: "write")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
