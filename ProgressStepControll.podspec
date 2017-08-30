Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = ‘9.0’
s.name = "ProgressStepControll"
s.summary = "ProgressStepControll para controlar de forma dinamica os steps"
s.requires_arc = true

s.version = "0.1.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Felipe Silva" => "felipe.developer90@gmail.com" }

s.homepage = "https://github.com/FelipeIOS/ProgressStepControll"

s.source = { :git => "https://github.com/FelipeIOS/ProgressStepControll.git", :tag => "#{s.version}"}

s.framework = "UIKit"

s.source_files = "ProgressStepControll/**/*.{swift}"

s.resources = "ProgressStepControll/**/*.{png,jpeg,jpg,storyboard,xib}"
end
