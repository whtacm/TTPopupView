//
//  TTButton.h
//  nari.mip.console
//
//  Created by Haitao-Wong on 8/9/16.
//  Copyright © 2016 Haitao-Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    TTAlignmentStyleTop,// 图标在上，文本在下
    TTAlignmentStyleBottom, // 图标在下，文本在上
}TTAlignmentStyle;

@interface TTButton : UIButton
/**
 *  创建不同类型的按钮
 */
@property (nonatomic,assign)TTAlignmentStyle style;

+ (instancetype)tt_Button;

- (instancetype)initWithAlignmentStyle:(TTAlignmentStyle)style withFrame:(CGRect)frame;

@end
