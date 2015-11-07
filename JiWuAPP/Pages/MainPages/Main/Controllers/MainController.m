//
//  MainController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MainController.h"

#import "AFNetworking.h"
#import "LocationController.h"
#import "NetInterface.h"
#import "LocationModel.h"
#import "MainHouseModel.h"
#import "MainHourseCell.h"
#import "MainTableHeadView.h"

#import "FreshController.h"
#import "SecondHandController.h"
#import "HelpMeFindHouseController.h"

#import "HouseDetialController.h"
#import "MJRefresh.h"

@interface MainController ()<UISearchBarDelegate,MainTableHeadViewDelegate>

@property (nonatomic,copy) NSMutableArray * dataArray;
@property (nonatomic) BOOL isChanged;
@property (nonatomic) BOOL isExpanded;

@property (nonatomic) NSInteger pageIndex;

@end

@implementation MainController

#pragma mark -页面即将消失
-(void)viewWillDisappear:(BOOL)animated{
    
}

#pragma mark -页面即将加载
-(void)viewWillAppear:(BOOL)animated{
    
    
    NSDictionary * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"];
    if(!city){
        LocationController * locationController = [LocationController new];
        locationController.serverPath = [NetInterface locationServerPath];
        locationController.cachePath = [NetInterface locationCachePath];
        [self.navigationController pushViewController:locationController animated:YES];
    }
    
   
    
    if(![city[@"cityName"] isEqualToString:self.navigationItem.leftBarButtonItem.title]){
        self.isChanged = YES;
    }else{
        self.isChanged = NO;
    }
    self.navigationItem.leftBarButtonItem.title = city[@"cityName"];
    [self updateLocation];
    
    //导航栏中间视图
    UISearchBar * searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = @"输入楼盘名称/关键词";
    searchBar.barTintColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.000 alpha:1.000];
    self.navigationItem.titleView = searchBar;
    
    

}
#pragma mark -实现searchDelegate的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    return;
}
#pragma mark -更新location
-(void)updateLocation{
    NSString * subServerPath = [NetInterface hotHouseServerPath];
    NSDictionary * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"];
    NSString * cityID = city[@"cityId"];
    self.serverPath = [NSString stringWithFormat:subServerPath,cityID,self.pageIndex];
    
    NSString * subLocalPriceServerPath = [NetInterface localPriceServerPath];
    self.localPriceServerPath = [NSString stringWithFormat:subLocalPriceServerPath,cityID];
    
    
    [self loadDataFromServerWithLocalPrice];
    
}

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        NSMutableArray * dataDataArray = [NSMutableArray array];
        _dataArray = dataDataArray;
    }
    return _dataArray;
}
#pragma mark -页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    MainTableHeadView * headView = [MainTableHeadView mainTableHeadView];
    CGFloat interval = 30;
    CGFloat width = (self.view.frame.size.width - (interval * 3 + interval / 2 * 2)) / 4;
    headView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, width + 30 +72);
    headView.delegate = self;
    [headView setMainTableHeadViewBlock:^(BOOL isClicked) {
        self.isExpanded = !isClicked;
        [self.tableView reloadData];
    }];
    
    self.tableView.tableHeaderView = headView;
    
    
    NSString * subServerPath = [NetInterface hotHouseServerPath];
    NSDictionary * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"];
    NSString * cityID = city[@"cityId"];
    self.pageIndex = 1;
   
    self.serverPath = [NSString stringWithFormat:subServerPath,cityID,self.pageIndex];
   
    self.cachePath = [NetInterface hotHouseCachePath];
    NSString * subLocalPriceServerPath = [NetInterface localPriceServerPath];
    self.localPriceServerPath = [NSString stringWithFormat:subLocalPriceServerPath,cityID];
    self.localPriceCachePath = [NetInterface localPriceCachePath];
    
    [self loadData];
    
    
   
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dealRefreshHead)];
    

    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(dealRefreshBackFoot)];
   
    
    
}

