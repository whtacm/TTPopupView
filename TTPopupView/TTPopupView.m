//
//  TTPopupView.m
//
//
//  Created by Haitao-Wong on 7/6/16.
//  Copyright © 2016 Haitao-Wong. All rights reserved.
//

#import "TTPopupView.h"

@implementation TTPopupView

//-(NSString *)popupTitle{
//    if (!self.popupTitle) {
//        self.popupTitle = @"分享";
//    }
//    return self.popupTitle;
//}


-(NSString *)cancelTitle{
    if (!_cancelTitle) {
        _cancelTitle = @"取消";
    }
    return _cancelTitle;
}

-(UIFont *)popupTitleTextFont{
    if (!_popupTitleTextFont) {
        _popupTitleTextFont =TT_DEFAULT_POPUP_TITLE_TEXT_FONT;
    }
    return _popupTitleTextFont;
}

-(UIColor *)popupTitleTextColor{
    if (!_popupTitleTextColor) {
        _popupTitleTextColor = [UIColor blackColor];
    }
    return _popupTitleTextColor;
}

-(UIFont *)contentTextFont{
    if (!_contentTextFont) {
        _contentTextFont =TT_DEFAULT_CONTENT_TEXT_FONT;
    }
    return _contentTextFont;
}

-(UIColor *)contentTextColor{
    if (!_contentTextColor) {
        _contentTextColor = [UIColor grayColor];
    }
    return _contentTextColor;
}

-(UIFont *)cancelTextFont{
    if (!_cancelTextFont) {
        _cancelTextFont = TT_DEFAULT_CANCEL_TEXT_FONT;
    }
    return _cancelTextFont;
}

-(UIColor *)cancelTextColor{
    if (!_cancelTextColor) {
        _cancelTextColor = TTColor(255, 0, 30);
    }
    return _cancelTextColor;
}


- (CGFloat)animationDuration {
    if (!_animationDuration) {
        _animationDuration = TT_DEFAULT_ANIMATION_DURATION;
    }
    
    return _animationDuration;
}

- (CGFloat)backgroundOpacity {
    if (!_backgroundOpacity) {
        _backgroundOpacity = TT_DEFAULT_BACKGROUND_OPACITY;
    }
    
    return _backgroundOpacity;
}

-(UIWindow *)rootWindow{
    if (_rootWindow==nil) {
        _rootWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _rootWindow.windowLevel       = UIWindowLevelStatusBar;
        _rootWindow.backgroundColor   = [UIColor clearColor];
        _rootWindow.hidden = NO;
    }
    return _rootWindow;
}

-(instancetype)initWithPopupTitle:(NSString *)popupTitle funsTitles:(NSArray<NSString *> *)funsTitles delegate:(id<TTPopupViewDelegate>)delegate{
    return [self initWithStyle:TTPopupViewActionSheet popupTitle:popupTitle share2Icons:nil share2Titles:nil funsIcons:nil funsTitles:funsTitles delegate:delegate];
}

-(instancetype)initWithPopupTitle:(NSString *)popupTitle funsTitles:(NSArray<NSString *> *)funsTitles click:(TTClickBlock)click{
    return [self initWithStyle:TTPopupViewActionSheet popupTitle:popupTitle share2Icons:nil share2Titles:nil funsIcons:nil funsTitles:funsTitles click:click];
}

-(instancetype)initWithStyle:(TTPopupViewStyle)style  popupTitle:(NSString*)popupTitle share2Icons:(NSArray<NSString *> *)share2Icons share2Titles:(NSArray<NSString *> *)share2Titles funsIcons:(NSArray<NSString *> *)funsIcons funsTitles:(NSArray<NSString *> *)funsTitles delegate:(id<TTPopupViewDelegate>)delegate{
   
    if (self = [super init]) {
        self.style = style;
        self.popupTitle = popupTitle;
        self.share2Icons = share2Icons;
        self.share2Titles = share2Titles;
        self.funsIcons = funsIcons;
        self.funsTitles = funsTitles;
        self.delegate = delegate;
    }
    
    return self;
}

-(instancetype)initWithStyle:(TTPopupViewStyle)style popupTitle:(NSString *)popupTitle share2Icons:(NSArray<NSString *> *)share2Icons share2Titles:(NSArray<NSString *> *)share2Titles funsIcons:(NSArray<NSString *> *)funsIcons funsTitles:(NSArray<NSString *> *)funsTitles click:(TTClickBlock)click{
    if (self = [super init]) {
        self.style = style;
        self.popupTitle = popupTitle;
        self.share2Icons = share2Icons;
        self.share2Titles = share2Titles;
        self.funsIcons = funsIcons;
        self.funsTitles = funsTitles;
        self.clickBlock = click;
    }
    
    return self;

}

