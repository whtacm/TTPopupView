//
//  TTButton.m
//  nari.mip.console
//
//  Created by Haitao-Wong on 8/9/16.
//  Copyright © 2016 Haitao-Wong. All rights reserved.
//

#import "TTButton.h"

//
#define tt_label_img_margin 4

@implementation TTButton

+(instancetype)tt_Button{
    return [[self alloc]init];
}

-(instancetype)initWithAlignmentStyle:(TTAlignmentStyle)style withFrame:(CGRect)frame{
    TTButton *btn  = [[TTButton alloc]init];
    btn.frame = frame;
    btn.style = style;
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.style == TTAlignmentStyleBottom) {
       [self alignmentBottom];
    }else if(self.style == TTAlignmentStyleTop){
        [self alignmentTop];
    }
}

/**
 *
 */
- (void)alignmentBottom{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.frame.size.height;
    
    CGFloat titleLabelH = frame.size.height;
    CGFloat imageViewH = btnH - titleLabelH - tt_label_img_margin * 3;
    CGFloat margin = (btnW - imageViewH) / 2;

    self.titleLabel.frame = CGRectMake(0 , tt_label_img_margin, btnW, btnH - imageViewH - tt_label_img_margin * 3);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.frame = CGRectMake(margin, self.titleLabel.frame.size.height + tt_label_img_margin * 2, imageViewH, imageViewH);
}

/**
 *
 */
- (void)alignmentTop{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.frame.size.height;
    
    CGFloat titleLabelH = frame.size.height;
    CGFloat imageViewH = btnH - titleLabelH - tt_label_img_margin * 3;
    CGFloat margin = (btnW - imageViewH) / 2;

    self.imageView.frame = CGRectMake(margin, tt_label_img_margin, imageViewH, imageViewH);
    self.titleLabel.frame = CGRectMake(0 , imageViewH + tt_label_img_margin * 2,btnW, btnH - imageViewH - tt_label_img_margin * 3);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
