//
//  AgentDetialController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "AgentDetialController.h"

#import "AgentDetialEvaluateCell.h"
#import "AgentDetialInfoModel.h"

#import "AFNetworking.h"


@interface AgentDetialController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic) AgentDetialInfoModel * agentDetialInfoDetialModel;

@end

@implementation AgentDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self loadData];
}


- (IBAction)onlineBarItemClicked:(id)sender {
    [self performSegueWithIdentifier:@"ShowChatMessage" sender:nil];
    
}
- (IBAction)phoneBarButtonClicked:(UIButton *)sender {
    NSLog(@"KK");
    NSString * alertString = [NSString stringWithFormat:@"确定拨打电话：%@",self.agentDetialInfoDetialModel.mobile];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alertString preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSString * phoneNumberString = [NSString stringWithFormat:@"tel://%@",self.agentDetialInfoDetialModel.mobile];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberString]];
    }]];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];

}


#pragma mark -数据加载
-(void)loadData{
    [self loadDataFromServe];
}
-(void)loadDataFromServe{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    NSString * path = @"http://m.jiwu.com/app!agentPage.action?v=1.4&appKey=7daf08ccfc302a08fa7a58341e8390ca&deviceId=862851029616599&mobile=%@&cid=391621";
    
    NSString * servePath = [NSString stringWithFormat:path,self.phoneNumber];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:servePath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject){
            NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            AgentDetialInfoModel * agentDetialInfoDetialModel = [AgentDetialInfoModel agentDetialInfoModelWithNode:objectDictionary[@"agentObject"]];
            
            self.agentDetialInfoDetialModel = agentDetialInfoDetialModel;
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark -设置tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 230;
    }else if(indexPath.section == 1){
        return 65;
    }
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AgentDetialCell * cell;
    
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"AgentDetialInfoCell"];
        
    }else if(indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"AgentDetialEvaluateCell"];
    }
    cell.detialModel = self.agentDetialInfoDetialModel;
    
    return cell;
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
    
    if([segue.identifier isEqualToString:@"ShowChatMessage"]){
        
    }
}


@end
