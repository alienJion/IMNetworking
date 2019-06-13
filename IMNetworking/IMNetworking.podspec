#
#  Be sure to run `pod spec lint IMNetworking.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #



  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  spec.homepage     = "http://EXAMPLE/IMNetworking"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = "MIT (example)"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "alien" => "alienvvip@gmail.com" }
  # Or just: spec.author    = "alien"
  # spec.authors            = { "alien" => "alienvvip@gmail.com" }
  # spec.social_media_url   = "https://twitter.com/alien"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
  # spec.platform     = :ios, "5.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "http://EXAMPLE/IMNetworking.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  





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
