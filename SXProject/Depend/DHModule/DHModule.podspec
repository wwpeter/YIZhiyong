#
# Be sure to run `pod lib lint DHModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DHModule'
  s.version          = '1.1.8'
  s.summary          = '路由、协议解耦框架，支持Objective-C、Swift '

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#   s.description      = <<-DESC
# TODO: Add long description of the pod here.
#                        DESC

  s.homepage         = 'https://cigitlab.slan-health.com/app-template/DHModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '王威' => '1091695310@qq.com' }
  s.source           = { :git => 'hhttps://cigitlab.slan-health.com/app-template/DHModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }

  #配置Swift版本号
  s.swift_version = '5.0'

  # s.resource_bundles = {
  #   'DHModule' => ['DHModule/Assets/*.png']
  # }

  #配置子模块
  s.subspec 'Protocol' do |ss|
    ss.source_files = 'DHModule/Classes/Protocol/*.*'
    ss.public_header_files =  "DHModule/Classes/Protocol/*.h"
  end

  s.subspec 'Router' do |ss|
    ss.source_files = 'DHModule/Classes/Router/*.*'
    ss.public_header_files = "DHModule/Classes/Router/*.h"
  end

  s.subspec 'Manager' do |ss|
    ss.dependency 'DHModule/Protocol'
    ss.source_files = 'DHModule/Classes/Manager/*.*'
    ss.public_header_files =  "DHModule/Classes/Manager/DHModuleManager.h"
  end

  s.subspec 'Module' do |ss|
    ss.dependency 'DHModule/Protocol'
    ss.dependency 'DHModule/Manager'
    ss.dependency 'DHModule/Router'
    ss.source_files = 'DHModule/Classes/Module/*.*'
    ss.public_header_files =  "DHModule/Classes/Module/{DHAppDelegate.h,DHModuleClass.h}"
  end

  s.source_files  = 'DHModule/Classes/*.*'
  s.public_header_files = 'DHModule/Classes/DHModule.h'

  #s.private_header_files = 'DHModule/Classes/Manager/{DHImplementObject,DHServiceManager}.h'

end
