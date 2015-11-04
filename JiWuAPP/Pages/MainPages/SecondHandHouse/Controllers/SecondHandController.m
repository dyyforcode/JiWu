//
//  SecondHandController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "SecondHandController.h"

#import "AFNetworking.h"
#import "Masonry.h"

#import "NetInterface.h"

#import "SecondHandHouseModel.h"
#import "SecondHandCell.h"

#import "AreaChooseModel.h"
#import "SubAreaChooseModel.h"
#import "PriceChooseModel.h"
#import "HouseTypeModel.h"

#import "MJRefresh.h"

@interface SecondHandController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;



@property (nonatomic,weak) UITableView * menuTableView;
@property (nonatomic,weak) UITableView * subMenuTableView;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) NSInteger chooseIndex;


@property (nonatomic,copy) NSMutableArray * menuBarAreaArray;
@property (nonatomic,copy) NSMutableArray * menuBarPriceArray;
@property (nonatomic,copy) NSMutableArray * menuBarHouseTypeArray;


@property (nonatomic,copy) NSString * areaId;
@property (nonatomic,copy) NSString * plateId;
@property (nonatomic,copy) NSString * priceId;
@property (nonatomic,copy) NSString * houseId;

@property (nonatomic,copy) NSString * areaName;
@property (nonatomic,copy) NSString * priceName;
@property (nonatomic,copy) NSString * houseName;

@property (nonatomic) NSInteger pageIndex;

@end

@implementation SecondHandController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        NSMutableArray * dataArray = [NSMutableArray array];
        _dataArray = dataArray;
    }
    return _dataArray;
}

#pragma mark -页面即将加载
-(void)viewWillAppear:(BOOL)animated{
    
    
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

#pragma mark -页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.areaId = @"0";
    self.plateId = @"0";
    self.priceId = @"0";
    self.houseId = @"0";
    
    self.areaName = @"区域";
    self.priceName = @"总价";
    self.houseName = @"户型";
    
    self.pageIndex = 1;
    
    NSString * cityID = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityId"];
    self.serverPath = [NSString stringWithFormat:[NetInterface secondHandHouseServerPath],cityID,@"0",@"0",@"0",@"0",self.pageIndex];
    
    UITableView * menuTableView = [[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStylePlain];
    menuTableView.dataSource = self;
    menuTableView.delegate = self;
    [self.view addSubview:menuTableView];
    self.menuTableView = menuTableView;
    [self.view sendSubviewToBack:self.menuTableView];
    
    CGRect rect = self.tableView.frame;
    UITableView * subMenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(rect.size.width/2, self.tableView.frame.origin.y, rect.size.width/2, rect.size.height) style:UITableViewStylePlain];
    subMenuTableView.dataSource = self;
    subMenuTableView.delegate = self;
    subMenuTableView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:subMenuTableView];
    self.subMenuTableView = subMenuTableView;
    [self.view sendSubviewToBack:self.subMenuTableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self configMenuBar];
    
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
    
    NSString * cityID = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityId"];
    NSString * path = [NetInterface secondHandHouseServerPath];
    self.serverPath = [NSString stringWithFormat:path,cityID,self.areaId,self.plateId,self.priceId,self.houseId,self.pageIndex];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:self.serverPath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject){
            NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            NSArray * objectArray = objectDictionary[@"houseArray"];
            
           
            for(NSDictionary * dict in objectArray){
                SecondHandHouseModel * secondHandHouseModel = [SecondHandHouseModel secondHandHouseModelWithNode:dict];
                [self.dataArray addObject:secondHandHouseModel];
            }
        
            [self.tableView reloadData];
        }else{
            self.pageIndex = self.pageIndex - 1;
        }
        [self endRefresh];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self endRefresh];
    }];
}
#pragma mark -配置菜单条
-(void)configMenuBar{
    self.headView.userInteractionEnabled = YES;
    
    NSArray * buttonTitles = @[@"区域",@"户型",@"总价"];
    NSMutableArray * buttonArray = [NSMutableArray new];
    for(int i=0;i<3;i++){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectZero;
        button.tag = 101 + i;
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.headView addSubview:button];
        [buttonArray addObject:button];
        [button addTarget:self action:@selector(menuBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    CGFloat buttonWidth = self.headView.frame.size.width / 3;
    for(int i=0;i<3;i++){
        UIButton * button = buttonArray[i];
        UIButton * lastButton = (i != 0) ? buttonArray[i-1] : nil;
        if(!lastButton){
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.headView.mas_left);
                make.top.equalTo(self.headView.mas_top);
                make.width.equalTo(@(buttonWidth));
                make.height.equalTo(self.headView.mas_height);
            }];
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.mas_right);
                make.top.equalTo(lastButton.mas_top);
                make.width.equalTo(lastButton.mas_width);
                make.height.equalTo(lastButton.mas_height);
            }];
        }
    }
}

