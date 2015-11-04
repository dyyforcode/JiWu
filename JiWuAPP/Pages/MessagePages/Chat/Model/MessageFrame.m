//
//  MessageFrame.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MessageFrame.h"

#import "MessageModel.h"
#import "NSString+Extension.h"

@implementation MessageFrame

//设置message
-(void)setMessage:(MessageModel *)message{
    _message = message;
    
    //间距
    CGFloat padding = 10;
    //屏幕宽度
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    //时间
    if(!message.isHideTime){
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = screenWidth;
        CGFloat timeH = 0;
        
        self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    //头像
    CGFloat iconX = 0;
    CGFloat iconY = CGRectGetMaxY(self.timeFrame) + padding;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    if(message.messageType == JWMessageTypeOther){
        iconX = padding;
    }else{
        iconX = screenWidth - padding - iconW;
    }
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //正文
    CGFloat textY = iconY;
    //文字计算的最大尺寸
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    //文字label的尺寸
    CGSize textrealSize = [message.contentText sizeWithFont:JWTextFont maxSize:textMaxSize];
    //按钮的真实尺寸
    CGSize textBtnSize = CGSizeMake(textrealSize.width + JWTextPadding * 2, textrealSize.height + JWTextPadding * 2);
    CGFloat textX = 0;
    if(message.messageType == JWMessageTypeOther){
        textX = CGRectGetMaxX(self.iconFrame) + padding;
    }else{
        textX = iconX - padding - textBtnSize.width;
    }
    
    self.textFrame = (CGRect){{textX,textY},textBtnSize};
    
    CGFloat textMaxY = CGRectGetMaxY(self.textFrame);
    CGFloat iconMaxY = CGRectGetMaxY(self.iconFrame);
    //cell的高度
    self.cellHeight = MAX(textMaxY,iconMaxY) + padding;
    
   
}

@end
