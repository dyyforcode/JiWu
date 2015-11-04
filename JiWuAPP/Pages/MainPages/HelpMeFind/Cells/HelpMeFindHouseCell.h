//
//  HelpMeFindHouseCell.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpMeFindHouseCell : UITableViewCell

@property (nonatomic) NSInteger index;

@property (nonatomic,copy) void(^helpMeFindHouseBlock)(NSArray * buttonArray);

@property (nonatomic,copy) void(^helpMeFindSendBlock)();

@end





@interface HelpMeFindHouseCommonCell : HelpMeFindHouseCell

@end







@interface HelpMeFindHouseFeatureCell : HelpMeFindHouseCell

@end






@interface HelpMeFindHouseMoreCell : HelpMeFindHouseCell

@end







@interface HelpMeFindHouseSendCell : HelpMeFindHouseCell

@end
