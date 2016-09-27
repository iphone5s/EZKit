Pod::Spec.new do |spec|
  spec.name         = 'EZKit'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/iphone5s/EZKit'
  spec.authors      = { 'Ezreal' => '453742103@qq.com' }
  spec.summary      = 'EZKit for ios'
  spec.source       = { :git => 'https://github.com/iphone5s/EZKit.git', :tag => spec.version }
  spec.source_files = 'EZKit/EZKit/**/*'
  spec.platform     = :ios, '7.0'
  spec.requires_arc = true
  spec.dependency 'Masonry'
  spec.dependency 'FCUUID'
  spec.dependency 'pop'
  spec.dependency 'MBProgressHUD', '~> 0.9.2'
  spec.dependency 'YTKNetwork'

  spec.subspec 'SafeCore' do |specSub|
    specSub.source_files = 'EZKit/EZKit/SafeCore/SafeCore/*'
  end

  spec.subspec 'SafeMRC' do |specSub|
    specSub.requires_arc = false
    specSub.compiler_flags = '-ObjC'
    specSub.dependency 'EZKit/SafeCore'
    specSub.source_files = 'EZKit/EZKit/SafeCore/MRC/*'
  end

end
