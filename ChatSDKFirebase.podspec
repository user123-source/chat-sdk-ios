Pod::Spec.new do |s|
  s.name             = "ChatSDKFirebase"
  s.version          = "5.2.1"
  s.summary          = "Chat SDK - Mobile messaging framework for iOS"
  s.homepage         = "https://chatsdk.co"
  s.license          = { :type => 'Chat SDK License' }
  s.author           = { "Ben Smiley" => "ben@chatsdk.co" }
  s.source           = { :git => "https://github.com/chat-sdk/chat-sdk-ios.git", :tag => s.version.to_s }
#   s.module_name      = 'ChatSDKFirebase'

  s.platform     = :ios, '11.0'
  s.requires_arc = true
  s.swift_version = "5.0"
  # s.static_framework = true

  s.default_subspec = 'Adapter'
  # s.xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
  
  # s.static_framework = true
  s.pod_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

 s.subspec 'Core' do |s|
  s.source_files = ['ChatSDKFirebase/Core/**/*.{h,m,swift}']
 end

 s.subspec 'Adapter' do |s|

	s.source_files = ['ChatSDKFirebase/Adapter/Classes/**/*.{h,m,swift}']
	
  s.dependency 'Firebase/Auth'
  s.dependency 'Firebase/Database'

  s.dependency 'ChatSDKFirebase/Core' 
	s.dependency 'ChatSDK'
  
  end

 s.subspec 'Upload' do |s|

	s.source_files = ['ChatSDKFirebase/Upload/Classes/**/*.{h,m,swift}']

  s.dependency 'Firebase/Database'
  s.dependency 'Firebase/Storage'
	s.dependency 'ChatSDK'
  # s.dependency 'ChatSDKFirebase/Adapter' 

  end

 s.subspec 'Push' do |s|

	s.source_files = ['ChatSDKFirebase/Push/Classes/**/*.{h,m,swift}']

    s.dependency 'Firebase/Database'
    s.dependency 'Firebase/Messaging'
    s.dependency 'Firebase/Functions'
    s.dependency 'ChatSDK'
    s.dependency 'ChatSDKFirebase/Core' 

  end

 s.subspec 'FirebaseUI' do |s|

	s.source_files = ['ChatSDKFirebase/FirebaseUI/Classes/**/*.{h,m,swift}']

	s.dependency 'ChatSDKFirebase/Adapter'
	s.dependency 'FirebaseUI/Auth'
	s.dependency 'FirebaseUI/Email'
  	s.dependency 'FirebaseUI/Phone'
  	s.dependency 'FirebaseUI/OAuth'
	  s.dependency 'ChatSDKFirebase/Core' 

  end
      
end