#
#  Be sure to run `pod spec lint gsafety-cocopodsTest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "gsafetyCocopodsTest"
  spec.version      = "0.0.14"
  spec.summary      = "this is a test of gsafety-cocopodsTest."
  spec.description  = <<-DESC
			I just wants test it, I do not know weather it will success
                   DESC

  spec.homepage     = "https://github.com/xuyonglin1/gsafety-cocopodsTest.git"
 
  spec.license      = "MIT"
 
  spec.author       = { "xuyonglin" => "504440913@qq.com" }
  spec.platform     = :ios, "12.0"
  spec.swift_version = "5"

  spec.source       = { :git => "https://github.com/xuyonglin1/gsafety-cocopodsTest.git", :tag => spec.version }

  spec.source_files  = "Source/**/*.{h,swift}"
  
  spec.resources    = 'Source/Resources/Image/*.{jpg,mp4,png}'
  spec.resource_bundles = { 
	'PhotoPickerResources' => ['Source/Sections/Media/Album/AlbumPlug/PhotoPickerResources.bundle/*.{jpg,png}'],
	'WMCameraResource' => ['Source/Sections/Media/Camera/VideoPlug/WMCameraResource.bundle/*.{jpg,png}'],
	'WXXImage' => ['Source/Sections/File/SandboxFileManager/image/WXXImage.bundle/*.{jpg,png}']
  }

  #  依赖frameworks
  spec.frameworks = 'Foundation','UIKit','CoreLocation','Photos', 'AVFoundation', 'MessageUI'
  spec.dependency 'Alamofire'
  spec.dependency 'HandyJSON'
  spec.dependency 'SnapKit'

end
