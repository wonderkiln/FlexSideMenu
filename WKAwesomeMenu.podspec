Pod::Spec.new do |spec|

    spec.name = 'WKAwesomeMenu'
    spec.version = '1.0.3'
    spec.platform = :ios, '8.0'
    spec.license = { :type => 'MIT', :file => 'LICENSE' }
    spec.homepage = 'https://github.com/wonderkiln/WKAwesomeMenu'
    spec.author = { 'WonderKiln' => 'admin@wonderkiln.com' }
    spec.source = { :git => 'https://github.com/wonderkiln/WKAwesomeMenu.git', :tag => 'v1.0.3' }
    spec.summary = 'Awesome side menu for iOS written in Swift'

    spec.requires_arc = true
    spec.source_files = 'WKAwesomeMenu/*.{swift}'

end
