#
#  Be sure to run `pod spec lint gsafety-cocopodsTest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "gsafetyCocopodsTest"
  spec.version      = "0.0.1"
  spec.summary      = "this is a test of gsafety-cocopodsTest."
  spec.description  = <<-DESC
			I just wants test it, I do not know weather it will success
                   DESC

  spec.homepage     = "https://github.com/xuyonglin1/gsafety-cocopodsTest.git"
 
  spec.license      = "MIT"
 
  spec.author       = { "xuyonglin" => "504440913@qq.com" }
  spec.platform     = :ios, "12.0"
  spec.swift_version = "5"

  spec.source       = { :git => "https://github.com/xuyonglin1/gsafety-cocopodsTest.git", :tag => "0.0.1" }


  spec.source_files  = "CocopodTest", "CocopodTest/*"
  # spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"

end
