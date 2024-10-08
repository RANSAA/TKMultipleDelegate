#
# Be sure to run `pod lib lint TKMultipleDelegate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TKMultipleDelegate'
  s.version          = '1.0.1'
  s.summary          = 'iOS实现多代理功能'
  s.description      = <<-DESC
  iOS实现多用户代理功能
                       DESC
  s.homepage         = 'https://github.com/RANSAA/TKMultipleDelegate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sayaDev' => '1352892108@qq.com' }
  s.source           = { :git => 'https://github.com/RANSAA/TKMultipleDelegate.git', :tag => "v#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.13'

  s.source_files = 'TKMultipleDelegate/*'

  ## 隐私清单
  s.resource_bundles = {
      'TKMultipleDelegate' => ['TKMultipleDelegate/PrivacyInfo.xcprivacy']
  }
  
  # s.resource_bundles = {
  #   'TKMultipleDelegate' => ['TKMultipleDelegate/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
