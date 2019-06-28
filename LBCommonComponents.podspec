Pod::Spec.new do |s|
  s.name             = 'LBCommonComponents'
  s.version          = '0.1.0'
  s.summary          = 'CommonComponents of my project.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com'
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
    ss.dependency 'LBCommonComponents/Macros'

    ss.subspec 'NSNull+InternalNullExtention' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSNull+InternalNullExtention/**/*.{h,m}'
    end
    
    ss.subspec 'NSDate+ToString' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSDate+ToString/**/*.{h,m}'
    end

    ss.subspec 'NSString+ToDate' do |sss|
      sss.source_files = 'LBCommonComponents/Category/NSString+ToDate/**/*.{h,m}'
    end

    ss.subspec 'UIColor+ConvertToImage' do |sss|
      sss.source_files = 'LBCommonComponents/Category/UIColor+ConvertToImage/**/*.{h,m}'
    end
  end

   
  s.subspec 'NSObjects' do |ss|
    ss.dependency 'LBCommonComponents/Macros'

    ss.subspec 'LBCustemPresentTransitions' do |sss|
      sss.source_files = 'LBCommonComponents/NSObjects/LBCustemPresentTransitions/**/*'
    end

    ss.subspec 'LBEncrypt' do |sss|
      sss.source_files = 'LBCommonComponents/NSObjects/LBEncrypt/**/*'
    end
  end

  s.subspec 'UIViewControllers' do |ss|
    ss.dependency 'LBCommonComponents/Macros'
    ss.dependency 'LBCommonComponents/NSObjects/LBCustemPresentTransitions'

    ss.subspec 'LBItemsSelectViewController' do |sss|
      sss.source_files = 'LBCommonComponents/UIViewControllers/LBItemsSelectViewController/**/*'
    end
  
    ss.subspec 'LBWebViewController' do |sss|
       sss.source_files = 'LBCommonComponents/UIViewControllers/LBWebViewController/**/*.{h,m}'
       sss.resource = 'LBCommonComponents/UIViewControllers/LBWebViewController/**/*.png'
    end

    ss.subspec 'LBAlertController' do |sss|
      sss.source_files = 'LBCommonComponents/UIViewControllers/LBAlertController/**/*'
    end
  end


  s.subspec 'UIViews' do |ss|
    ss.dependency 'LBCommonComponents/Macros'

    ss.subspec 'UIViewInit' do |sss|
      sss.source_files = 'LBCommonComponents/UIViews/UIViewInit/**/*'
    end

   ss.subspec 'LBCodeGetButton' do |sss|
      sss.source_files = 'LBCommonComponents/UIViews/LBCodeGetButton/**/*'
    end

    ss.subspec 'LBFunctionalTextField' do |sss|
      sss.source_files = 'LBCommonComponents/UIViews/LBFunctionalTextField/**/*'
    end
   
   ss.subspec 'LBTitleAndInputCell' do |sss|
      sss.dependency 'LBCommonComponents/UIViews/LBFunctionalTextField'
      sss.source_files = 'LBCommonComponents/UIViews/LBTitleAndInputCell/**/*'
   end

   ss.subspec 'LBPlaceholderTextView' do |sss|
      sss.source_files = 'LBCommonComponents/UIViews/LBPlaceholderTextView/**/*'
   end

   ss.subspec 'LBCodeView' do |sss|
      sss.source_files = 'LBCommonComponents/UIViews/LBCodeView/**/*'
   end

  end

end
