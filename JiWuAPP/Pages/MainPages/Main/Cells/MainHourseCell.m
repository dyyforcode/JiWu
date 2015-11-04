//
//  MainHourseCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MainHourseCell.h"

#import "UIImageView+WebCache.h"

@interface MainHourseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



@end


@implementation MainHourseCell

-(void)setModel:(MainHouseModel *)model{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.path]];
    self.titleLabel.text = model.name;
    self.addressLabel.text = model.area;
    NSArray * desc = [model.features componentsSeparatedByString:@","];
    if(desc.count < 1){
        
    }else if(desc.count == 1){
        self.descriptionLabel.text = [NSString stringWithFormat:@"%@ ",desc[0]];
    }else if(desc.count == 2){
        self.descriptionLabel.text = [NSString stringWithFormat:@"%@  |  %@ ",desc[0],desc[1]];
    }else{
        self.descriptionLabel.text = [NSString stringWithFormat:@"%@  |  %@  |  %@",desc[0],desc[1],desc[2]];
    }
    self.priceLabel.text = model.price;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