-(void)menuBarButtonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    NSInteger tag = sender.tag - 100;
    self.selectedIndex = tag;
   
    
    if(sender.selected){
        
        if(tag == 1){
            UIButton * button2 = (UIButton *)[self.headView viewWithTag:2+100];
            button2.selected = NO;
            UIButton * button3 = (UIButton *)[self.headView viewWithTag:3+100];
            button3.selected = NO;
            [self menuBarLoadAreaChooseDataFromServer];
        }else if(tag == 3){
            UIButton * button1 = (UIButton *)[self.headView viewWithTag:1+100];
            button1.selected = NO;
            UIButton * button2 = (UIButton *)[self.headView viewWithTag:2+100];
            button2.selected = NO;
            [self menuBarLoadPriceChooseDataFromServer];
        }else if(tag == 2){
            UIButton * button3 = (UIButton *)[self.headView viewWithTag:3+100];
            button3.selected = NO;
            UIButton * button1 = (UIButton *)[self.headView viewWithTag:1+100];
            button1.selected = NO;
            [self menuBarLoadHouseTypeChooseDataFromServer];
        }
    }
    CGFloat height = sender.selected ? self.tableView.frame.size.height : 0;
    
    CGRect rect = CGRectMake(self.menuTableView.frame.origin.x, self.menuTableView.frame.origin.y, self.menuTableView.frame.size.width, height);
    
    sender.selected ? [self.view bringSubviewToFront:self.menuTableView] : [self.view bringSubviewToFront:self.tableView];
    [UIView animateWithDuration:0.2 animations:^{
        
        self.menuTableView.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}
#pragma mark －menuBar数据加载
-(void)menuBarLoadAreaChooseDataFromServer{
    NSMutableArray * menuBarAreaArray = [NSMutableArray new];
    
    
    NSDictionary * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"];
    NSString * menubarServerPath = [NSString stringWithFormat:@"http://m.jiwu.com/app!cityDetail.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@",city[@"cityId"]];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:menubarServerPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject){
            
            NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * objectArray = dictionary[@"areaArray"];
            for(NSDictionary * node in objectArray){
                AreaChooseModel * areaModel = [AreaChooseModel areaChooseModelWidthNode:node];
                NSMutableArray * subMenuBarAreaArray = [NSMutableArray new];
                if(areaModel.plateArray.count > 0){
                    for(NSDictionary * dict in node[@"plateArray"]){
                        SubAreaChooseModel * subAreaModel = [SubAreaChooseModel subAreaChooseModelWithNode:dict];
                        [subMenuBarAreaArray addObject:subAreaModel];
                    }
                    areaModel.plateArray = subMenuBarAreaArray;
                }
                [menuBarAreaArray addObject:areaModel];
                
            }
            self.menuBarAreaArray = menuBarAreaArray;
            [self.menuTableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
-(void)menuBarLoadPriceChooseDataFromServer{
    
    NSMutableArray * menuBarPriceArray = [NSMutableArray new];
    
    NSDictionary * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"];
    NSString * menubarServerPath = [NSString stringWithFormat:@"http://m.jiwu.com/app!priceList.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@",city[@"cityId"]];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:menubarServerPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject){
            
            NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * objectArray = dictionary[@"priceArray"];
            for(NSDictionary * node in objectArray){
                PriceChooseModel * priceModel = [PriceChooseModel priceChooseModelWithNode:node];
                
                [menuBarPriceArray addObject:priceModel];
            }
            self.menuBarPriceArray = menuBarPriceArray;
            [self.menuTableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
-(void)menuBarLoadHouseTypeChooseDataFromServer{
    
    NSMutableArray * menuBarHouseTypeArray = [NSMutableArray new];
    
    NSArray * typeIdArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6"];
    NSArray * typeNameArray = @[@"全部",@"一房",@"二房",@"三房",@"四房",@"五房及以上",@"复式"];
    
    for(int i=0;i<typeIdArray.count;i++){
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        [dict setValue:typeIdArray[i] forKey:@"houseTypeId"];
        [dict setValue:typeNameArray[i] forKey:@"houseTypeName"];
        
        HouseTypeModel * houseTypeModel = [HouseTypeModel houseTypeModelWithNode:dict];
        
        [menuBarHouseTypeArray addObject:houseTypeModel];
        
    }
    self.menuBarHouseTypeArray = menuBarHouseTypeArray;
     [self.menuTableView reloadData];
    
}




#pragma mark -数据加载
-(void)loadData{
    if([[NSFileManager defaultManager] fileExistsAtPath:self.cachePath]){
        if(self.isChanged){
           
            
            return;
        }
        [self loadDataFromServer];
       // [self loadDataFromLocal];
    }else{
        [self loadDataFromServer];
        
       
    }
}
-(void)loadDataFromLocal{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    NSData * data = [NSData dataWithContentsOfFile:self.cachePath options:0 error:nil];
    
    
    NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    NSArray * objectArray = objectDictionary[@"houseArray"];
    
    
    if(self.dataArray.count > 1){
        [self.dataArray removeAllObjects];
    }
    
    
    
    for(NSDictionary * dict in objectArray){
        SecondHandHouseModel * secondHandHouseModel = [SecondHandHouseModel secondHandHouseModelWithNode:dict];
        [dataArray addObject:secondHandHouseModel];
    }
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.menuTableView){
        if(self.selectedIndex == 1){
            return self.menuBarAreaArray.count;
        }else if(self.selectedIndex == 3){
            return self.menuBarPriceArray.count;
        }else if(self.selectedIndex == 2){
            return self.menuBarHouseTypeArray.count;
        }
    }
    if(tableView == self.subMenuTableView){
        AreaChooseModel * areaModel = self.menuBarAreaArray[self.chooseIndex];
        return areaModel.plateArray.count;
    }

    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView != self.tableView){
        return 44;
    }
    

    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //self.menuTableView
    if(tableView == self.menuTableView){
        
        
        
        
        UITableViewCell * menuTableCell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
        if(!menuTableCell){
            menuTableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuTableViewCell"];
        }
        
        if(self.selectedIndex == 1){
            if(self.menuBarAreaArray.count < 1){
                return nil;
            }
            
            AreaChooseModel * areaModel = self.menuBarAreaArray[indexPath.row];
            menuTableCell.textLabel.text = areaModel.areaName;
        }else if(self.selectedIndex == 3){
            
            if(self.menuBarPriceArray.count < 1){
                return nil;
            }
            
            PriceChooseModel * priceModel = self.menuBarPriceArray[indexPath.row];
            menuTableCell.textLabel.text = priceModel.priceName;
        }else if(self.selectedIndex == 2){
            if(self.menuBarHouseTypeArray.count < 1){
                return nil;
            }
            
            HouseTypeModel * houseTypeModel = self.menuBarHouseTypeArray[indexPath.row];
            menuTableCell.textLabel.text = houseTypeModel.houseTypeName;
        }
        return menuTableCell;
        
    }
    //self.subMenuTableView;
    if(tableView == self.subMenuTableView){
        UITableViewCell * menuTableCell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
        if(!menuTableCell){
            menuTableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuTableViewCell"];
        }
        menuTableCell.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        
        AreaChooseModel * areaLoModel = self.menuBarAreaArray[self.chooseIndex];
        
        SubAreaChooseModel * subAreaLoModel = areaLoModel.plateArray[indexPath.row];
        
        menuTableCell.textLabel.text = subAreaLoModel.plateName;
        return menuTableCell;
    }
    //self.tableView
    
    if(self.dataArray.count < 1){
        return nil;
    }
    
    SecondHandHouseModel * houseModel = self.dataArray[indexPath.row];
    
    SecondHandCell * secondHandCell = [tableView dequeueReusableCellWithIdentifier:@"SecondHandCell"];
    
    
    secondHandCell.model = houseModel;
   
    
    
    
    return secondHandCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.menuTableView){
        CGRect rect = self.tableView.frame;
        if(self.selectedIndex == 1){
        
                [self.view bringSubviewToFront:self.subMenuTableView];
                if(self.chooseIndex == 0){
                    self.subMenuTableView.frame = CGRectMake(rect.size.width/2, self.tableView.frame.origin.y, rect.size.width/2, rect.size.height);
                    self.menuTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width/2, rect.size.height);
                }
                self.chooseIndex = indexPath.row;
                
                
           
            [self.subMenuTableView reloadData];
        }else if(self.selectedIndex == 3){
            PriceChooseModel * priceModel = self.menuBarPriceArray[indexPath.row];
            self.priceId = priceModel.priceId;
            self.priceName = priceModel.priceName;
        }else if(self.selectedIndex == 2){
            HouseTypeModel * houseTypeModel = self.menuBarHouseTypeArray[indexPath.row];
            self.houseId = houseTypeModel.houseTypeId;
            self.houseName = houseTypeModel.houseTypeName;
        }
        self.menuTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    }
    if(tableView == self.subMenuTableView){
        [self.view bringSubviewToFront:self.tableView];
        AreaChooseModel * areaModel = self.menuBarAreaArray[self.chooseIndex];
        SubAreaChooseModel * subAreaModel = areaModel.plateArray[indexPath.row];
        self.areaId = subAreaModel.areaId;
        self.plateId = subAreaModel.plateId;
        self.areaName = subAreaModel.plateName;
        
        
        NSString * cityID = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityId"];
        NSString * path = [NetInterface secondHandHouseServerPath];
        self.serverPath = [NSString stringWithFormat:path,cityID,self.areaId,self.plateId,self.priceId,self.houseId,1];
        UIButton * button = (UIButton *)[self.headView viewWithTag:(self.selectedIndex + 100)];
        button.selected = NO;
        [self loadDataFromServer];
        [self.tableView reloadData];
    }
    if(self.selectedIndex != 1 || (self.selectedIndex == 1 && indexPath.row == 0)){
        [self.view bringSubviewToFront:self.tableView];
        NSString * cityID = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityId"];
        NSString * path = [NetInterface secondHandHouseServerPath];
        self.serverPath = [NSString stringWithFormat:path,cityID,self.areaId,self.plateId,self.priceId,self.houseId,1];
        UIButton * button = (UIButton *)[self.headView viewWithTag:(self.selectedIndex + 100)];
        button.selected = NO;
        [self loadDataFromServer];
        [self.tableView reloadData];
    }
    
    UIButton * areaButton = (UIButton *)[self.headView viewWithTag:(1+100)];
    [areaButton setTitle:self.areaName forState:UIControlStateNormal];
    UIButton * priceButton = (UIButton *)[self.headView viewWithTag:(3+100)];
    [priceButton setTitle:self.priceName forState:UIControlStateNormal];
    UIButton * featureButton = (UIButton *)[self.headView viewWithTag:(2+100)];
    [featureButton setTitle:self.houseName forState:UIControlStateNormal];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
