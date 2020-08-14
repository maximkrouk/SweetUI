Pod::Spec.new do |s|
	s.name		= 'SweetUI'
	s.module_name	= 'SweetUI'
	s.version	= '1.0.0-beta.1.1'
	s.summary	= 'Declarative UIKit wrapper inspired by SwiftUI'
	s.swift_version = '5.2'
	s.description	= 'Easy to use declarative UIKit wrapper inspired by SwiftUI'
	s.homepage	= 'https://github.com/maximkrouk/SweetUI'
	s.license	= { :type => 'MIT', :file => 'LICENSE' }
	s.author	= { 'maximkrouk' => 'id.maximkrouk@gmail.com' }
	s.source	= { :git => 'https://github.com/maximkrouk/SweetUI.git', :tag => s.version.to_s }

	s.social_media_url = 'https://twitter.com/maximkrouk'
	s.ios.deployment_target = '10.0'
	s.source_files = 'Sources/SweetUI/**/*'
	s.frameworks = 'UIKit'
	s.dependency 'UICocoa', '~> 1'
end