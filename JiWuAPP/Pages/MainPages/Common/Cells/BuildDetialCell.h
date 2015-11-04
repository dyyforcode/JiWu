//
//  BuildDetialCell.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import "HouseDetialModel.h"


@interface BuildDetialCell : UITableViewCell

@property (nonatomic,weak) HouseDetialModel * detialModel;

@property (nonatomic,weak) HouseDetialHouseTypeModel * houseTypeModel;

@property (nonatomic,strong) void(^buildPhoneClickedBlock)(NSString * phoneBumber);
@property (nonatomic,strong) void(^buildNotificationClickedBlock)(NSString * phoneBumber);

@end



@interface BuildImageDetialCell : BuildDetialCell

@end




@interface BuildPriceDetialCell : BuildDetialCell

@end




@interface BuildOpenTimeDetialCell : BuildDetialCell

@end





@interface BuildAddressDetialCell : BuildDetialCell

@end




@interface BuildPhoneDetialCell : BuildDetialCell



@end




@interface BuildHouseTypeDetialCell : BuildDetialCell

@end


//==================================================================

@interface BuildHouseLocationMapDetial : BuildDetialCell





@end



@interface BuildHouseDetialFeatureModel : BuildDetialCell

@end





@interface BuildHouseFeatureDetialCell : BuildDetialCell

@end



@interface BuildHouseMoveDetialCell : BuildDetialCell

@end





@interface BuildHouseTotalDetialCell : BuildDetialCell

@end































