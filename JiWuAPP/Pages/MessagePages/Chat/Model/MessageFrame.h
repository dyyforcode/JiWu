//
//  MessageFrame.h
//  JiWuAPP
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//正文字体大小
#define JWTextFont [UIFont systemFontOfSize:15]
//正文内边距
#define JWTextPadding 20

@class MessageModel;

@interface MessageFrame : NSObject

//头像的frame
@property (nonatomic) CGRect iconFrame;
//时间的frame
@property (nonatomic) CGRect timeFrame;
//正文的frame
@property (nonatomic) CGRect textFrame;
//cell的高度
@property (nonatomic) CGFloat cellHeight;

//消息数据模型
@property (nonatomic) MessageModel * message;

@end
