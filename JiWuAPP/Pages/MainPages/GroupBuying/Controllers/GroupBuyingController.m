//
//  GroupBuyingController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/30.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "GroupBuyingController.h"

#import "AFNetworking.h"
#import "GroupBuyingCell.h"
#import "GroupBuyingModel.h"
#import "GroupBuyingDetialController.h"

#import "MJRefresh.h"

@interface GroupBuyingController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (nonatomic) NSInteger pageIndex;

@property (nonatomic,copy) NSMutableArray * dataArray;

@end

@implementation GroupBuyingController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        NSMutableArray * dataArray = [NSMutableArray array];
        _dataArray = dataArray;
    }
    return _dataArray;
}

#pragma mark -界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.pageIndex = 1;
    
    [self.view bringSubviewToFront:self.toolBar];
    
    [self loadData];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dealRefreshHead)];
    
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(dealRefreshBackFoot)];
    
}
#pragma mark -上推加载更多，下拉刷新
-(void)dealRefreshHead{
    [self loadDataFromServe];
    
}
-(void)endRefresh{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}
-(void)dealRefreshBackFoot{
    
    self.pageIndex = self.pageIndex + 1;
    
    NSString * cityID = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityId"];
    NSString * path = @"http://m.jiwu.com/app!buildList.action?v=1.4&appKey=7daf08ccfc302a08fa7a58341e8390ca&deviceId=862851029616599&cityId=%@&areaId=0&plateId=0&priceId=0&featureId=0&startId=%ld&pageSize=10&type=1";
    NSString * servePath = [NSString stringWithFormat:path,cityID,self.pageIndex];
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:servePath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject){
            NSDictionary * objectDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray * objectArray = objectDict[@"buildArray"];
            
            for(NSDictionary * node in objectArray){
                GroupBuyingModel * groupModel = [GroupBuyingModel groupBuyingModelWithNode:node];
                [self.dataArray addObject:groupModel];
            }
           
            [self.tableView reloadData];

        }else{
          //  self.pageIndex = self.pageIndex - 1;
            return ;
        }
        [self endRefresh];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
    }];
}
#pragma mark -订阅团购
- (IBAction)orderBarButtonClicked:(UIBarButtonItem *)sender {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"订阅团购" message:@"有新优惠将通知您" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
        
    }]];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -数据加载
-(void)loadData{
    [self loadDataFromServe];
}
-(void)loadDataFromServe{
    NSMutableArray * dataArray = [NSMutableArray array];
    
     NSString * cityID = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityId"];
    NSString * path = @"http://m.jiwu.com/app!buildList.action?v=1.4&appKey=7daf08ccfc302a08fa7a58341e8390ca&deviceId=862851029616599&cityId=%@&areaId=0&plateId=0&priceId=0&featureId=0&startId=1&pageSize=10&type=1";
    NSString * servePath = [NSString stringWithFormat:path,cityID];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:servePath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject){
            NSDictionary * objectDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray * objectArray = objectDict[@"buildArray"];
            
            if(self.dataArray.count > 0){
                [self.dataArray removeAllObjects];
            }
            
            for(NSDictionary * node in objectArray){
                GroupBuyingModel * groupModel = [GroupBuyingModel groupBuyingModelWithNode:node];
                [dataArray addObject:groupModel];
            }
            [self.dataArray addObjectsFromArray:dataArray];
            [self.tableView reloadData];
            if(self.dataArray.count > 0){
                [self.view bringSubviewToFront:self.tableView];
                self.backView.hidden = YES;
            }
             [self.view bringSubviewToFront:self.toolBar];
            
        }
        
        [self endRefresh];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
    }];
}

#pragma mark -配置TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 180;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupBuyingCell * cell;
    
    GroupBuyingModel * model = self.dataArray[indexPath.section];
    if(indexPath.row == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"GroupBuyingImageCell"];
    }else if(indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"GroupBuyingFeatureCell"];
    }
    cell.model = model;
    //cell的点击效果设置为None
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowGroupBuyingDetial" sender:@{@"indexPath":indexPath}];
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
    if([segue.identifier isEqualToString:@"ShowGroupBuyingDetial"]){
        GroupBuyingDetialController * groupBuyingController = segue.destinationViewController;
        NSIndexPath * indexPath = sender[@"indexPath"];
        GroupBuyingModel * groupModel = self.dataArray[indexPath.section];
        groupBuyingController.groupID = groupModel.grouponId;
    }
}


@end
