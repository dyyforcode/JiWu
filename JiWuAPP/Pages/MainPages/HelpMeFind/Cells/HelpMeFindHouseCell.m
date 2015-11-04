
//
//  HelpMeFindHouseCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HelpMeFindHouseCell.h"

@implementation HelpMeFindHouseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end







@interface HelpMeFindHouseCommonCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic,copy) NSString * addressString;
@property (nonatomic,copy) NSString * priceString;
@property (nonatomic,copy) NSString * houseTypeString;

@end
@implementation HelpMeFindHouseCommonCell

-(void)setIndex:(NSInteger)index{
    [super setIndex:index];
    
    NSString * cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityName"];
    NSString * address = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindAddress"];
    if(address.length < 2){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HelpMeFindAddress"];
        [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"HelpMeFindAddress"];
    }
    self.addressString = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindAddress"];
    self.priceString = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindPrice"];
    self.houseTypeString = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindHouseType"];
    
    
    
    self.addressString = (self.addressString == nil) ? @"位置" : self.addressString;
    self.priceString = (self.priceString == nil) ? @"请选择价格" : self.priceString;
    self.houseTypeString = (self.houseTypeString == nil) ? @"请选择户型" : self.houseTypeString;
    
    
    
    
    NSArray * titles = @[@"当前位置:",@"价       格:",@"户       型:"];
    
    self.titleLabel.text = titles[index];
    if(index == 0){
        self.nameLabel.textColor = ([self.addressString isEqualToString:@"位置"]) ? [UIColor lightGrayColor] : [UIColor blackColor];
        self.nameLabel.text = self.addressString;
    }else if(index == 1){
        self.nameLabel.textColor = ([self.priceString isEqualToString:@"请选择价格"]) ? [UIColor lightGrayColor] : [UIColor blackColor];
        self.nameLabel.text = self.priceString;
    }else if(index == 2){
        self.nameLabel.textColor = ([self.houseTypeString isEqualToString:@"请选择户型"]) ? [UIColor lightGrayColor] : [UIColor blackColor];
        self.nameLabel.text = self.houseTypeString;
    }
}

@end






@interface HelpMeFindHouseFeatureCell ()

@property (nonatomic) NSMutableArray * buttonArray;
@property (nonatomic) BOOL isFull;

@end
@implementation HelpMeFindHouseFeatureCell

-(NSMutableArray *)buttonArray{
    if(!_buttonArray){
        NSMutableArray * buttonArray = [NSMutableArray array];
        _buttonArray = buttonArray;
    }
    return _buttonArray;
}

- (void)awakeFromNib {
    // Initialization code
    for(int i=0;i<8;i++){
        UIButton * button = (UIButton *)[self viewWithTag:i+1];
        button.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        button.layer.cornerRadius = 12;
        button.clipsToBounds = YES;
        [button setTintColor:[UIColor colorWithWhite:0.902 alpha:1.000]];
        [button setTitleColor:[UIColor colorWithRed:0.000 green:0.502 blue:0.000 alpha:1.000] forState:UIControlStateSelected];
    }
}

-(IBAction)featureButtonClicked:(UIButton *)sender{
    
    if(self.buttonArray.count >2){
        self.isFull = YES;
        for(int i=0;i<self.buttonArray.count;i++){
            UIButton * button = self.buttonArray[i];
            if(button == sender){
                self.isFull = NO;
                
            }
        }
        if(self.isFull ){
            if(self.helpMeFindHouseBlock){
                self.helpMeFindHouseBlock(self.buttonArray);
            }
            return;
        }
    }
    for(int j=0;j<self.buttonArray.count;j++){
        UIButton * button = self.buttonArray[j];
        if(button == sender){
            [self.buttonArray removeObject:sender];
            
            j--;
        }
    }
    
   
    sender.selected = !sender.selected;
    if(sender.selected){
        [self.buttonArray addObject:sender];
       
    }
    if(self.helpMeFindHouseBlock){
        self.helpMeFindHouseBlock(self.buttonArray);
        return;
    }
   
    
}

@end








@interface HelpMeFindHouseMoreCell ()
@property (weak, nonatomic) IBOutlet UILabel *moreInfoLabel;


@property (nonatomic,copy) NSString * moreInfoString;

@end
@implementation HelpMeFindHouseMoreCell

-(void)setIndex:(NSInteger)index{
    [super setIndex:index];
    
    
    self.moreInfoString = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindMoreInfo"];
}

@end










@interface HelpMeFindHouseSendCell ()
@property (weak, nonatomic) IBOutlet UIButton *sendToAgentButton;

@end
@implementation HelpMeFindHouseSendCell

-(void)awakeFromNib{
    NSString * cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityName"];
    NSString * title = [NSString stringWithFormat:@"发给%@经纪人",cityName];
    [self.sendToAgentButton setTitle:title forState:UIControlStateNormal];
}

- (IBAction)sendToAgentButtonClicked:(UIButton *)sender {
    if(self.helpMeFindSendBlock){
        self.helpMeFindSendBlock();
    }
    
}


@end





























