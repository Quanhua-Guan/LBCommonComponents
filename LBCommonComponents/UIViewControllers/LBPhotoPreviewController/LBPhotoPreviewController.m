//
//  LBPhotoPreviewController.m
//  PerpetualCalendar
//
//  Created by 刘彬 on 2019/7/18.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBPhotoPreviewController.h"
@implementation LBImageObject
@end

@interface LBPhotoPreviewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isHidden;

@end



@implementation LBPhotoPreviewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.isHidden = NO;
    [self configUI];
    [self configAsset];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - 设置UI
- (void)configUI
{
    // 滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:_scrollView];
    
    CGFloat safeAreaInsetsTop = 20;
    if (@available(iOS 11.0, *)) {
        safeAreaInsetsTop = [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.top;
        if(self.navigationController && !self.navigationController.navigationBar.hidden){
            safeAreaInsetsTop += CGRectGetHeight(self.navigationController.navigationBar.frame);
        }
    }else if(self.navigationController && !self.navigationController.navigationBar.hidden){
        safeAreaInsetsTop = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    }
    
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44+safeAreaInsetsTop)];
    _titleView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:_titleView];
    
    // 返回按钮
    UIImage * image = [UIImage imageNamed:@"lbphoto_back"];
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, safeAreaInsetsTop, 44, 44)];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:backBtn];
    
    // 顺序Label
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(_titleView.frame)-200)/2, CGRectGetMinY(backBtn.frame), 200, CGRectGetHeight(backBtn.bounds))];
    _titleLab.font = [UIFont boldSystemFontOfSize:19.0];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.text = [NSString stringWithFormat:@"1/%d",(int)[self.imageObjectArray count]];
    [_titleView addSubview:_titleLab];
    
    // 删除按钮
    image = [UIImage imageNamed:@"lbphoto_delete"];
    UIButton * delBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(_titleView.frame)-CGRectGetHeight(backBtn.frame), CGRectGetMinY(backBtn.frame), CGRectGetHeight(backBtn.frame), CGRectGetHeight(backBtn.frame))];
    [delBtn setImage:image forState:UIControlStateNormal];
    [delBtn setImageEdgeInsets:UIEdgeInsetsMake((CGRectGetHeight([UINavigationBar appearance].bounds)-image.size.height)/2, 0, (CGRectGetHeight([UINavigationBar appearance].bounds)-image.size.height)/2, 0)];
    [delBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:delBtn];
    delBtn.hidden = !_canDeletePhoto;
    
    // 双击
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureCallback:)];
    doubleTap.numberOfTapsRequired = 2;
    [_scrollView addGestureRecognizer:doubleTap];
    
    // 单击
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [_scrollView addGestureRecognizer:singleTap];
}

#pragma mark - 手势处理
- (void)doubleTapGestureCallback:(UITapGestureRecognizer *)gesture
{
    [self resetIndex];
    UIScrollView *scrollView = [_scrollView viewWithTag:100+_index];
    CGFloat zoomScale = scrollView.zoomScale;
    if (zoomScale == scrollView.maximumZoomScale) {
        zoomScale = 0;
    } else {
        zoomScale = scrollView.maximumZoomScale;
    }
    [UIView animateWithDuration:0.35 animations:^{
        scrollView.zoomScale = zoomScale;
    }];
}

- (void)singleTapGestureCallback:(UITapGestureRecognizer *)gesture
{
    self.isHidden = !self.isHidden;
    [UIView animateWithDuration:0.5 animations:^{
        self.titleView.hidden = self.isHidden;
    }];
}


#pragma mark - 删除处理
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)deleteAction
{
    // 移除视图
    NSObject<LBImageProtocol> *image = [self.imageObjectArray objectAtIndex:_index];
    [self deleteAsset];
    [self.imageObjectArray removeObjectAtIndex:_index];
    // 更新索引
    [self resetIndex];
    _titleLab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_index+1,(long)[self.imageObjectArray count]];
    // block
    if (self.assetDeleteHandler) {
        self.assetDeleteHandler(image);
    }
    // 返回
    if (![self.imageObjectArray count]) {
        [self backAction];
    }
}

#pragma mark - 图像加载|移除
- (void)configAsset
{
    NSInteger count = [self.imageObjectArray count];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.bounds) * count, CGRectGetHeight(_scrollView.bounds))];
    // 添加图片|视频
    [self loadAsset:0 totalNum:count];
}

- (void)loadAsset:(NSInteger)assetIndex totalNum:(NSInteger)count
{
    NSObject<LBImageProtocol> *image = [self.imageObjectArray objectAtIndex:assetIndex];
    
    // 用于图片的捏合缩放
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.bounds) * assetIndex, 0, CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds))];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds));
    scrollView.minimumZoomScale = 1.0;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.tag = 100 + assetIndex;
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    if (image.image) {
        imageView.image = image.image;
    }else if (image.imageUrl){
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:image.imageUrl]];
    }
    imageView.clipsToBounds  = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.contentScaleFactor = [[UIScreen mainScreen] scale];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.tag = 1000;
    [scrollView addSubview:imageView];
    
    CGSize imgSize = [imageView.image size];
    CGFloat scaleX = CGRectGetWidth(self.view.bounds)/imgSize.width;
    CGFloat scaleY = CGRectGetHeight(self.view.bounds)/imgSize.height;
    if (scaleX > scaleY) {
        CGFloat imgViewWidth = imgSize.width * scaleY;
        scrollView.maximumZoomScale = CGRectGetWidth(self.view.bounds)/imgViewWidth;
    } else {
        CGFloat imgViewHeight = imgSize.height * scaleX;
        scrollView.maximumZoomScale = CGRectGetHeight(self.view.bounds)/imgViewHeight;
    }
    
    [_scrollView addSubview:scrollView];
    // 处理下一个
    if (assetIndex != count - 1) {
        [self loadAsset:assetIndex + 1 totalNum:count];
    }
    
}

- (void)deleteAsset
{
    // 移除当前视图
    NSInteger tag = 100 + _index;
    UIScrollView * scrollView = [_scrollView viewWithTag:tag];
    [scrollView removeFromSuperview];
    // 更新后面视图的Frame和TAG(箭头内的执行过程)
    // ↓↓↓
    NSInteger count = [self.imageObjectArray count];
    UIScrollView * sv = nil;
    // 记录上一个的信息
    CGRect setRect = scrollView.frame;
    NSInteger setTag = tag;
    // 临时数据存储变量
    CGRect tempRect;
    NSInteger tempTag;
    for (NSInteger i = 1; i < count-_index; i ++) {
        tag ++;
        sv = [_scrollView viewWithTag:tag];
        // 临时存储
        tempRect = sv.frame;
        tempTag = sv.tag;
        // 将上一个数据赋值给sv
        sv.frame = setRect;
        sv.tag = setTag;
        // 将临时存储赋值
        setRect = tempRect;
        setTag = tempTag;
    }
    // ↑↑↑
    // 更新主滚动视图
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.bounds) * (count-1), CGRectGetHeight(_scrollView.bounds))];
}

- (void)resetIndex
{
    CGFloat pageWidth = _scrollView.frame.size.width;
    _index = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:1000];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resetIndex];
    _titleLab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_index + 1,(long)[self.imageObjectArray count]];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
