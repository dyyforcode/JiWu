//
//  MessageModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    JWMessageTypeMe = 0,
    JWMessageTypeOther
}JWMessageType;

@interface MessageModel : NSObject

//聊天内容
@property (nonatomic) NSString * contentText;
//发送时间
@property (nonatomic) NSString * sendTime;
//信息类型
@property (nonatomic) JWMessageType messageType;
//是否隐藏时间
@property (nonatomic) BOOL isHideTime;

+(instancetype)messageModelWithNode:(NSDictionary *)node;

@end
