
Pod::Spec.new do |spec|

  spec.name         = "mylib4"
  spec.version      = "0.0.1"
  spec.summary      = "我的代码库"
  spec.description  = "我的代码库desc"

  spec.homepage     = "https://github.com/tianyang828/mylib4"

  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  spec.author             = { "tianyang" => "tianyang@huatu.com" }
  # Or just: spec.author    = "tianyang"
  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"
  # spec.platform     = :ios, "5.0"
  spec.source       = { :git => "https://github.com/tianyang828/mylib4.git", :tag => "0.0.1" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.framework  = "UIKit"
  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
