//
//  AgentModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgentModel : NSObject

@property (nonatomic,copy) NSString * areaName;
@property (nonatomic,copy) NSString * agentName;
@property (nonatomic,copy) NSString * goodCommentPercent;
@property (nonatomic,copy) NSString * genarelMark;
@property (nonatomic,copy) NSString * agentId;

@property (nonatomic,copy) NSString * canJudge;
@property (nonatomic,copy) NSString * jid;
@property (nonatomic,copy) NSString * commentCount;
@property (nonatomic,copy) NSString * avatar;
@property (nonatomic,copy) NSString * agencyName;

@property (nonatomic,copy) NSString * mobile;



+(id)agentModelWithNode:(NSDictionary *)node;

@end
