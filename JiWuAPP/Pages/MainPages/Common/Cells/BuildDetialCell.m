//
//  BuildDetialCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "BuildDetialCell.h"

#import "UIImageView+WebCache.h"
#import "UIButton+AutoWidth.h"
#import "Masonry.h"

#pragma mark -根本cell
@interface BuildDetialCell ()

@end
@implementation BuildDetialCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


#pragma mark -图片cell
@interface BuildImageDetialCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (nonatomic) NSArray * imageArray;
@property (nonatomic) NSArray * titleArray;

@end
@implementation BuildImageDetialCell

-(void)setDetialModel:(HouseDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    NSMutableArray * titleArray = [NSMutableArray new];
    NSMutableArray * imageArray = [NSMutableArray new];
    
    for(HouseDetialImageModel * imageModel in detialModel.buildImgsArray){
        [titleArray addObject:imageModel.name];
        for(NSDictionary * dict in imageModel.imgArray){
            [imageArray addObject:dict[@"path"]];
        }
    }
    self.imageArray = imageArray;
    self.titleArray = titleArray;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[0]]];
    self.statusLabel.text = detialModel.status;
    
    self.numberLabel.text = [NSString stringWithFormat:@"共%ld张",self.imageArray.count];
    self.nameLabel.text = detialModel.name;
}

@end



#pragma mark -均价cell
@interface BuildPriceDetialCell ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation BuildPriceDetialCell

-(void)setDetialModel:(HouseDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    self.priceLabel.text = detialModel.price;
}

@end


#pragma mark -开盘时间cell
@interface BuildOpenTimeDetialCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation BuildOpenTimeDetialCell

-(void)setDetialModel:(HouseDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    self.timeLabel.text = detialModel.openTime;
}


@end


#pragma mark -地址cell
@interface BuildAddressDetialCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
@implementation BuildAddressDetialCell

-(void)setDetialModel:(HouseDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    self.addressLabel.text = detialModel.address;
}

@end



#pragma mark -电话cell
@interface BuildPhoneDetialCell ()
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;

@end
@implementation BuildPhoneDetialCell

-(void)setDetialModel:(HouseDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    [self.phoneButton setTitle:detialModel.salePhone forState:UIControlStateNormal];
    
}

- (IBAction)phoneButtonClicked:(UIButton *)sender {
    /**
     *  调用手机的打电话功能
     *
     */
    if(self.buildPhoneClickedBlock){
        self.buildPhoneClickedBlock(sender.titleLabel.text);
    }
   
    
}
- (IBAction)notificationButtonClicked:(UIButton *)sender {
    /**
     *  调用对话框，留下手机号，降价通知
     *
     */
    if(self.buildNotificationClickedBlock){
        self.buildNotificationClickedBlock(sender.titleLabel.text);
    }

    
}


@end



#pragma mark -户型cell
@interface BuildHouseTypeDetialCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthPriceLabel;


@end
@implementation BuildHouseTypeDetialCell

-(void)setHouseTypeModel:(HouseDetialHouseTypeModel *)houseTypeModel{
    [super setHouseTypeModel:houseTypeModel];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:houseTypeModel.path]];
    self.titleLabel.text = houseTypeModel.typeName;
    self.areaLabel.text = houseTypeModel.area;

}


@end





#pragma mark -地图cell
@interface BuildHouseLocationMapDetial ()

@property (nonatomic) UILabel * locationLabel;
@property (nonatomic) MKMapView * mapView;

@end
@implementation BuildHouseLocationMapDetial

-(void)setDetialModel:(HouseDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    UILabel * locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    locationLabel.text = detialModel.address;
    [self addSubview:locationLabel];
    
    UILabel * addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    addressLabel.text = @"地址:";
    addressLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:addressLabel];
    
    UIImageView * webView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [webView sd_setImageWithURL:[NSURL URLWithString:detialModel.locPath]];
    [self addSubview:webView];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(5);
        make.width.equalTo(@(50));
        make.height.equalTo(self.mas_height).offset(-130);
    }];
    
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_top);
        make.left.equalTo(addressLabel.mas_right).offset(8);
        make.width.equalTo(self.mas_width).offset(-50-18);
        make.height.equalTo(addressLabel.mas_height);
    }];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_bottom);
        make.left.equalTo(addressLabel.mas_left);
        make.width.equalTo(locationLabel.mas_width).offset(50);
        make.height.equalTo(@(130));
    }];
}

@end




#pragma mark -附近cell
@interface BuildHouseFeatureDetialCell ()


@end
@implementation BuildHouseFeatureDetialCell

-(void)setDetialModel:(HouseDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    NSArray * featureArray = [detialModel.label componentsSeparatedByString:@","];
    NSMutableArray * buttonArray = [NSMutableArray new];
    for(int i = 0;i < featureArray.count; i++){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:featureArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 6;
        button.clipsToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        
        [self addSubview:button];
        [buttonArray addObject:button];
    }
    
    CGFloat totalWidth = 0;
    NSInteger index = 0;
    for(int i=0;i<buttonArray.count;i++){
        UIButton * button = buttonArray[i];
        UIButton * lastButton = (i != 0) ? buttonArray[i-1] : nil;
        
        CGFloat width = [button adjustWidth] + 8;
        if(!lastButton){
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(5);
                make.left.equalTo(self.mas_left).offset(8);
                make.width.equalTo(@(width));
                make.height.equalTo(@(15));
            }];
        }else{
            if( (totalWidth + width) < (self.frame.size.width - 16) ){
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastButton.mas_top);
                    make.left.equalTo(lastButton.mas_right).offset(10);
                    make.width.equalTo(@(width));
                    make.height.equalTo(lastButton.mas_height);
                }];
            }else{
                totalWidth = 0;
                index = 0;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastButton.mas_bottom).offset(10);
                    make.left.equalTo(self.mas_left).offset(8);
                    make.width.equalTo(@(width));
                    make.height.equalTo(@(15));
                }];
            }
        }
        index += 1;
        totalWidth += width;
    }
}

@end





#pragma mark -最新动态cell
@interface BuildHouseMoveDetialCell ()

@end
@implementation BuildHouseMoveDetialCell

-(void)setDetialModel:(HouseDetialModel *)detialModel{
    [super setDetialModel:detialModel];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [self addSubview:titleLabel];
    [self addSubview:contentLabel];
    
    titleLabel.text = detialModel.hotSaleTitle;
    contentLabel.text = detialModel.hotSaleContent;
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor lightGrayColor];
    contentLabel.font = [UIFont systemFontOfSize:15];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.equalTo(self.mas_width).offset(-16);
        make.height.equalTo(@(20));
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.left.equalTo(titleLabel.mas_left);
        make.width.equalTo(titleLabel.mas_width);
        make.height.equalTo(self.mas_height).offset(-35);
    }];
    
}

@end





#pragma mark -楼盘具体详情cell
@interface BuildHouseTotalDetialCell ()

@end
@implementation BuildHouseTotalDetialCell



@end




















