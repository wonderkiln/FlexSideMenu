Pod::Spec.new do |spec|

    spec.name = 'WKAwesomeMenu'
    spec.version = '2.0.0'
    spec.platform = :ios, '9.0'
    spec.license = { :type => 'MIT', :file => 'LICENSE' }
    spec.homepage = 'https://github.com/wonderkiln/WKAwesomeMenu'
    spec.author = { 'WonderKiln' => 'admin@wonderkiln.com' }
    spec.source = { :git => 'https://github.com/wonderkiln/WKAwesomeMenu.git', :tag => 'v2.0.0' }
    spec.summary = 'Awesome side menu for iOS written in Swift'

    spec.requires_arc = true
    spec.source_files = 'WKAwesomeMenu/*.{swift}'

end
