//
//  GroupBuyingDetialCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "GroupBuyingDetialCell.h"
#import "UIImageView+WebCache.h"

@implementation GroupBuyingDetialCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end





@interface GroupBuyingImageDetialCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupBuyingInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyLabel;
@property (weak, nonatomic) IBOutlet UILabel *surplusTimeLabel;

@end
@implementation GroupBuyingImageDetialCell

-(void)setDetialModel:(GroupBuyingDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:detialModel.path]];
    self.infoLabel.text = detialModel.grouponTitle;
    self.groupBuyingInfoLabel.text = detialModel.grouponDetail;
    self.applyLabel.text = [NSString stringWithFormat:@"已有%@人报名",detialModel.joinedCount];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:SS"];
    NSDate * endDate = [dateFormatter dateFromString:detialModel.applyDeadLine];
    NSDate * nowDate = [NSDate date];
    NSInteger timeInterval = [endDate timeIntervalSinceDate:nowDate];
   
    self.surplusTimeLabel.text = [NSString stringWithFormat:@"还有%ld天%ld小时",timeInterval/24 / 3600,timeInterval/3600%24];
    
}

@end





@interface GroupBuyingPriceDetialCell ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation GroupBuyingPriceDetialCell

- (IBAction)caculateButtonClicked:(UIButton *)sender {
    
}

-(void)setDetialModel:(GroupBuyingDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    self.priceLabel.text = detialModel.price;
}



@end





@interface GroupBuyingInfoDetialCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation GroupBuyingInfoDetialCell

-(void)setTitleString:(NSString *)titleString{
    [super setTitleString:titleString];
    
    self.titleLabel.text = titleString;
}
-(void)setContentString:(NSString *)contentString{
    [super setContentString:contentString];
    
    self.contentLabel.text = contentString;
}


@end




@interface GroupBuyingGroupFlowDetialCell ()

@end
@implementation GroupBuyingGroupFlowDetialCell

-(void)setDetialModel:(GroupBuyingDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    
}


@end




@interface GroupBuyingUsingInfoDetialCell ()
@property (weak, nonatomic) IBOutlet UILabel *useingDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *usingMethodLabel;
@property (weak, nonatomic) IBOutlet UILabel *serveAcceptanceLabel;

@end
@implementation GroupBuyingUsingInfoDetialCell

-(void)setDetialModel:(GroupBuyingDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSDate * endDate = [df dateFromString:detialModel.validDeadline];
    
    self.useingDateLabel.text = [NSString stringWithFormat:@"有效期至%@",[df stringFromDate:endDate]];
    
    self.usingMethodLabel.text = @"签署购房协议时出示短信享受优惠";
    self.serveAcceptanceLabel.text = @"未购房退还预存款";
}


@end


















