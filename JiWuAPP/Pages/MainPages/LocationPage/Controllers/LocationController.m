//
//  LocationController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "LocationController.h"

#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "LocationModel.h"

#import "LocationCell.h"
#import "AreaLocationCell.h"
#import "CPSLocationCell.h"
#import "HotLocationCell.h"

@interface LocationController ()<CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager * locationManager;
@property (nonatomic) NSString * cityName;

@property (nonatomic) NSMutableArray * dataArray;
@property (nonatomic) NSMutableArray * sectionArray;
@property (nonatomic) NSMutableArray * titlesArray;


@end

@implementation LocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    
    self.sectionArray = [NSMutableArray new];
    self.dataArray = [NSMutableArray new];
    self.titlesArray = [NSMutableArray new];
    
    if(![CLLocationManager locationServicesEnabled]){
        NSLog(@"Location Service Not Enable");
        return;
    }
    self.locationManager = [CLLocationManager new];
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    [self loadData];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation * location = locations[0];
    
    CLGeocoder * geoCoder = [CLGeocoder new];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * placeMark = [placemarks firstObject];
        self.cityName = placeMark.administrativeArea;
    }];
   
    
    NSLog(@"6.0 - location : %@",location);
    [self.locationManager stopUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    CLGeocoder * geoCoder = [CLGeocoder new];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * placeMark = [placemarks firstObject];
        self.cityName = placeMark.administrativeArea;
    }];
    
    NSLog(@"5.0 - location : %@",newLocation);
    [self.locationManager stopUpdatingLocation];
}


-(void)loadData{
    
    if([[NSFileManager defaultManager] fileExistsAtPath:self.cachePath]){
        [self loadDataFromLocal];
    }else{
        [self loadDataFromServer];
    }
    
}
-(void)loadDataFromLocal{
    NSMutableArray * hotCityArray = [NSMutableArray new];
    NSMutableArray * gpsArray = [NSMutableArray new];
    NSMutableDictionary * titleMutableDictionary = [NSMutableDictionary dictionary];
    
    NSData * data = [NSData dataWithContentsOfFile:self.cachePath];
    
    NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * objectArray = objectDictionary[@"cityArray"];
    
    
    for(NSDictionary * dict in objectArray){
        NSString * cityFirstName = dict[@"pingyin"];
        [titleMutableDictionary setValue:[[cityFirstName uppercaseString] substringToIndex:1] forKey:[[cityFirstName uppercaseString] substringToIndex:1]];
    }
    NSArray * titleArray = [titleMutableDictionary.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [self.titlesArray addObject:@"GPS定位"];
    [self.titlesArray addObject:@"热门城市"];
    [self.titlesArray addObjectsFromArray:titleArray];
    
    for(int i=0;i<titleArray.count;i++){
        
        NSMutableArray * subArray = [NSMutableArray new];
        for(NSDictionary * dict in objectArray){
            LocationModel * locationModel = [LocationModel locationModelWithNode:dict];
            
            NSString * cityUpName = [[locationModel.pingyin uppercaseString] substringToIndex:1];
            if([titleArray[i] isEqualToString:cityUpName]){
                [subArray addObject:locationModel];
            }
            
            if(i == 0){
                if([locationModel.hot intValue] == 1){
                    [hotCityArray addObject:locationModel];
                }
                if([self.cityName isEqualToString:locationModel.cityName]){
                    [gpsArray addObject:locationModel];
                }
            }
        }
        [self.dataArray addObject:subArray];
    }
    
    NSMutableArray * hotArray = [NSMutableArray new];
    for(int j=0;j<titleArray.count;j++){
        for(int i=0;i<hotCityArray.count;i++){
            LocationModel * model = hotCityArray[i];
            NSString * firstname = [[model.pingyin uppercaseString] substringToIndex:1];
            if([firstname isEqualToString:titleArray[j]]){
                [hotArray addObject:model];
            }
        }
    }
    if(gpsArray.count >0){
        LocationModel * gpsModel = [gpsArray firstObject];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LocationCity"];
        [[NSUserDefaults standardUserDefaults] setObject:@{@"cityId":gpsModel.cityId,@"cityName":gpsModel.cityName} forKey:@"LocationCity"];
    }
    [self.sectionArray addObject:gpsArray];
    [self.sectionArray addObject:@[hotArray]];
    [self.sectionArray addObjectsFromArray:self.dataArray];
    
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
            return ;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * array = self.sectionArray[section];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationCell * cell;
    LocationModel * model;
    NSArray * array;
    if(indexPath.section != 1){
        model = self.sectionArray[indexPath.section][indexPath.row];
    }else{
        array = self.sectionArray[indexPath.section][indexPath.row];
    }
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"CPSLocationCell"];
        cell.model = model;
        return cell;
    }else if(indexPath.section == 1){
        cell = [HotLocationCell hotLocationCellWithTableView:tableView];
        cell.modelArray = array;
        [cell setButtonClickedBlock:^(LocationModel * locationodel) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LocationCity"];
            [[NSUserDefaults standardUserDefaults] setObject:@{@"cityId":locationodel.cityId,@"cityName":locationodel.cityName} forKey:@"LocationCity"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        return cell;
    }
    
    cell = [AreaLocationCell areaLocationCellWithTableView:tableView];
    cell.model = model;
    return cell;
    
   
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        NSArray * array = [self.sectionArray[indexPath.section] firstObject];
        return 30 * (array.count / 4) + 10 * (array.count / 4 + 1);
    }
    return 44;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.titlesArray[section];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.titlesArray;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section >= 2){
        LocationModel * model = self.sectionArray[indexPath.section][indexPath.row];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LocationCity"];
        [[NSUserDefaults standardUserDefaults] setObject:@{@"cityId":model.cityId,@"cityName":model.cityName} forKey:@"LocationCity"];
        [self.navigationController popViewControllerAnimated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
