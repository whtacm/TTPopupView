//
//  TTPopupView.h
//  
//
//  Created by Haitao-Wong on 7/6/16.
//  Copyright © 2016 Haitao-Wong. All rights reserved.
//


// 按钮高度
#define TT_BUTTON_H 44.0f

// 分享和功能区域按钮高度（按钮宽高一样）
#define TT_ICON_H 72.0f

// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

// 颜色
#define TTColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

// 默认弹出框标题字体大小
#define TT_DEFAULT_POPUP_TITLE_TEXT_FONT  [UIFont systemFontOfSize:14.0f]

// 默认分享和功能区域字体大小
#define TT_DEFAULT_CONTENT_TEXT_FONT  [UIFont systemFontOfSize:15.0f]

// 默认取消按钮字体大小
#define TT_DEFAULT_CANCEL_TEXT_FONT  [UIFont systemFontOfSize:16.0f]

// 动画时长
#define TT_DEFAULT_ANIMATION_DURATION 0.3f

// 透明度
#define TT_DEFAULT_BACKGROUND_OPACITY 0.3f


#import <UIKit/UIKit.h>
#import "TTButton.h"

@class TTPopupView;

#pragma 
/**
 * 弹出框类型
 */
typedef NS_ENUM(NSInteger,TTPopupViewStyle) {
    /**
     * 类似微信弹出框，包含标题（可选）、功能列、取消按钮
     */
    TTPopupViewActionSheet,
    
    /**
     * 类似分享弹出框，不带pagecontrol控件，无圆角，包含标题（可选）、可分享的第三方平台按钮区（可选，两行四列）、APP自身的功能按钮区（可选，一行）、取消按钮
     */
    TTPopupViewNormal,
    
    /**
     * 类似分享弹出框，带pagecontrol控件，无圆角，包含标题（可选）、可分享的第三方平台按钮区（可选，两行四列）、APP自身的功能按钮区（可选，一行）、取消按钮
     */
    TTPopupViewWithPageControl,
    
    /**
     * 类似分享弹出框，不带pagecontrol控件，有圆角，包含标题（可选）、可分享的第三方平台按钮区（可选，两行四列）、APP自身的功能按钮区（可选，一行）、取消按钮
     */
    TTPopupViewNormalWithCircle,
    
    /**
     * 类似分享弹出框，带pagecontrol控件，有圆角，包含标题（可选）、可分享的第三方平台按钮区（可选，两行四列）、APP自身的功能按钮区（可选，一行）、取消按钮
     */
    TTPopupViewWithPageControlWithCircle

};

/**
 *  点击弹出框按钮调用的block，可分享的第三方平台APP的按钮tag值为（1000 + index），功能按钮tag值为（2000 + index）
 *
 *  @param buttonIndex 按钮的tag属性值
 */
typedef void(^TTClickBlock)(NSInteger buttonIndex);

#pragma mark - Delegate
/**
 *  弹出框的委托
 */
@protocol TTPopupViewDelegate <NSObject>

@optional
/**
 *
 *  点击弹出框按钮调用的方法
 *
 *  @param index 按钮的tag属性值，可分享的第三方平台APP的按钮tag值为（1000 + index），功能按钮tag值为（2000 + index）
 */
-(void)popupView:(TTPopupView*)popup onClick:(NSInteger)index;

@end

#pragma mark - TTPopupView
@interface TTPopupView: UIView <UIScrollViewDelegate>

/**
 *  弹出框类型
 */
@property (nonatomic) TTPopupViewStyle style;

/**
 *  弹出框的标题
 */
@property (nonatomic, copy) NSString *popupTitle;

/**
 * 第三方平台APP的图标
 */
@property (nonatomic, copy) NSArray<NSString*> *share2Icons;

/**
 *第三方平台APP的标题
 */
@property (nonatomic, copy) NSArray<NSString*> *share2Titles;

/**
 * 自身功能的按钮图标
 */
@property (nonatomic, copy) NSArray<NSString*> *funsIcons;

/**
 * 自身功能的标题
 */
@property (nonatomic, copy) NSArray<NSString*> *funsTitles;

/**
 * 取消按钮标题
 */
@property (nonatomic, strong) NSString *cancelTitle;

/**
 * 弹出框的窗口
 */
@property (nonatomic,strong) UIWindow *rootWindow;

/**
 * 弹出框阴影部分视图
 */
