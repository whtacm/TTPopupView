Pod::Spec.new do |s|

  s.name         = "TTPopupView"
  s.version      = "0.0.1"
  s.summary      = "自下而上的弹出菜单框，可实现仿微信弹出菜单列表、QQ、知乎等不同样式分享弹出框。"
  s.homepage     = "https://github.com/whtacm/TTPopupView"
  s.license      = "MIT"
  s.author             = { "whtacm" => "whtacm@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/whtacm/TTPopupView.git", :tag => s.version }
  s.source_files = "TTPopupView/**/*.{h,m}"
  s.resource     = "TTPopupView/TTPopupView.bundle"
  s.requires_arc = true

end