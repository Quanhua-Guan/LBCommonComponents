Pod::Spec.new do |s|
  s.name             = 'LBCommonComponents'
  s.version          = '1.1.0'
  s.summary          = '强大的项目基本工具类。'
  s.description      = '项目中用到的让开发更快速的一些UI宏定义（如界面的安全区域）、函数宏（比如weak）、系统宏（比如系统版本），以及MethodSwizzling、类型安全、NSArray超界插入nil防crash、字典插入nil防crash、取顶部ViewController、UIButton的blockHandle、图片修改颜色（减小项目容量）、UIView的深拷贝、时间换算工具、UIView布局属性获取等。'
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
    
    ss.subspec 'NSObject+TypeSafe' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSObject+Safe/NSObject+LBTypeSafe.{h,m}'
    end
    
    ss.subspec 'NSNull+Safe' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSObject+Safe/NSNull+LBSafe.{h,m}'
    end
    
    ss.subspec 'NSArray+Safe' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSObject+Safe/NSArray+LBSafe.{h,m}'
    end
    
    ss.subspec 'NSDictionary+Safe' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSObject+Safe/NSDictionary+LBSafe.{h,m}'
    end
    
    ss.subspec 'UIButton+Action' do |sss|
      sss.source_files = 'LBCommonComponents/Category/UIButton+Action/**/*.{h,m}'
    end

    ss.subspec 'UIImage+Color' do |sss|
      sss.source_files = 'LBCommonComponents/Category/UIImage+Color/**/*.{h,m}'
    end
    
    ss.subspec 'NSDate+ToString' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSDate+ToString/**/*.{h,m}'
    end

    ss.subspec 'NSString+ToDate' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSString+ToDate/**/*.{h,m}'
    end

    ss.subspec 'UIView+Geometry' do |sss|
      sss.source_files = 'LBCommonComponents/Category/UIView+Geometry/**/*.{h,m}'
    end
    
    ss.subspec 'NSObject+TopViewController' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSObject+TopViewController/**/*.{h,m}'
    end
    
    ss.subspec 'NSObject+MethodSwizzling' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSObject+MethodSwizzling/**/*.{h,m}'
    end
  end
  
  s.subspec 'Base' do |ss|
    ss.subspec 'Views' do |sss|
      sss.source_files = 'LBCommonComponents/Base/Views/**/*.{h,m}'
    end
  end
end
