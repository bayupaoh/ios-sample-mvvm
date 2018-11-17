# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

def shared_pods
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxAlamofire'
    
    pod 'RealmSwift' #, '~> 3.1.0'
    pod 'Alamofire' #, '4.7.3'
    pod 'SwiftyJSON' #, '~> 3.0.0'
    pod 'ISO8601' #, '~> 0.5.2'
end

target 'SuitMovieMvvm' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    shared_pods
    
    pod 'SwiftDate', '4.4.1'
    pod 'SVProgressHUD'
    pod 'SVPullToRefresh'
    
    target 'SuitMovieMvvmTests' do
        inherit! :search_paths
        pod 'RxBlocking'
        pod 'RxTest'
    end
end
