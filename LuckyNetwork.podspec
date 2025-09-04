#
# Be sure to run `pod lib lint LuckyNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LuckyNetwork'
  s.version          = '1.3.2'
  s.summary          = 'A short description of LuckyNetwork.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/JunkyTang/LuckyNetwork'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lucky' => '921969987@qq.com' }
  s.source           = { :git => 'https://github.com/JunkyTang/LuckyNetwork.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '13.0'
  s.swift_version = '6.0'
  s.source_files = 'LuckyNetwork/Classes/**/*'
  
  s.subspec "Core" do |core|
      core.source_files = 'LuckyNetWork/Classes/Core/**/*'
      core.dependency 'Alamofire', '~> 5.10'
      core.dependency 'LuckyPropertyWrapper', '~> 0.1'
  end
  
  s.subspec "Recorder" do |recorder|
      recorder.source_files = 'LuckyNetWork/Classes/Recorder/**/*'
      recorder.dependency 'LuckyNetwork/Core'
  end
  
  
  
  
  
end
