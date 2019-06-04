platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def libraries
  pod 'RxSwift', '~> 4.5'
  pod 'RxCocoa', '~> 4.5'
  pod 'Moya/RxSwift', '~> 12.0'
end

def test_libraries
  pod 'Quick', '~> 2.0'
  pod 'Nimble', '~> 8.0'
  pod 'RxTest', '~> 4.5'
end

target 'Demo' do
  libraries
end

target 'DemoTests' do
  libraries
  test_libraries
end
