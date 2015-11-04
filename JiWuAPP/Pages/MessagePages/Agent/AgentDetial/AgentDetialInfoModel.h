//
//  AgentDetialInfoModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgentDetialInfoModel : NSObject

@property (nonatomic,copy) NSString * goodMarkPercent;
@property (nonatomic,copy) NSString * personPath;
@property (nonatomic,copy) NSString * replySpeed;
@property (nonatomic,copy) NSString * entryYears;
@property (nonatomic,copy) NSString * replyMark;
@property (nonatomic,copy) NSString * servicePeopleNum;
@property (nonatomic,copy) NSString * wxNumber;

@property (nonatomic,copy) NSString * replyPercent;
@property (nonatomic,copy) NSString * specialityMark;
@property (nonatomic,copy) NSString * agencyName;
@property (nonatomic,copy) NSString * sercivesMark;
@property (nonatomic,copy) NSString * area;
@property (nonatomic,copy) NSString * xmppAccount;
@property (nonatomic,copy) NSString * birthplace;

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * age;
@property (nonatomic,copy) NSString * genarelMark;
@property (nonatomic,copy) NSString * canJudge;
@property (nonatomic,copy) NSString * jid;
@property (nonatomic,copy) NSString * mobile;


+(id)agentDetialInfoModelWithNode:(NSDictionary *)node;

@end
