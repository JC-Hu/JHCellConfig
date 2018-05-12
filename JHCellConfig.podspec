Pod::Spec.new do |s|

 s.name         = "JHCellConfig"
s.version      = "0.0.1"
s.summary      = "A lightweight CellModel for building multiple type cell in UITableView"
s.homepage     = "https://github.com/JC-Hu/JHCellConfig"
s.license      = "MIT"
s.author             = { "JC-Hu" => "jchu_dlcn@icloud.com" }\

s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/JC-Hu/JHCellConfig.git", :tag => s.version }
s.frameworks   =  'Foundation','UIKit'
s.requires_arc = true

s.source_files = 'src/**/*.{h,m,c,mm}'

end
