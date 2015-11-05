//
//  AttentionHouseController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/5.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "AttentionHouseController.h"

#import "DataBaseManager.h"
#import "FreshHouseCell.h"
#import "MainHouseModel.h"

@interface AttentionHouseController ()

@property (nonatomic) DataBaseManager * dataManager;

@property (nonatomic) NSMutableArray * titleArray;
@property (nonatomic) NSMutableArray * dataArray;

@end

@implementation AttentionHouseController

-(NSMutableArray *)titleArray{
    if(!_titleArray){
        NSMutableArray * titleArray = [NSMutableArray array];
        _titleArray = titleArray;
    }
    return _titleArray;
}
-(NSMutableArray *)dataArray{
    if(!_dataArray){
        NSMutableArray * dataArray = [NSMutableArray array];
        _dataArray = dataArray;
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dataManager = [DataBaseManager shareManager];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self loadData];
}
-(void)loadData{
    NSArray * array = [self.dataManager selectAttentionHouse];
    NSMutableDictionary * mutableDict = [NSMutableDictionary dictionary];
    for(NSDictionary * dict in array){
        [mutableDict setValue:dict forKey:dict[@"cityName"]];
    }
    [self.titleArray addObjectsFromArray:[mutableDict allKeys]];
    for(NSString * str in self.titleArray){
        NSLog(@"%@",str);
        NSMutableArray * subArray = [NSMutableArray array];
        for(NSDictionary * dict in array){
            if([dict[@"cityName"] isEqualToString:str]){
                [subArray addObject:dict];
            }
        }
        [self.dataArray addObject:subArray];
    }
    [self.tableView reloadData];
    NSLog(@"arrayCount : %ld",self.titleArray.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * subArray = self.dataArray[section];
    NSLog(@" section %ld   %ld",section,subArray.count);
    return subArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    FreshHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FreshHouseCell"];
    NSArray * subArray = self.dataArray[indexPath.section];
    if(subArray.count < 1){
        return nil;
    }
   
    // Configure the cell...
    NSDictionary * dict = subArray[indexPath.row];
    MainHouseModel * houseModel = [MainHouseModel mainHouseModelWithDictionary:dict];
    cell.houseModel = houseModel;
    
    
    return cell;
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
