//
//  HelpMeFindChooseController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HelpMeFindChooseController.h"

#import "AFNetworking.h"

#import "AreaChooseModel.h"
#import "SubAreaChooseModel.h"
#import "PriceChooseModel.h"
#import "HouseTypeModel.h"

@interface HelpMeFindChooseController ()<UITableViewDataSource,UITableViewDelegate>

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
@property (nonatomic,copy) NSString * featureId;

@property (nonatomic,copy) NSString * areaName;
@property (nonatomic,copy) NSString * priceName;
@property (nonatomic,copy) NSString * featureName;


@end

@implementation HelpMeFindChooseController


#pragma mark -页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITableView * menuTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    menuTableView.dataSource = self;
    menuTableView.delegate = self;
    [self.view addSubview:menuTableView];
    self.menuTableView = menuTableView;
    [self.view bringSubviewToFront:self.menuTableView];
    
    
    CGRect rect = self.view.bounds;
    UITableView * subMenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(rect.size.width/2, self.view.bounds.origin.y, rect.size.width/2, rect.size.height) style:UITableViewStylePlain];
    subMenuTableView.dataSource = self;
    subMenuTableView.delegate = self;
    subMenuTableView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:subMenuTableView];
    self.subMenuTableView = subMenuTableView;
    [self.view sendSubviewToBack:self.subMenuTableView];

    
}



-(void)setIndex:(NSInteger)index{
   
    
    NSInteger tag = index + 1;
    self.selectedIndex = tag;
        
    if(tag == 1){
           
        [self menuBarLoadAreaChooseDataFromServer];
    }else if(tag == 2){
           
        [self menuBarLoadPriceChooseDataFromServer];
    }else if(tag == 3){
           
        [self menuBarLoadFeatureChooseDataFromServer];
    }
   
    CGFloat height =  self.view.bounds.size.height;
    
    CGRect rect = CGRectMake(self.menuTableView.frame.origin.x, self.menuTableView.frame.origin.y + 64, self.menuTableView.frame.size.width, height);
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.menuTableView.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}
#pragma mark －menuBar数据加载
-(void)menuBarLoadAreaChooseDataFromServer{
    NSMutableArray * menuBarAreaArray = [NSMutableArray new];
    
    
    NSDictionary * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"];
    NSString * menubarServerPath = [NSString stringWithFormat:@"http://m.jiwu.com/app!cityDetail.action?v=1.4&appKey=7daf08ccfc302a08fa7a58341e8390ca&deviceId=862851029616599&cityId=%@",city[@"cityId"]];
    
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
    NSString * menubarServerPath = [NSString stringWithFormat:@"http://m.jiwu.com/app!priceList.action?v=1.4&appKey=7daf08ccfc302a08fa7a58341e8390ca&deviceId=862851029616599&cityId=%@",city[@"cityId"]];
    
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
-(void)menuBarLoadFeatureChooseDataFromServer{

        
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.menuTableView){
        if(self.selectedIndex == 1){
            return self.menuBarAreaArray.count;
        }else if(self.selectedIndex == 2){
            return self.menuBarPriceArray.count;
        }else if(self.selectedIndex == 3){
            return self.menuBarHouseTypeArray.count;
        }
    }
    if(tableView == self.subMenuTableView){
        AreaChooseModel * areaModel = self.menuBarAreaArray[self.chooseIndex];
        return areaModel.plateArray.count;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44;
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
           
        }else if(self.selectedIndex == 2){
            
            if(self.menuBarPriceArray.count < 1){
                return nil;
            }
            
            PriceChooseModel * priceModel = self.menuBarPriceArray[indexPath.row];
            menuTableCell.textLabel.text = priceModel.priceName;
        }else if(self.selectedIndex == 3){
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
   
    
    
    
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.menuTableView){
        CGRect rect = self.view.frame;
        if(self.selectedIndex == 1){
            if(indexPath.row == 0){
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [self.view bringSubviewToFront:self.subMenuTableView];
                if(self.chooseIndex == 0){
                    self.subMenuTableView.frame = CGRectMake(rect.size.width/2, self.view.frame.origin.y, rect.size.width/2, rect.size.height);
                    self.menuTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width/2, rect.size.height);
                }
                self.chooseIndex = indexPath.row;
                
                
            }
            [self.subMenuTableView reloadData];
        }else if(self.selectedIndex == 2){
            PriceChooseModel * priceModel = self.menuBarPriceArray[indexPath.row];
            self.priceId = priceModel.priceId;
            self.priceName = priceModel.priceName;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HelpMeFindPrice"];
            [[NSUserDefaults standardUserDefaults] setObject:self.priceName forKey:@"HelpMeFindPrice"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else if(self.selectedIndex == 3){
            HouseTypeModel * houseTypeModel = self.menuBarHouseTypeArray[indexPath.row];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HelpMeFindHouseType"];
            [[NSUserDefaults standardUserDefaults] setObject:houseTypeModel.houseTypeName forKey:@"HelpMeFindHouseType"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        self.menuTableView.frame = CGRectMake(rect.origin.x, rect.origin.y + 64, rect.size.width, rect.size.height);
    }
    
    if(tableView == self.subMenuTableView){
        AreaChooseModel * areaModel = self.menuBarAreaArray[self.chooseIndex];
        SubAreaChooseModel * subAreaModel = areaModel.plateArray[indexPath.row];
        
        NSString * addressName = [NSString stringWithFormat:@"%@,%@",areaModel.areaName,subAreaModel.plateName];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HelpMeFindAddress"];
        [[NSUserDefaults standardUserDefaults] setObject:addressName forKey:@"HelpMeFindAddress"];
        [self.navigationController popViewControllerAnimated:YES];
    }
            
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
