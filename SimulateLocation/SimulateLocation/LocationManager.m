//
//  LocationManager.m
//  FarmApp
//
//  Created by zhuchenglong on 2018/12/2.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import "LocationManager.h"
#import "NSObject+AlertView.h"
@implementation LocationManager
//http://blog.csdn.net/xiaoxiaobukuang/article/details/51726904


+ (instancetype)manager{
    static dispatch_once_t onceToken;
    static LocationManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(CLLocationManager *)locationManager{
    if (!_locationManager){
        _locationManager = [[CLLocationManager alloc]init];
    }
    return _locationManager;
}

-(void)getLocationInfo:(void(^)(NSString *longitude,NSString *latitude,NSString *altitude))locationComplete{
    
    self.locationHandel = locationComplete;
    
    if([CLLocationManager locationServicesEnabled]) {
        
        self.locationManager.delegate = self;
        
        //下面的两个方法对应不同的key(Info.plist)
        //征求用户的统同意(前台和后台)
        [self.locationManager requestAlwaysAuthorization];
        //征求用户的同意(只在前台)
        [self.locationManager requestWhenInUseAuthorization];
        //实时更新定位位置,每隔多少米定位一次（这里的设置为每隔百米)
        // self.locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置距离过滤器为50米，表示每移动50米更新一次位置
        self.locationManager.distanceFilter = 50;
        //定位精确度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //持续定位
        //该模式是抵抗程序在后台被杀，申明不能够被暂停
        self.locationManager.pausesLocationUpdatesAutomatically = NO;
        // self.locationManager.allowsBackgroundLocationUpdates = YES;
        
        //判定iOS版本
       if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.locationManager requestAlwaysAuthorization]; // 永久授权
            [self.locationManager requestWhenInUseAuthorization]; //使用中授权
        }
        
        //[self.locationManager startUpdatingHeading];//跟踪位置和方向
        [self.locationManager startUpdatingLocation];//跟踪位置
        
    }else {
        //提示用户无法进行定位操作
        [self showMessage:@"请开启定位:设置 > 隐私 > 位置 > 定位服务"];
    }
}

-(void)stopUpdatingLocation{
    //手动停止定位的操作
    [self.locationManager stopUpdatingLocation];
}


#pragma mark -- CLLocationManagerDelegate
//成功获取定位数据后将会触发该方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //获取最后一个定位数据
    CLLocation *location = [locations lastObject];
    //依次获取CLLocation中封装的经度、纬度、高度、速度、方向等信息
    NSLog(@"纬度:%f,经度:%f,海拔:%f,速度:%f,方向:%f",location.coordinate.latitude,location.coordinate.longitude,location.altitude,location.speed,location.course);
    NSString *longitude = [NSString stringWithFormat:@"%.5f",location.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%.5f",location.coordinate.latitude];
    NSString *altitude = [NSString stringWithFormat:@"%.0f",location.altitude];
    
    // 获取当前所在的城市名
    self.geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error){
     //一样，一般取最后一位
        if (placemarks.count > 0){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"---->%@",[placemark description]);
            NSLog(@"--地点-->%@",placemark.name);
            NSLog(@"--国家-->%@",placemark.country);
            NSLog(@"--省份-->%@",placemark.administrativeArea);
            NSLog(@"--城市-->%@",placemark.locality);
            NSLog(@"--区域-->%@",placemark.subLocality);
            
            
            NSString *city = placemark.locality;
            if (!city) {
            //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            
            NSString *address = [NSString stringWithFormat:@"%@%@%@%@",placemark.administrativeArea,placemark.locality,placemark.subLocality,placemark.name];
            
            if (self.locationHandel) {
                self.locationHandel(longitude,latitude,address);
            }
        }
       
        
     }];
    
}
//定位失败时触发的方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败：%@",error);
}

@end
