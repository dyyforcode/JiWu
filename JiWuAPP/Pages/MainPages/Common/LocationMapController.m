//
//  LocationMapController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "LocationMapController.h"

#import <MapKit/MapKit.h>

#import "FLAnnotation.h"

@interface LocationMapController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic)CLLocationManager * manager;

@property(nonatomic)CLPlacemark * placemark;
@property(nonatomic)BOOL updateUserLocation;

@end

//设置key，运行时动态取FLAnnotation
//static char annStoreKey;
@implementation LocationMapController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(!self.latitude || !self.longitude){
        return;
    }
    if(![CLLocationManager locationServicesEnabled]){
        NSLog(@"MK");
        return;
    }
    self.manager = [CLLocationManager new];
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [self.manager requestWhenInUseAuthorization];
    }
    
    self.manager.delegate = self;

    self.mapView.delegate = self;
    
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.distanceFilter = 10;
    
    
    
    CLGeocoder * geoCoder = [CLGeocoder new];
    CLLocationCoordinate2D locationCoordinate2D = CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);
    [self.mapView setRegion:MKCoordinateRegionMake(locationCoordinate2D, MKCoordinateSpanMake(0.02, 0.02))];
    
    CLLocation * location = [[CLLocation alloc] initWithLatitude:locationCoordinate2D.latitude longitude:locationCoordinate2D.longitude];
    
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark * placeMark = placemarks[0];
        
        MKPointAnnotation * ann = [MKPointAnnotation new];
        ann.coordinate = locationCoordinate2D;
        ann.title = [NSString stringWithFormat:@"%@", self.name];
        ann.subtitle = placeMark.name;
        
        [self.mapView addAnnotation:ann];
        
        
    }];
    
    
    
}

#pragma mark - 自定义地图上的显示目标信息的视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if([annotation isKindOfClass:[FLAnnotation class]]){
        static NSString * annID = @"FL_ANN_ID";
        MKAnnotationView * annView = [mapView dequeueReusableAnnotationViewWithIdentifier:annID];
        //自定义地图上显示目标信息视图
        if(!annView){
            annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annID];
            annView.canShowCallout = YES;
            UIImageView * leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            annView.leftCalloutAccessoryView = leftImageView;
            
            
            annView.image = [UIImage imageNamed:@"icon_marker"];
            
            UIImageView * rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nav_share"]];
            rightImageView.userInteractionEnabled = YES;
            annView.rightCalloutAccessoryView = rightImageView;
            
           
        }
        
        
       
        
        
        return annView;
    }else{
        return nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
