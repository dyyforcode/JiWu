//
//  MessageModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MessageModel.h"

#import "NSObject+Model.h"

@implementation MessageModel

+(instancetype)messageModelWithNode:(NSDictionary *)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"text"]){
        _contentText = value;
    }else if([key isEqualToString:@"time"]){
        _sendTime = value;
    }else if([key isEqualToString:@"type"]){
        _messageType = [value integerValue];
    }
}

@end