@property (nonatomic, strong)  UIView *shadowView;

/**
 * 弹出框的全部内容部分，标题、分享和功能按钮区域、取消按钮
 */
@property (nonatomic, strong)  UIView *contentView;

/**
 * 弹出框除去取消按钮的内容部分
 */
@property (nonatomic, strong)  UIView *topContentView;

/**
 * 取消按钮控件
 */
@property (nonatomic, strong)  UIButton *cancelBtn;

/**
 * 弹出框标题
 */
@property (nonatomic, strong)  UILabel *txtTitle;

/**
 * 分享第三方APP部分视图
 */
@property  (nonatomic, strong)  UIScrollView *share2ScrollView;

/**
 * 功能部分视图
 */
@property (nonatomic, strong)  UIScrollView *funsScrollView;

/**
 *分页控件
 */
@property (nonatomic, strong)  UIPageControl *pageControl;

/**
 *  弹出框标题字体，默认14
 */
@property (nonatomic, strong) UIFont *popupTitleTextFont;

/**
 *  弹出框标题颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *popupTitleTextColor;

/**
 *  分享和功能区域字体大小，默认15
 */
@property (nonatomic, strong) UIFont *contentTextFont;

/**
 *  分享和功能区域字的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *contentTextColor;

/**
 *  取消按钮字体大小，默认16
 */
@property (nonatomic, strong) UIFont *cancelTextFont;

/**
 *  取消按钮字的颜色，默认黑色
 */
@property (nonatomic, strong) UIColor *cancelTextColor;

/**
 *  弹出、退出动画时长，默认0.3s
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 *  阴影部分透明度，默认0.3f
 */
@property (nonatomic, assign) CGFloat backgroundOpacity;

/**
 * 圆角大小，默认是contentView.frame.size.width / 16
 */
@property (nonatomic, assign) CGFloat radius;

/**
 * 代理属性
 */
@property (nonatomic, weak) id<TTPopupViewDelegate> delegate;

/**
 *  点击block
 */
@property (nonatomic, copy) TTClickBlock clickBlock;

/**
 * 创建弹出框（仿微信的列表类型）
 *
 *  @param popupTitle 弹出框标题
 *  @param funsTitles 功能标题
 *  @param delegate 委托
 *
 *  @return
 */
-(instancetype)initWithPopupTitle:(NSString*)popupTitle funsTitles:(NSArray<NSString*>*)funsTitles delegate:(id<TTPopupViewDelegate>)delegate ;

/**
 * 创建弹出框（仿微信的列表类型）
 *
 *  @param popupTitle 弹出框标题
 *  @param funsTitles 功能标题
 *  @param click 点击block
 *
 *  @return
 */
-(instancetype)initWithPopupTitle:(NSString*)popupTitle funsTitles:(NSArray<NSString*>*)funsTitles click:(TTClickBlock)click;


/**
 *创建弹出框
 *
 *  @param style 样式
 *  @param share2Icons 第三方分享APP的图标
 *  @param share2Titles  第三方分享APP的标题
 *  @param funsIcons 功能图标
 *  @param funsTitles 功能标题
 *  @param delegate 委托
 *
 *  @return
 */
-(instancetype)initWithStyle:(TTPopupViewStyle)style popupTitle:(NSString*)popupTitle share2Icons:(NSArray<NSString*>*)share2Icons
                share2Titles:(NSArray<NSString*>*)share2Titles funsIcons:(NSArray<NSString*>*)funsIcons funsTitles:(NSArray<NSString*>*)funsTitles delegate:(id<TTPopupViewDelegate>)delegate ;

/**
 *创建弹出框
 *
 *  @param style 样式
 *  @param share2Icons 第三方分享APP的图标
 *  @param share2Titles  第三方分享APP的标题
 *  @param funsIcons 功能图标
 *  @param funsTitles 功能标题
 *  @param click 点击block
 *
 *  @return
 */
-(instancetype)initWithStyle:(TTPopupViewStyle)style popupTitle:(NSString*)popupTitle share2Icons:(NSArray<NSString*>*)share2Icons
                share2Titles:(NSArray<NSString*>*)share2Titles funsIcons:(NSArray<NSString*>*)funsIcons funsTitles:(NSArray<NSString*>*)funsTitles click:(TTClickBlock)click;

/**
 *  弹出框展示，完成创建动作、设置属性后，最后调用该方法。
 */
-(void)show;

@end
