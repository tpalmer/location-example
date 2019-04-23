# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'LocationExample' do

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LocationExample
  pod 'RealmSwift'
  pod 'BuddyBuildSDK'
  pod 'SwiftLint'
  pod 'SwiftyBeaver'

  target 'LocationExampleTests' do
    inherit! :search_paths
    # Pods for testing

    pod 'Quick'
    pod 'Nimble'
    pod 'Nocilla', git: 'git@github.com:pcantrell/Nocilla.git', branch: 'null-annotations'
    pod 'SwiftyBeaver'
  end

  target 'LocationExampleFeatures' do
    inherit! :search_paths
    # Pods for UI testing

    pod 'KIF'
    pod 'Nocilla', git: 'git@github.com:pcantrell/Nocilla.git', branch: 'null-annotations'
  end
end
