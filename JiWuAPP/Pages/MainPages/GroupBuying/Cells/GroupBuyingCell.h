//
//  GroupBuyingCell.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/30.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GroupBuyingModel.h"

@interface GroupBuyingCell : UITableViewCell

@property (nonatomic) GroupBuyingModel * model;

@end







@interface GroupBuyingImageCell : GroupBuyingCell

@end







@interface GroupBuyingFeatureCell : GroupBuyingCell

@end