-(void)show{
    [self setupView];
    self.rootWindow.hidden = NO;
    
    //把弹出框view添加上来，此时弹出框view在屏幕底部的外面，还没显示出来
    [self addSubview:self.contentView];
    
    [self.rootWindow addSubview:self];
    
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];

        [self.shadowView setAlpha:self.backgroundOpacity];
        [self.shadowView setUserInteractionEnabled:YES];
        [self.shadowView addGestureRecognizer:singleTap];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        
        CGRect frame = self.contentView.frame;
        frame.origin.y -= frame.size.height;
        [self.contentView setFrame:frame];
        
    } completion:nil];
    
}

/**
 *  设置所有View和布局
 */
-(void)setupView{

    // 阴影部分的view
    UIView *shadowView = [[UIView alloc] init];
    [shadowView setAlpha:0];
    [shadowView setUserInteractionEnabled:NO];
    [shadowView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
    [shadowView setBackgroundColor:TTColor(46, 49, 50)];
    //[shadowView addGestureRecognizer:singleTap];
    [self addSubview:shadowView];
    self.shadowView = shadowView;
    
    NSString *bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"TTPopupView" ofType:@"bundle"];
    
    // 弹出框部分的view，所有的APP图标、功能图标和取消按钮都在这里添加
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:TTColor(192, 192, 193)];
    self.contentView = contentView;
    
    //弹出框除去取消按钮的部分
    UIView *topView = [[UIView alloc] init];
    [topView setBackgroundColor:TTColor(192, 192, 193)];
    self.topContentView = topView;
    
    // 设置弹出框标题
    if (self.popupTitle) {
        CGFloat vSpace = 0;
        CGSize titleSize = [self.popupTitle sizeWithAttributes:@{NSFontAttributeName : self.popupTitleTextFont}];
        if (titleSize.width > SCREEN_SIZE.width - 30.0f) {
            vSpace = 15.0f;
        }
        
        UIView *titleBgView = [[UIView alloc] init];
        titleBgView.backgroundColor = [UIColor whiteColor];
        titleBgView.frame = CGRectMake(0, -vSpace, (self.style == TTPopupViewWithPageControlWithCircle || self.style == TTPopupViewNormalWithCircle) ? SCREEN_SIZE.width * .9 : SCREEN_SIZE.width, TT_BUTTON_H + vSpace);
        [self.topContentView addSubview:titleBgView];
        
        // 标题
        UILabel *label = [[UILabel alloc] init];
        [label setText:self.popupTitle];
        [label setNumberOfLines:2.0f];
        [label setTextColor:TTColor(34, 34, 34)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:self.popupTitleTextFont];
        [label setBackgroundColor:[UIColor whiteColor]];
        [label setFrame:CGRectMake(15.0f, 0, (self.style == TTPopupViewWithPageControlWithCircle || self.style == TTPopupViewNormalWithCircle) ? SCREEN_SIZE.width * .9 - 30 : SCREEN_SIZE.width - 30 , titleBgView.frame.size.height)];
        [titleBgView addSubview:label];
    }
    
    // 对分享和功能按钮区布局
    switch (self.style) {
        case TTPopupViewActionSheet:
            //仿微信列表类型的弹出框
            [self doActionSheetStyle];
            break;
            
          case TTPopupViewNormal:
            //带分享和功能按钮的弹出框，无分页，无圆角
            [self doPageControlStyle:NO andCircleStyle:NO];
            break;
            
          case TTPopupViewWithPageControl:
            //带分享和功能按钮的弹出框，有分页（），无圆角
            if(self.share2Icons && self.share2Icons.count < 8){
                [self doPageControlStyle:NO andCircleStyle:NO];
            }else{
                [self doPageControlStyle:YES andCircleStyle:NO];
            }
            break;
        case TTPopupViewWithPageControlWithCircle:
            if(self.share2Icons && self.share2Icons.count < 8){
                [self doPageControlStyle:NO andCircleStyle:YES];
            }else{
                [self doPageControlStyle:YES andCircleStyle:YES];
            }
            break;
        default:
            [self doPageControlStyle:NO andCircleStyle:YES];
            break;
    }
    
    // 对内容区域的frame进行设置
    CGRect topFrame = self.topContentView.frame;
    [self.contentView setFrame:CGRectMake((self.style == TTPopupViewNormalWithCircle || self.style == TTPopupViewWithPageControlWithCircle) ? SCREEN_SIZE.width * .05 : 0, SCREEN_SIZE.height, topFrame.size.width, topFrame.size.height + TT_BUTTON_H + ((self.style == TTPopupViewNormalWithCircle || self.style == TTPopupViewWithPageControlWithCircle) ? 15.0f : 6))];
    CGRect contentFrame = self.contentView.frame;
    [self.contentView addSubview:self.topContentView];
    
    // 取消按钮的背景
    NSString *linePath = [bundlePath stringByAppendingPathComponent:@"bgImage_HL@2x.png"];
    UIImage *bgImage = [UIImage imageWithContentsOfFile:linePath];

    // 取消按钮
    self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0 , contentFrame.size.height - TT_BUTTON_H - ((self.style == TTPopupViewNormalWithCircle || self.style == TTPopupViewWithPageControlWithCircle) ? 9.0f : 0), contentFrame.size.width,TT_BUTTON_H )];
    [self.cancelBtn setTag:-100];
    [self.cancelBtn setTitle:self.cancelTitle forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:self.cancelTextColor forState:UIControlStateNormal];
    [self.cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [self.cancelBtn setBackgroundImage:bgImage forState:UIControlStateHighlighted];
    [self.cancelBtn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    [[self.cancelBtn titleLabel] setFont:self.cancelTextFont];
    
    [self.contentView addSubview: self.cancelBtn];
    
    // 根据是否是圆角类型，进行圆角处理
    if(self.style == TTPopupViewWithPageControlWithCircle || self.style == TTPopupViewNormalWithCircle){
        if (!self.radius || self.radius <= 0) {
            self.radius = contentFrame.size.width/16;
        }
        self.cancelBtn.layer.cornerRadius = self.radius;
        self.cancelBtn.layer.masksToBounds = YES;
        
        self.topContentView.layer.cornerRadius = self.radius;
        self.topContentView.layer.masksToBounds = YES;
    }
    
    [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
}

/**
 * 仿微信弹出框列表类型的处理
 */
-(void)doActionSheetStyle{
    
    NSString *bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"TTPopupView" ofType:@"bundle"];
    if (self.funsTitles.count) {
        for (int i = 0; i < self.funsTitles.count; i++) {
            // 功能按钮
            UIButton *btn = [[UIButton alloc] init];
            [btn setTag:i];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitle:self.funsTitles[i] forState:UIControlStateNormal];
            [[btn titleLabel] setFont:self.contentTextFont];
            [btn setTitleColor:self.contentTextColor forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

            
            NSString *linePath = [bundlePath stringByAppendingPathComponent:@"bgImage_HL@2x.png"];
            UIImage *bgImage = [UIImage imageWithContentsOfFile:linePath];
            
            [btn setBackgroundImage:bgImage forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
            
            CGFloat y = TT_BUTTON_H * (i + (self.popupTitle ? 1 : 0));
            [btn setFrame:CGRectMake(0, y, SCREEN_SIZE.width, TT_BUTTON_H)];
            [self.topContentView addSubview:btn];
        }
        
        for (int i = 0; i < self.funsTitles.count; i++) {
            NSString *linePath = [bundlePath stringByAppendingPathComponent:@"cellLine@2x.png"];
            UIImage *lineImage = [UIImage imageWithContentsOfFile:linePath];
            
            // 功能按钮的分割线条
            UIImageView *line = [[UIImageView alloc] init];
            [line setImage:lineImage];
            [line setContentMode:UIViewContentModeTop];
            CGFloat y = (i + (self.popupTitle ? 1 : 0)) * TT_BUTTON_H;
            [line setFrame:CGRectMake(0, y, SCREEN_SIZE.width, 1.0f)];
            [self.topContentView addSubview:line];
        }
    }

    // 内容top部分frame的设置
    CGFloat bottomH = (self.popupTitle ? TT_BUTTON_H : 0) + TT_BUTTON_H * self.funsTitles.count;
    [self.topContentView setFrame:CGRectMake(0, 0, SCREEN_SIZE.width, bottomH)];
}

/**
 * 非微信列表类型弹出框的布局处理
 */
-(void)doPageControlStyle:(BOOL)pageControlStyle andCircleStyle:(BOOL)circleStyle{
    NSString *bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"TTPopupView" ofType:@"bundle"];
    NSString *linePath = [bundlePath stringByAppendingPathComponent:@"cellLine@2x.png"];
    UIImage *lineImage = [UIImage imageWithContentsOfFile:linePath];

    // 第三方分享APP的布局处理，如果传入的第三方分享APP的图标列表是nil或者count ==0，则不添加分享按钮区。
    if (self.share2Icons && self.share2Icons.count>0) {
        // 根据有无弹出框标题、分页控件、圆角情况，分别设置分享部分视图的frame大小
        self.share2ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.popupTitle ? TT_BUTTON_H : 0, circleStyle ? SCREEN_SIZE.width * .9 : SCREEN_SIZE.width, TT_ICON_H * 2 + 10 + (self.popupTitle ? 5 : 10) + (pageControlStyle ? 5 : 10))];
        [self.topContentView addSubview:self.share2ScrollView];
        [self.share2ScrollView setBackgroundColor:[UIColor whiteColor]];
        
        // 计算分享部分视图的contentsize 和属性设置
        CGSize size = self.share2ScrollView.frame.size;
        CGFloat shareSVWidth = size.width;
        CGFloat margin = (size.width - TT_ICON_H * 4) /5;
        size.width *=  (self.share2Icons.count/8 + 1);
        self.share2ScrollView.contentSize = size;
        self.share2ScrollView.showsHorizontalScrollIndicator = NO;
        self.share2ScrollView.pagingEnabled = YES;
       
        // 添加第三方分享APP按钮
        for (int i = 0; i<self.share2Icons.count; i++) {
            // 计算每个APP按钮的位置
            TTButton *btn = [[TTButton alloc] initWithAlignmentStyle:TTAlignmentStyleTop withFrame: CGRectMake(
                            margin * (i % 4 + 1) + TT_ICON_H * (i % 4) + ( i / 8) * shareSVWidth,
                            ((i % 8 < 4) ? 0 : (TT_ICON_H + 10)) + (self.popupTitle ? 5 : 10), TT_ICON_H, TT_ICON_H)];
            
            // 为每个按钮设置tag，方便点击处理
            [btn setTag:(1000 + i)];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setImage:[UIImage imageNamed:self.share2Icons[i]] forState:UIControlStateNormal];
            btn.titleLabel.font = self.contentTextFont;
            [btn setTitleColor:self.contentTextColor forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
            [btn setTitle:self.share2Titles[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.share2ScrollView addSubview:btn];
        }
        
        CGFloat y = self.share2ScrollView.frame.size.height + self.share2ScrollView.frame.origin.y;
        
        // 添加分页控件，分享APP数量少于8个时，默认不显示分页
        if (pageControlStyle) {
            UIView *pageControlView = [[UIView alloc]initWithFrame:CGRectMake(0, y, shareSVWidth, 20)];
            [pageControlView setBackgroundColor:[UIColor whiteColor]];
            [self.topContentView addSubview:pageControlView];
            
            CGRect pcframe = pageControlView.frame;
            pcframe.origin.y = 0 ;
            self.pageControl = [[UIPageControl alloc]initWithFrame:pcframe];
            self.pageControl.numberOfPages = self.share2Icons.count / 8  + (self.share2Icons.count % 8 !=0 ? 1 : 0 );
            self.pageControl.currentPage = 0;
            [self.pageControl setBackgroundColor:[UIColor clearColor]];
            self.pageControl.pageIndicatorTintColor = TTColor(233, 233, 233);
            self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
            [pageControlView addSubview:self.pageControl];
            
            self.share2ScrollView.delegate = self;
            [self.pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        }
       
        // 添加分割线
        UIImageView *line = [[UIImageView alloc] init];
        [line setImage:lineImage];
        [line setContentMode:UIViewContentModeTop];
        [line setFrame:CGRectMake(0, y + (pageControlStyle ? 19 : -1), shareSVWidth, 1.0f)];
        [self.topContentView addSubview:line];
    }
    
    
    // 功能区域的布局处理，如果传入的功能图标列表是nil或者count ==0，则不添加功能按钮区。
    if (self.funsIcons && self.funsIcons.count>0) {
        // 计算功能部分视图的frame大小
        self.funsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, (self.popupTitle ? TT_BUTTON_H : 0) + (self.share2ScrollView ? self.share2ScrollView.frame.size.height + (pageControlStyle ? 20 : 0) : 0), circleStyle ? SCREEN_SIZE.width * .9 : SCREEN_SIZE.width, TT_ICON_H + 20)];
        [self.topContentView addSubview:self.funsScrollView];
        [self.funsScrollView setBackgroundColor:[UIColor whiteColor]];
        
        // 计算功能部分视图的contentsize大小 和属性设置
        CGSize size = self.funsScrollView.frame.size;
        CGFloat funsSVWidth = size.width;
        CGFloat margin = (size.width - TT_ICON_H * 4) /5;
        size.width =  (self.funsIcons.count + 1) * margin + TT_ICON_H * self.funsIcons.count;
        self.funsScrollView.contentSize = size;
        self.funsScrollView.showsHorizontalScrollIndicator = NO;
        
        // 添加功能按钮
        for (int i = 0; i<self.funsIcons.count; i++) {
            // 计算每个功能按钮的位置
            TTButton *btn = [[TTButton alloc] initWithAlignmentStyle:TTAlignmentStyleTop withFrame: CGRectMake(margin * (i + 1) + TT_ICON_H * i, 10, TT_ICON_H, TT_ICON_H)];
            
            // 为每个按钮设置tag，方便点击处理
            [btn setTag:(2000 + i)];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setImage:[UIImage imageNamed:self.funsIcons[i]] forState:UIControlStateNormal];
            [btn setTitleColor:self.contentTextColor forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
            btn.titleLabel.font = self.contentTextFont;
            [btn setTitle:self.funsTitles[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.funsScrollView addSubview:btn];
        }
        
        // 添加分割线,(已去掉)
        UIImageView *line = [[UIImageView alloc] init];
        [line setImage:lineImage];
        [line setContentMode:UIViewContentModeTop];
        CGFloat y = self.funsScrollView.frame.size.height + self.funsScrollView.frame.origin.y;
        [line setFrame:CGRectMake(0, y, funsSVWidth, 1.0f)];
        //[self.topContentView addSubview:line];
    }
    
    // 计算内容top部分视图的frame大小
    CGFloat bottomH = (self.popupTitle ? TT_BUTTON_H : 0) + (pageControlStyle ? 20 : 0) + (self.share2ScrollView ? self.share2ScrollView.frame.size.height : 0 ) +  (self.funsScrollView ? self.funsScrollView.frame.size.height : 0);
    [self.topContentView setFrame:CGRectMake(0, 0, circleStyle ? SCREEN_SIZE.width * .9 : SCREEN_SIZE.width, bottomH)];
}

