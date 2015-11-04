//
//  GroupBuyingDetialCell.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GroupBuyingDetialModel.h"

@interface GroupBuyingDetialCell : UITableViewCell

@property (nonatomic) GroupBuyingDetialModel * detialModel;

@property (nonatomic) NSString * titleString;
@property (nonatomic) NSString * contentString;

@end





@interface GroupBuyingImageDetialCell : GroupBuyingDetialCell

@end





@interface GroupBuyingPriceDetialCell : GroupBuyingDetialCell

@end





@interface GroupBuyingInfoDetialCell : GroupBuyingDetialCell

@end




@interface GroupBuyingGroupFlowDetialCell : GroupBuyingDetialCell

@end




@interface GroupBuyingUsingInfoDetialCell : GroupBuyingDetialCell

@end



















