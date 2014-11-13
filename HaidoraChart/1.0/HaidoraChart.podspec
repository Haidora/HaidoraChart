Pod::Spec.new do |s|
  s.name         = "HaidoraChart"
  s.version      = "1.0"
  s.summary      = "a custom chart fork from(https://github.com/kevinzhow/PNChart)"

  s.description  = <<-DESC
                   A longer description of HaidoraChart in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/Haidora/HaidoraChart"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author             = { "mrdaios" => "mrdaios@gmail.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/Haidora/HaidoraChart.git", :tag => "1.0" }
  s.source_files  = "Source", "Source/**/*.{h,m}"
  s.frameworks = "UIKit", "Foundation", "QuartzCore"
  s.requires_arc = true
end
