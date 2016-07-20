Pod::Spec.new do |spec|
  spec.name         = 'EZKit'
  spec.version      = '0.0.6'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/iphone5s/EZKit'
  spec.authors      = { 'Ezreal' => '453742103@qq.com' }
  spec.summary      = 'EZKit for ios'
  spec.source       = { :git => 'https://github.com/iphone5s/EZKit.git', :tag => spec.version }
  spec.source_files = 'EZKit/EZKit/*'
  spec.platform     = :ios, '7.0'
  spec.requires_arc = true
  spec.dependency 'Masonry'
  spec.dependency 'FCUUID'
  spec.dependency 'pop'
  spec.dependency 'FMDB'
  spec.dependency 'MBProgressHUD'
  spec.dependency 'AFNetworking'

  spec.subspec 'Foundation' do |specSub|
    specSub.requires_arc = false
    specSub.compiler_flags = '-ObjC'
    specSub.source_files = 'EZKit/EZKit/**/*_MRC*'
  end

end
