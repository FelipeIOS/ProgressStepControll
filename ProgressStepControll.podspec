Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = ‘9.0’
s.name = "ProgressStepControll"
s.summary = "ProgressStepControll para controlar de forma dinamica os steps"
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Felipe Silva" => "felipe.developer90@gmail.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/FelipeIOS/ProgressStepControll"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/FelipeIOS/ProgressStepControll.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"

# 8
s.source_files = "ProgressStepControll/**/*.{swift}"

# 9
s.resources = "ProgressStepControll/**/*.{png,jpeg,jpg,storyboard,xib}"
end