#pragma mark - 
/**
 *  scrollview滑动处理
 *
 *  @param scrollView
 */
-(void)scrollViewDidScroll:(UIScrollView*)scrollView{
    CGFloat pageW= scrollView.frame.size.width;
    int curPage = floor((scrollView.contentOffset.x  - pageW / 2) / pageW) + 1;
    self.pageControl.currentPage = curPage;
}


/**
 *  分页变化时的处理
 *
 *  @param pageControl
 */
-(void)pageChange:(UIPageControl*)pageControl{
    NSInteger curPage = pageControl.currentPage;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    CGFloat w = self.share2ScrollView.frame.size.width;
    [self.share2ScrollView setContentOffset:CGPointMake(w * curPage, 0) animated:YES];
    [UIView commitAnimations];
}

/**
 *  弹出框退出
 *
 *  @param tap
 */
- (void)dismiss:(UITapGestureRecognizer *)tap {
    //NSLog(@"%@-->>dismiss",self);
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.shadowView setAlpha:0];
        [self.shadowView setUserInteractionEnabled:NO];
        
        CGRect frame = self.contentView.frame;
        frame.origin.y += frame.size.height;
        [self.contentView setFrame:frame];
        
    } completion:^(BOOL finished){
        [self removeFromSuperview];
        self.rootWindow.hidden = YES;
    }];
}

/**
 * 点击处理
 *
 *  @param btn
 */
-(void)didClick:(UIButton*)btn {
    [self dismiss:nil];
    
    if (btn && btn.tag == -100) {
        return;
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(popupView:onClick:)]) {
            [self.delegate popupView:self onClick:btn.tag];
        }
    }
   
        
    if (self.clickBlock) {
        self.clickBlock(btn.tag);
    }
   

}
@end
