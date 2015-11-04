//
//  AgentDetialInfoCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "AgentDetialInfoCell.h"
#import "UIImageView+WebCache.h"


@interface AgentDetialCell()

@end
@implementation AgentDetialCell



@end





@interface AgentDetialInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;


@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *wechatNumberLabel;

@end

@implementation AgentDetialInfoCell


- (IBAction)evaluateButtonClicked:(UIButton *)sender {
    
    
}

-(void)setDetialModel:(AgentDetialInfoModel *)detialModel{
    [super setDetialModel:detialModel];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:detialModel.personPath]];
    self.starLabel.text = detialModel.genarelMark;
    self.infoLabel.text = [NSString stringWithFormat:@"%@  |  %@  |  入行%@",detialModel.birthplace,detialModel.age,detialModel.entryYears];
    self.goodLabel.text = [NSString stringWithFormat:@"  响应速度%@   |  服务态度%@   |  专业水平%@",detialModel.replyMark,detialModel.sercivesMark,detialModel.specialityMark];
    
    
    self.companyLabel.text = detialModel.agencyName;
    self.areaLabel.text = detialModel.area;
    self.wechatNumberLabel.text = detialModel.xmppAccount;
}



- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
