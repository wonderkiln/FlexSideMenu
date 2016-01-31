Pod::Spec.new do |s|

    s.name = 'WKAwesomeMenu'
    s.version = '1.0.3'
    s.platform = :ios, '8.0'
    s.license = 'MIT'
    s.homepage = 'https://github.com/wonderkiln/WKAwesomeMenu'
    s.author = { 'Adrian Mateoaea' => 'adrianitech@gmail.com' }
    s.source = { :git => 'https://github.com/wonderkiln/WKAwesomeMenu.git', :tag => s.version.to_s }
    s.summary = 'Awesome side menu for iOS written in Swift'

    s.requires_arc = true
    s.source_files = 'WKAwesomeMenu/*.{swift}'

end
