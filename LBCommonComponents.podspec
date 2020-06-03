Pod::Spec.new do |s|
  s.name             = 'LBCommonComponents'
  s.version          = '1.0.0'
  s.summary          = 'CommonComponents of your project.'
  s.description      = '项目中用到的让开发更快速的一些宏定义，以及常用View的快速初始化方法，和其他转换的工具类。'
  s.homepage         = 'https://github.com/A1129434577/LBCommonComponents'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'A1129434577' => '1129434577@qq.com' }
  s.source           = { :git => 'https://github.com/A1129434577/LBCommonComponents.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'


  s.subspec 'Macros' do |ss|
    ss.source_files = 'LBCommonComponents/Macros/**/*'
    ss.prefix_header_contents = <<-EOS
       #ifdef __OBJC__
       #import "LBSystemMacro.h"
       #import "LBUIMacro.h"
       #import "LBFunctionMacro.h"
       #endif 
    EOS
  end


  s.subspec 'Category' do |ss|
    ss.subspec 'UIView+Copy' do |sss|
      sss.source_files = 'LBCommonComponents/Category/UIView+Copy/**/*.{h,m}'
    end
    
    ss.subspec 'NSObject+LBTypeSafe' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSObject+LBTypeSafe/**/*.{h,m}'
    end
    
    ss.subspec 'UIButton+Action' do |sss|
      sss.source_files = 'LBCommonComponents/Category/UIButton+Action/**/*.{h,m}'
    end
    
    ss.subspec 'NSNull+Safe' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSNull+Safe/**/*.{h,m}'
    end

    ss.subspec 'UIImage+ChangedColor' do |sss|
      sss.source_files = 'LBCommonComponents/Category/UIImage+ChangedColor/**/*.{h,m}'
    end
    
    ss.subspec 'NSDate+ToString' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSDate+ToString/**/*.{h,m}'
    end

    ss.subspec 'NSString+ToDate' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSString+ToDate/**/*.{h,m}'
    end

    ss.subspec 'UIColor+ToImage' do |sss|
      sss.source_files = 'LBCommonComponents/Category/UIColor+ToImage/**/*.{h,m}'
    end

    ss.subspec 'UIView+Geometry' do |sss|
      sss.source_files = 'LBCommonComponents/Category/UIView+Geometry/**/*.{h,m}'
    end

  end
  
  s.subspec 'Base' do |ss|
    ss.subspec 'Views' do |sss|
      sss.source_files = 'LBCommonComponents/Base/Views/**/*.{h,m}'
    end
  end
end
