//
//  AuthsManageViewController.m
//  MBP_MAPP
//
//  Created by 刘彬 on 16/5/13.
//  Copyright © 2016年 刘彬. All rights reserved.
//

#import "LBWebViewController.h"

@interface LBWebViewController ()
@property(nonatomic,strong)NSString *urlString;

@end

@implementation LBWebViewController
- (instancetype)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        _urlString = urlString;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.customTitle;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    
    _webView = [[WKWebView alloc] init];
    _webView.layer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _webView.navigationDelegate = self;
    
        
    [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:NULL];
    
    _loadingProgressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    _loadingProgressView.progressTintColor = [UIColor greenColor];
    _loadingProgressView.trackTintColor = [UIColor whiteColor];
    //导航栏自定义的话UIScrollView内容将不实用系统的自动向下偏移
    if ([self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault]) {
        _webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetMaxY(self.navigationController.navigationBar.frame));
        _loadingProgressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 8);
    }else{
        _webView.frame = self.view.bounds;
        _loadingProgressView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), CGRectGetWidth(self.view.bounds), 8);
    }
    
    [self.view addSubview:_webView];
    [self.view addSubview:_loadingProgressView];
    
    CATextLayer *hostLPromptLayer = [[CATextLayer alloc] init];
    hostLPromptLayer.frame = CGRectMake(0, 10, CGRectGetWidth(_webView.bounds), 20);
    hostLPromptLayer.wrapped = YES;
    hostLPromptLayer.contentsScale = [UIScreen mainScreen].scale;
    
    UIFont *font = [UIFont systemFontOfSize:12];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    hostLPromptLayer.font = fontRef;
    hostLPromptLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    hostLPromptLayer.foregroundColor = [UIColor grayColor].CGColor;
    hostLPromptLayer.alignmentMode = kCAAlignmentCenter;
    [_webView.layer insertSublayer:hostLPromptLayer atIndex:0];
    
    
    if (_showFunctionMenu) {
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        backBtn.contentMode = UIViewContentModeScaleAspectFit;
        [backBtn setImage:[UIImage imageNamed:@"ic_back.png"] forState:UIControlStateNormal];
        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn addTarget:self
                    action:@selector(goBack:)
          forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *forwardBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        [forwardBtn setImage:[UIImage imageNamed:@"ic_forward.png"] forState:UIControlStateNormal];
        forwardBtn.backgroundColor = [UIColor clearColor];
        [forwardBtn addTarget:self
                       action:@selector(goForward:)
             forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        UIBarButtonItem *forwardItem = [[UIBarButtonItem alloc]initWithCustomView:forwardBtn];
        self.navigationItem.rightBarButtonItems = @[refreshItem,forwardItem,backItem];
    }
    
    [_webView loadRequest:request];
    
}

-(void)setCustomTitle:(NSString *)customTitle{
    _customTitle = customTitle;
    self.title = customTitle;
}



- (void)goBack:(UIButton*)sender
{
    if ([_webView canGoBack]) {
        [_webView goBack];
        
    }
}
-(void)goForward:(UIButton *)sender{
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}
- (void)refresh:(UIButton*)sender
{
    [_webView reload];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"estimatedProgress"]) {
        [_loadingProgressView setProgress:_webView.estimatedProgress animated:YES];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//页面开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _loadingProgressView.hidden = NO;
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    _loadingProgressView.hidden = YES;
    _loadingProgressView.progress = 0;
    if (!self.customTitle.length) {
        self.title = webView.title;
    }
}
//页面加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    _loadingProgressView.hidden = YES;
    _loadingProgressView.progress = 0;
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"] && [[UIApplication sharedApplication] openURL:navigationAction.request.URL]){
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        if (_showFunctionMenu) {
            CATextLayer *hostLPromptLayer = (CATextLayer *)[webView.layer.sublayers firstObject];
            hostLPromptLayer.string = [NSString stringWithFormat:@"网页由 %@ 提供",navigationAction.request.URL.host];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}



-(UIImage *)changeImage:(UIImage *)image toColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)dealloc{
    [_webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}


@end
