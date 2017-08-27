platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def libraries
  pod 'RxSwift', '3.6.1'
  pod 'RxCocoa', '3.6.1'
  pod 'Moya/RxSwift', '8.0.5'  
end

def test_libraries
  pod 'Quick', '1.1.0'
  pod 'Nimble', '7.0.1'
  pod 'RxTest', '3.6.1'
end

target 'Demo' do
  libraries
end

target 'DemoTests' do
  libraries
  test_libraries
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
