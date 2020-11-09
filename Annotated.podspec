Pod::Spec.new do |s|
  s.name         = "Annotated"
  s.version      = "0.1.0"
  s.summary      = "Easy String Annotation"
  s.description  = <<-DESC
    Annotate your Strings, render them in NSAttributedString or Text
  DESC
  s.homepage     = "https://github.com/jegnux/Annotated"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Jérôme Alves" => "j.alves@me.com" }
  s.social_media_url   = ""
  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "11.0"
  s.source       = { :git => "https://github.com/jegnux/Annotated.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
