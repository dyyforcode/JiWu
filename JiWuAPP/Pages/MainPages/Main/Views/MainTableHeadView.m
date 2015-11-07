//
//  MainTableHeadView.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MainTableHeadView.h"

#import "Masonry.h"
#import "NetInterface.h"

@interface MainTableHeadView ()

@property (nonatomic) NSMutableArray * itemArray;
@property (nonatomic) NSMutableArray * buttonArray;
@property (nonatomic) NSMutableArray * splitArray;
@property (nonatomic) NSMutableArray * toolButtonArray;


@property (nonatomic) NSArray * titleArray;

@property (nonatomic,weak) UIView * toolView;

@end

@implementation MainTableHeadView

+(id)mainTableHeadView{
    return [[self alloc] init];
}

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.itemArray = [NSMutableArray new];
        self.buttonArray = [NSMutableArray new];
        self.splitArray = [NSMutableArray new];
        self.toolButtonArray = [NSMutableArray new];
        self.titleArray = @[@"新房",@"团购",@"二手房",@"帮我找",@"找房纪录",@"我的团购",@"购房工具"];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    [self configUI];
}

-(void)configUI{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat interval = 30;
    CGFloat width = (size.width - (interval * 3 + interval / 2 * 2)) / 4;
    CGFloat height = width + 30;
    
   
    NSArray * imagesArray = @[@"home_新房.png",@"home_团购.png",@"home_二手房.png",@"home_帮我找.png"];
    for(int i=0;i<4;i++){
        UIView * view = [[UIView alloc] initWithFrame:CGRectZero];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
       
        
        imageView.image = [UIImage imageNamed:imagesArray[i]];
        label.text = self.titleArray[i];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        
        imageView.tag = 10;
        label.tag = 11;
        
        [view addSubview:imageView];
        [view addSubview:label];
        
        [self.itemArray addObject:view];
       
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemGestureRecognizer:)];
        [view addGestureRecognizer:tapGesture];
        
        [self addSubview:view];
    }
    for(int i=0;i<4;i++){
        UIView * view = self.itemArray[i];
        UIView * lastView = (i != 0) ? self.itemArray[i-1] : nil;
        
        if(!lastView){
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(interval/2));
                make.left.equalTo(@(interval/2));
                make.width.equalTo(@(width));
                make.height.equalTo(@(height));
            }];
        }else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastView.mas_right).offset(interval);
                make.top.equalTo(lastView.mas_top);
                make.width.equalTo(lastView.mas_width);
                make.height.equalTo(lastView.mas_height);
            }];
        }
        
 
        
        UIImageView * imageView = (UIImageView *)[view viewWithTag:10];
        UILabel * label = (UILabel *)[view viewWithTag:11];
        
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.top.equalTo(view.mas_top);
            make.width.equalTo(view.mas_width);
            make.height.equalTo(view.mas_width);
            
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_left);
            make.top.equalTo(imageView.mas_bottom).offset(10);
            make.width.equalTo(imageView.mas_width);
            make.height.equalTo(@(20));
            
        }];
        
        
    }
    
    UIView * splitFirstView = [[UIView alloc] initWithFrame:CGRectZero];
    splitFirstView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self addSubview:splitFirstView];
    
    UIView * itemView = self.itemArray[0];
    
    [splitFirstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(itemView.mas_bottom).offset(15);
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(1));
    }];
    NSArray * subArray = @[@"notes_.png",@"buy_.png",@"counter_.png"];
    for(int i=0;i<3;i++){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectZero;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
        [self addSubview:button];
    
       
        [button setTitle:self.titleArray[i+4] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:subArray[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tintColor = [UIColor greenColor];
        
        UIView * splitView = [[UIView alloc] initWithFrame:CGRectZero];
        splitView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        [self.splitArray addObject:splitView];
        [self addSubview:splitView];
    }
    
    
    CGFloat buttonWidth = (size.width - 2) / 3;
    CGFloat buttonHeight = 40;
    for(int i=0;i<3;i++){
        UIButton * button = self.buttonArray[i];
        UIButton * lastButton = (i!=0) ? self.buttonArray[i-1] : nil;
        
        if(!lastButton){
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(splitFirstView.mas_left);
                make.top.equalTo(splitFirstView.mas_bottom);
                make.width.equalTo(@(buttonWidth));
                make.height.equalTo(@(buttonHeight));
            }];
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastButton.mas_top);
                make.left.equalTo(lastButton.mas_right).offset(1);
                make.width.equalTo(lastButton.mas_width);
                make.height.equalTo(lastButton.mas_height);
            }];
        }
        
        if(i > 0){
            
            UIView * splitView = self.splitArray[i-1];
            [splitView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.mas_right);
                make.top.equalTo(lastButton.mas_top);
                make.width.equalTo(@(1));
                make.height.equalTo(lastButton.mas_height);
            }];
            
        }
    }
    
    UIView * toolView = [[UIView alloc] initWithFrame:CGRectZero];
    toolView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self addSubview:toolView];
    NSArray * toolTitles = @[@"购房能力评估",@"税费计算器",@"房贷计算器"];
   
    for(int i=0;i<3;i++){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:toolTitles[i] forState:UIControlStateNormal];
        
        [toolView addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toolItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 10;
        button.clipsToBounds = YES;
        [self.toolButtonArray addObject:button];
    }
    UIButton * clickButton = self.buttonArray[0];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clickButton.mas_bottom);
        make.left.equalTo(@(0));
        make.width.equalTo(splitFirstView.mas_width);
        make.height.equalTo(@(0));
    }];
    CGFloat toolButtonWidth = (size.width - 10 * 4) / 3;
    for(int i=0;i<3;i++){
        UIButton * button = self.toolButtonArray[i];
        UIButton * lastButton = (i != 0) ? self.toolButtonArray[i-1] : nil;
        if(!lastButton){
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(toolView.mas_left).offset(10);
                make.top.equalTo(toolView.mas_top).offset(5);
                make.width.equalTo(@(toolButtonWidth));
                make.height.equalTo(@(30));
            }];
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.mas_right).offset(10);
                make.top.equalTo(lastButton.mas_top);
                make.width.equalTo(lastButton.mas_width);
                make.height.equalTo(lastButton.mas_height);
            }];
        }
    }
    
    self.toolView = toolView;
    self.toolView.hidden = YES;
    
}

