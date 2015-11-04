//
//  PriceChooseModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceChooseModel : NSObject

@property (nonatomic,copy) NSString * priceName;
@property (nonatomic,copy) NSString * priceId;

+(id)priceChooseModelWithNode:(NSDictionary *)node;

@end
