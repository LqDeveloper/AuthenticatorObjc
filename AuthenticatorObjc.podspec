#
#  Be sure to run `pod spec lint AuthenticatorObjc.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "AuthenticatorObjc"
  spec.version      = "0.0.2"
  spec.summary      = "FaceID,TouchID的验证"
  spec.description  = <<-DESC
                         FaceID,TouchID的验证的工具类
                      DESC
  spec.homepage     = "https://github.com/LqDeveloper/AuthenticatorObjc"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Quan Li" => "1083099465@qq.com" }
  spec.platform     = :ios, "9.0"
  spec.requires_arc = true
  spec.swift_version = '5.0'
  spec.default_subspec = 'Core'
  spec.cocoapods_version = '>= 1.4.0' 
  spec.source       = { :git => "https://github.com/LqDeveloper/AuthenticatorObjc.git", :tag => "#{spec.version}" }

  spec.subspec  'Core' do |sub|
    sub.source_files  = "AuthenticatorObjc/Core/**/*.{h,m}"
    sub.frameworks  = "Foundation"
  end
end
