#
#  Be sure to run `pod spec lint iOS-Common.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "iOS-Common"
  s.version      = "0.0.5"
  s.summary      = "A short description of iOS-Common."

  s.description  = <<-DESC
                   A longer description of iOS-Common in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/sora0077/iOS-Common"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "t.hayashi" => "t.hayashi0077+bitbucket@gmail.com" }
  s.platform     = :ios, '7.0'

  s.source       = { :git => "https://github.com/sora0077/iOS-Common.git", :tag => s.version }

  s.source_files  = 'Classes/**/*.{h,m}'
  s.exclude_files = 'iOS-Common/iOS-Common-Info.plist.h'

  # s.public_header_files = 'Classes/**/*.h'

  s.frameworks = 'Accounts'

#  s.libraries = 'xml2'
#  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }

  s.dependency 'AFNetworking'
  s.dependency 'TMCache'
  s.dependency 'libextobjc/EXTScope'
  s.dependency 'Facebook-iOS-SDK'
  s.dependency 'Bolts'
  s.dependency 'Aspects'

  s.requires_arc = true
end
