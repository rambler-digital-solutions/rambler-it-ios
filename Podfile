# CocoaPods specs repository URL
source 'https://github.com/cocoapods/Specs.git'
project 'Conferences.xcworkspace'

# The main application target
target 'Conferences' do
    # Dependency management
    pod 'Typhoon', '3.5.1'
    pod 'RamblerTyphoonUtils/AssemblyCollector', '1.5.0'
    
    # Networking
    pod 'AFNetworking', '~> 2.6'
    
    # Data mapping
    pod 'EasyMapping', '~> 0.15'
    
    # Core Data
    pod 'MagicalRecord', '~> 2.3'
    
    # UI
    pod 'PureLayout', '~> 3.0'
    pod 'Nimbus/Models', :git => 'https://github.com/rambler-ios/nimbus'
    pod 'Nimbus/Collections', :git => 'https://github.com/rambler-ios/nimbus'
    pod 'UICollectionViewLeftAlignedLayout', '1.0.1'
    pod 'CrutchKit/Proxying', :git => 'https://github.com/CognitiveDisson/CrutchKit', :tag => '0.0.10'
    pod 'MBCircularProgressBar', '0.3.5'
    
    # Images & Video
    pod 'SDWebImage', '~> 3.7'
    pod 'FLAnimatedImage', '~> 1.0'
    pod 'XCDYouTubeKit', '~> 2.5'
    
    # Navigation
    pod 'RamblerSegues', '1.1.2'
    pod 'ViperMcFlurry', '1.5.2'
    
    # Logging & crash reporting
    pod 'CocoaLumberjack', '~> 2.0'
    pod 'Fabric'
    pod 'Crashlytics'
    
    # Other
    pod 'libextobjc', '~> 0.4'
    pod 'RamblerAppDelegateProxy', '0.0.3'
    
    # Unit tests dependencies
    target 'ConferencesTests' do
        pod 'OCMock', '3.3.1'
        pod 'MMBarricade', '~> 1.0.1'
        pod 'RamblerTyphoonUtils/AssemblyTesting', '1.5.0'
    end
end