-(void)itemGestureRecognizer:(UITapGestureRecognizer *)gesture{
    NSString * serverPath;
    NSString * cachePath;
    NSInteger index = 0;
    if(gesture.view == self.itemArray[0]){
        serverPath = [NetInterface freshHouseServerPath];
        cachePath = [NetInterface freshHouseCachePath];
        index = 1;
    }else if (gesture.view == self.itemArray[1]){
        serverPath = [NetInterface secondHandHouseServerPath];
        cachePath = [NetInterface secondHandHouseCachePath];
        index = 2;
    }else if (gesture.view == self.itemArray[2]){
        serverPath = [NetInterface secondHandHouseServerPath];
        cachePath = [NetInterface secondHandHouseCachePath];
        index = 3;
    }else if (gesture.view == self.itemArray[3]){
        serverPath = [NetInterface secondHandHouseServerPath];
        cachePath = [NetInterface secondHandHouseCachePath];
        index = 4;
    }
    if(!(serverPath && cachePath)){
        return;
    }
    if(_delegate && [_delegate respondsToSelector:@selector(dealTingsWhenButtonClicked:serverPath:cachePath:)]){
        [self.delegate dealTingsWhenButtonClicked:index serverPath:serverPath cachePath:cachePath];
    }
}
-(void)buttonClicked:(UIButton *)sender{
    
    CGFloat interval = 30;
    CGFloat width = (self.superview.frame.size.width - (interval * 3 + interval / 2 * 2)) / 4;
    self.frame = CGRectMake(0, 0, self.superview.frame.size.width, width + 30 +72);
    
    if(sender == self.buttonArray[2]){
       
        self.toolView.hidden = sender.selected;
        if(!sender.selected){
            [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(40));
            }];
            CGRect rect = self.frame;
            self.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + 40);
        }
        if(self.mainTableHeadViewBlock){
            self.mainTableHeadViewBlock(sender.selected);
        }
        sender.selected = !sender.selected;
    }

}
-(void)toolItemClicked:(UIButton *)sender{
   }

@end