#pragma mark -上推加载更多，下啦刷新
-(void)dealRefreshHead{
    [self loadDataFromServer];
    [self loadDataFromServerWithLocalPrice];
}
-(void)endRefresh{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}
-(void)dealRefreshBackFoot{
    self.pageIndex = self.pageIndex + 1;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * subServerPath = [NetInterface hotHouseServerPath];
    
    NSDictionary * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"];
    NSString * cityID = city[@"cityId"];
    self.serverPath = [NSString stringWithFormat:subServerPath,cityID,self.pageIndex];
    
    [manager GET:self.serverPath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject){
            NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            NSArray * objectArray = objectDictionary[@"buildArray"];
        
            NSMutableArray * subDataArray = [NSMutableArray arrayWithArray:[self.dataArray lastObject]];
            for(NSDictionary * dict in objectArray){
                MainHouseModel * houseModel = [MainHouseModel mainHouseModelWithDictionary:dict];
                [subDataArray addObject:houseModel];
            }
          //  [self.dataArray replaceObjectAtIndex:1 withObject:subDataArray];
            [self.dataArray removeLastObject];
            [self.dataArray addObject:subDataArray];
            
            [self.tableView reloadData];

        }
        [self endRefresh];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma mark -数据加载
-(void)loadData{
    if([[NSFileManager defaultManager] fileExistsAtPath:self.cachePath] && [[NSFileManager defaultManager] fileExistsAtPath:self.localPriceCachePath]){
        
        [self loadDataFromLocal];
    }else{
        [self loadDataFromServerWithLocalPrice];
        
        
    }
}
-(void)loadDataFromLocal{
    
    NSMutableArray * dataArray = [NSMutableArray new];
    
    NSData * data = [NSData dataWithContentsOfFile:self.cachePath options:0 error:nil];
    NSData * localPriceData = [NSData dataWithContentsOfFile:self.localPriceCachePath options:0 error:nil];
    
    
    NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * localPriceObjectDictionary = [NSJSONSerialization JSONObjectWithData:localPriceData options:NSJSONReadingMutableContainers error:nil];
    
    NSArray * objectArray = objectDictionary[@"buildArray"];
    NSDictionary * localPriceObject = localPriceObjectDictionary[@"homeObject"];
    if(self.dataArray.count > 0){
        [self.dataArray removeAllObjects];
    }
    
    LocalPriceModel * localPriceModel = [LocalPriceModel localPriceModelWithDictionary:localPriceObject];
    NSArray * subLocalPriceArray = @[localPriceModel];
    [dataArray addObject:subLocalPriceArray];
    NSMutableArray * subDataArray = [NSMutableArray new];
    for(NSDictionary * dict in objectArray){
        MainHouseModel * houseModel = [MainHouseModel mainHouseModelWithDictionary:dict];
        [subDataArray addObject:houseModel];
    }
    [dataArray addObject:subDataArray];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.tableView reloadData];
}
-(void)loadDataFromServer{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:self.serverPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject){
            NSData * data = operation.responseData;
            [data writeToFile:self.cachePath options:0 error:nil];
            [self loadDataFromLocal];
        }
        [self endRefresh];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self endRefresh];
    }];
    
}
-(void)loadDataFromServerWithLocalPrice{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:self.localPriceServerPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject){
            NSData * data = operation.responseData;
            [data writeToFile:self.localPriceCachePath options:0 error:nil];
            [self loadDataFromServer];
           
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
#pragma mark -左侧城市barItem被点击时的处理事件
- (IBAction)leftBarButtonClicked:(UIBarButtonItem *)sender {
    LocationController * locationController = [LocationController new];
    locationController.serverPath = [NetInterface locationServerPath];
    locationController.cachePath = [NetInterface locationCachePath];
    [self.navigationController pushViewController:locationController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if(self.dataArray.count < 1){
        return 0;
    }
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.dataArray.count < 1){
        return 0;
    }
    NSArray * subArray = self.dataArray[section];
   
    if(section == 1){
        return subArray.count + 1;
    }else if(section == 0){
        return subArray.count;
    }

    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataArray.count < 1){
        return 0;
    }

    if(indexPath.section == 0){
        return 44;
    }
    if(indexPath.section == 1 && indexPath.row == 0){
        return  44;
    }
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return self.isExpanded ? 60 : 20;
    }if(section == 1){
        return 10;
    }
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.dataArray.count < 1){
        return nil;
    }

    
    if(indexPath.section == 0){
        LocalPriceModel * localPriceModel = self.dataArray[indexPath.section][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UItableViewCell"];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UItableViewCell"];
        }
        cell.textLabel.text = localPriceModel.averPrice;
        //cell的点击效果设置为None
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            UITableViewCell * commonCell = [tableView dequeueReusableCellWithIdentifier:@"UItableViewCell"];
            if(!commonCell){
                commonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault     reuseIdentifier:@"UItableViewCell"];
            }
            commonCell.textLabel.text = @"热门楼盘";
            //cell的点击效果设置为None
            commonCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return commonCell;

        }else if(indexPath.row > 0){
        
            NSArray * subArray = self.dataArray[indexPath.section];
            if(indexPath.row > subArray.count){
                return nil;
            }
           
            MainHouseModel * houseModel = subArray[indexPath.row - 1];
   
            MainHourseCell * houseCell = [tableView dequeueReusableCellWithIdentifier:@"MainHouseCell"];
            houseCell.model = houseModel;
            
            //cell的点击效果设置为None
            houseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return houseCell;
        }
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"ShowHouseDetial" sender:@{@"indexPath":indexPath}];
    
}
#pragma mark -实现mainTableHeaderView代理
-(void)dealTingsWhenButtonClicked:(NSInteger)index serverPath:(NSString *)serverPath cachePath:(NSString *)cachepath{
    
//    NSDictionary * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"];
//    NSString * cityID = city[@"cityId"];
   
    if(index == 1){
        [self performSegueWithIdentifier:@"ShowFreshHouse" sender:nil];
    }else if(index == 3){
        [self performSegueWithIdentifier:@"ShowSecondHandHouse" sender:nil];
    }else if(index == 4){
        [self performSegueWithIdentifier:@"ShowHelpMeFindHouse" sender:nil];
    }else if(index == 2){
        [self performSegueWithIdentifier:@"ShowGroupBuying" sender:nil];
    }
    
    

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
//    NSString * cityID = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityId"];
    if([segue.identifier isEqualToString:@"ShowFreshHouse"]){
        FreshController * freshController = segue.destinationViewController;
        
        freshController.cachePath = [NetInterface freshHouseCachePath];
        freshController.isChanged = self.isChanged;
    }else if([segue.identifier isEqualToString:@"ShowSecondHandHouse"]){
        SecondHandController * secondHandController = segue.destinationViewController;
        
        secondHandController.cachePath = [NetInterface secondHandHouseCachePath];
        secondHandController.isChanged = self.isChanged;

    }else if([segue.identifier isEqualToString:@"ShowHouseDetial"]){
        NSIndexPath * indexPath = sender[@"indexPath"];
        MainHouseModel * buildModel = self.dataArray[indexPath.section][indexPath.row-1];
        HouseDetialController * buildDetialController = segue.destinationViewController;
        buildDetialController.buildModelID = buildModel.ID;
    }else if([segue.identifier isEqualToString:@"ShowHelpMeFindHouse"]){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HelpMeFindAddress"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HelpMeFindPrice"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HelpMeFindHouseType"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HelpMeFindFeature"];
        


        
    }else if([segue.identifier isEqualToString:@"ShowGroupBuying"]){
        
        
        
    }


}


@end
