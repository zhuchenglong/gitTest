//
//  LocationManager.h
//  FarmApp
//
//  Created by zhuchenglong on 2018/12/2.
//  Copyright © 2018年 王勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//引入头文件
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)CLGeocoder *geocoder;
@property(nonatomic,copy)void(^locationHandel)(NSString *longitude,NSString *latitude,NSString *altitude);

+ (instancetype)manager;

-(void)getLocationInfo:(void(^)(NSString *longitude,NSString *latitude,NSString *altitude))locationComplete;

-(void)stopUpdatingLocation;
@end

NS_ASSUME_NONNULL_END
