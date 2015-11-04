//
//  MainCategoryCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MainCategoryCell.h"

@interface MainCategoryCell ()

@property (nonatomic,weak) UIButton * freshHourseButton;
@property (nonatomic,weak) UIButton * groupPurchaseButton;
@property (nonatomic,weak) UIButton * secondHandHouseButton;
@property (nonatomic,weak) UIButton * helpFindingButton;

@property (nonatomic,weak) UIButton * foundHouseHistoryButton;
@property (nonatomic,weak) UIButton * myGroupPurchaseButton;
@property (nonatomic,weak) UIButton * buyingHouseToolButton;

@property (nonatomic,weak) UIView * toolView;


@end

@implementation MainCategoryCell

+(id)mainCategoryCellWithTableView:(UITableView *)tableView{
    NSString * cellIdentifier = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:cellIdentifier];
    return [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
}

-(void)loadView{
//    UIButton * freshHourseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    UIButton * groupPurchaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    UIButton * secondHandHouseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    UIButton * helpFindingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    UIButton * foundHouseHistoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    UIButton * myGroupPurchaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    UIButton * buyingHouseToolButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    UIView * toolView;
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
