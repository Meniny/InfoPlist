Pod::Spec.new do |s|
  s.name             = "InfoPlist"
  s.version          = "1.2.0"
  s.summary          = "A Info.plist assistant for Cocoa/Cocoa Touch."

  s.homepage         = "https://github.com/Meniny/InfoPlist"
  s.license          = 'MIT'
  s.author           = { "Meniny" => "Meniny@qq.com" }
  s.source           = { :git => "https://github.com/Meniny/InfoPlist.git", :tag => s.version.to_s }
  s.social_media_url = 'https://meniny.cn/'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'InfoPlist/**/*'
  s.public_header_files = 'InfoPlist/**/*.h'
  s.ios.frameworks = 'Foundation', 'UIKit'
  s.osx.frameworks = 'Cocoa'
  s.tvos.frameworks = 'Foundation'
  s.watchos.frameworks = 'Foundation'
end
