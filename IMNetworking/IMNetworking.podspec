#
#  Be sure to run `pod spec lint IMNetworking.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "IMNetworking"  #存储库名称
  spec.version      = "0.0.1" #版本号，与tag值一致
  spec.summary      = "A short description of IMNetworking."#简介

  spec.description  = <<-DESC
  Protobuf+CocoaAsyncSocket，建立IM基础SDK
                   DESC

  spec.homepage     = "https://github.com/alienJion/IMNetworking"#项目主页，不是git地址
  
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }#开源协议

  spec.author             = { "alienJion" => "alienvvip@126.com" }#作者

  spec.platform     = :ios, "9.0"#支持的平台和版本号

  spec.source       = { :git => "https://github.com/alienJion/IMNetworking.git", :tag => "0.0.1" }

  spec.dependency "ReactiveObjC", "~> 3.1.0" #依赖的第三方库
  spec.dependency "CocoaAsyncSocket"      #依赖的第三方库
  spec.dependency "Protobuf"      #依赖的第三方库

  # spec.source_files  = "**/*/*.{h,m}"
  # spec.frameworks = "UIKit", "Foundation"  #需要导入的frameworks名称，注意不要带上frameworks
  spec.subspec 'IMNetworking' do |ss|
    ss.source_files = "IMNetworking/IMNetworking/Config/PrefixHeader/*","IMNetworking/IMNetworking/Config/Protobuf/*","IMNetworking/IMNetworking/Tools/Manager/*","IMNetworking/IMNetworking/Tools/NetworkTest/*","IMNetworking/IMNetworking/Tools/SocketManager/*"
    ss.framework    = "UIKit"
end

end
