//
//  MainHourseCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MainHourseCell.h"

#import "UIImageView+WebCache.h"
#import "NSString+Frame.h"

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






@interface LocalPriceCell ()
@property (weak, nonatomic) IBOutlet UIImageView *statusIconView;
@property (weak, nonatomic) IBOutlet UILabel *localAreaLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@end
@implementation LocalPriceCell

-(void)setLocalPriceModel:(LocalPriceModel *)localPriceModel{
    _localPriceModel = localPriceModel;
    
    NSArray * array = [localPriceModel.range componentsSeparatedByString:@"%"];
    if([[array lastObject] isEqualToString:@"+"]){
        self.statusIconView.image = [UIImage imageNamed:@"up_"];
    }else{
        self.statusIconView.image = [UIImage imageNamed:@"down_"];
    }
    NSString * cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityName"];
    NSString * localArea = [NSString stringWithFormat:@"%@本月均价",cityName];
    self.localAreaLabel.text = localArea;
    self.priceLabel.text = localPriceModel.averPrice;
    self.subLabel.text = [NSString stringWithFormat:@"%@%%",[array firstObject]];
    
    self.width.constant = [localArea widthWithFont:[UIFont systemFontOfSize:17]];
    
}

@end


























