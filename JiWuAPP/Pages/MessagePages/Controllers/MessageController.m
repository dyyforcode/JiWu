//
//  MessageController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MessageController.h"

#import "AgentController.h"

@interface MessageController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *keepoutView;


@property (nonatomic,copy) NSArray * dataArray;


@end

@implementation MessageController

#pragma mark -设置视图属性
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealBackViewTaped:)];
    [self.backView addGestureRecognizer:tapGesture];
    
    [self loadData];
}
-(void)dealBackViewTaped:(UITapGestureRecognizer *)gesture{
    [self performSegueWithIdentifier:@"ShowAllAgent" sender:nil];
}
#pragma mark -数据加载
-(void)loadData{
    [self loadDataFromServer];
}
-(void)loadDataFromServer{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    
    
    self.dataArray = dataArray;
    
    if(self.dataArray.count > 0){
        self.keepoutView.hidden = YES;
    }else{
        self.keepoutView.hidden = NO;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSString * cityID = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityId"];
    if([segue.identifier isEqualToString:@"ShowAllAgent"]){
        
        AgentController * agentController = segue.destinationViewController;
        agentController.cityId = cityID;
        
    }
}


@end
