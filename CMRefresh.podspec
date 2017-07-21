Pod::Spec.new do |s|
  s.name         = "CMRefresh"
  s.version      = "0.0.5"
  s.summary      = "Some util refresh categories for UIScrollView and it's subclasses."
  s.description  = <<-DESC
  Some util refresh categories for UIScrollView and it's subclasses, which write in Objective-C, wish you love it, enjoy the code:D
                   DESC
  s.homepage     = "https://github.com/chucklab/CMRefresh"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Chuck MA" => "chuck@chucklab.com" }
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => "https://github.com/chucklab/CMRefresh.git", :tag => "#{s.version}" }
  s.source_files  = "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.public_header_files = "Classes/**/*.h"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true
end
