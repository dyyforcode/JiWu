//
//  GroupBuyingCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/30.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "GroupBuyingCell.h"

#import "UIImageView+WebCache.h"

@implementation GroupBuyingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end






@interface GroupBuyingImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;


@end
@implementation GroupBuyingImageCell

-(void)setModel:(GroupBuyingModel *)model{
    [super setModel:model];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.path]];
    self.statusLabel.text = model.status;
    self.nameLabel.text = [NSString stringWithFormat:@"[%@  %@] %@",model.area,model.plate,model.name];
    self.priceLabel.text = model.grouponInfo;
    self.areaLabel.text = model.price;
}


@end






@interface GroupBuyingFeatureCell ()
@property (weak, nonatomic) IBOutlet UILabel *featureLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end
@implementation GroupBuyingFeatureCell

-(void)setModel:(GroupBuyingModel *)model{
    [super setModel:model];
    
    NSArray * array = [model.features componentsSeparatedByString:@","];
    NSMutableString * mutableString = [NSMutableString string];
    for(int i=0;i<array.count;i++){
        if(i > 2){
            break;
        }
        [mutableString appendString:array[i]];
        if(i < 2){
            [mutableString appendString:@"  |  "];
        }
    }
    self.featureLabel.text = mutableString;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%@人已报名",model.paticipater];
}

@end













































