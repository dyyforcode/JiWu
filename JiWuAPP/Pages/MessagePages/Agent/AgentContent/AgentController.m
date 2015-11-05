//
//  AgentController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "AgentController.h"

#import "AFNetworking.h"
#import "AgentModel.h"
#import "AgentCell.h"

#import "AgentDetialController.h"

#import "MJRefresh.h"

@interface AgentController ()

@property (nonatomic,copy) NSMutableArray * dataArray;

@property (nonatomic) NSInteger pageIndex;

@end

@implementation AgentController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        NSMutableArray * dataArray = [NSMutableArray array];
        _dataArray = dataArray;
    }
    return _dataArray;
}
#pragma  mark -页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.pageIndex = 1;
    
    [self loadData];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dealRefreshHead)];
    
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(dealRefreshBackFoot)];
    
}
#pragma mark -上推加载更多，下拉刷新
-(void)dealRefreshHead{
    [self loadDataFromServer];
    
}
-(void)endRefresh{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}
-(void)dealRefreshBackFoot{
    
    self.pageIndex = self.pageIndex + 1;
    
    NSString * path = @"http://m.jiwu.com/app!agentList.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@&areaId=0&startId=%d&pageSize=10";
    
    NSString * serverPath = [NSString stringWithFormat:path,self.cityId,self.pageIndex];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:serverPath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject){
            
            NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * objectArray = objectDictionary[@"agentArray"];
            for(NSDictionary * node in objectArray){
                AgentModel * agentModel = [AgentModel agentModelWithNode:node];
                [self.dataArray addObject:agentModel];
            }
            
            
            [self.tableView reloadData];
        }
        [self endRefresh];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
    }];

}
#pragma mark -数据加载
-(void)loadData{
    [self loadDataFromServer];
}
-(void)loadDataFromServer{
    
    NSMutableArray * dataArray = [NSMutableArray array];
    
    NSString * path = @"http://m.jiwu.com/app!agentList.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@&areaId=0&startId=1&pageSize=10";
    
    NSString * serverPath = [NSString stringWithFormat:path,self.cityId];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:serverPath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject){
            if(self.dataArray.count > 0){
                [self.dataArray removeAllObjects];
            }
            NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * objectArray = objectDictionary[@"agentArray"];
            if(self.dataArray.count > 0){
                [self.dataArray removeAllObjects];
            }
            for(NSDictionary * node in objectArray){
                AgentModel * agentModel = [AgentModel agentModelWithNode:node];
                [dataArray addObject:agentModel];
            }
            [self.dataArray addObjectsFromArray:dataArray];
            
            [self.tableView reloadData];
        }
        [self endRefresh];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCell"];
    //cell的点击效果设置为None
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    AgentModel * agentModel = self.dataArray[indexPath.row];
    
    cell.agentModel = agentModel;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowAgentDetial" sender:@{@"indexPath":indexPath}];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"ShowAgentDetial"]){
        AgentDetialController * agentDetialController = segue.destinationViewController;
        
        NSIndexPath * indexpath = sender[@"indexPath"];
        AgentModel * agentModel = self.dataArray[indexpath.row];
        
        agentDetialController.phoneNumber = agentModel.mobile;
    }
}


@end
