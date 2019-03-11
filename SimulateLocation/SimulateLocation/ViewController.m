//
//  ViewController.m
//  SimulateLocation
//
//  Created by zhuchenglong on 2018/12/20.
//  Copyright © 2018年 zhuchenglong. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "LocationManager.h"
#import "ViewController.h"

@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)UILabel *longitudeLabel;
@property(nonatomic,strong)UILabel *latitudeLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"222");
    NSLog(@"333");
    NSLog(@"444");
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, self.view.bounds.size.width-60, 150)];
    imageView.image = [UIImage imageNamed:@"tupian"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    
    
    
    
    self.longitudeLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 280, self.view.bounds.size.width-50, 30)];
    [self.view addSubview:self.longitudeLabel];
    
    
    self.latitudeLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 330, self.view.bounds.size.width-50, 30)];
    [self.view addSubview:self.latitudeLabel];
    
    
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 380, self.view.bounds.size.width-50, 50)];
    self.addressLabel.numberOfLines = 2;
    self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    [self.view addSubview:self.addressLabel];
    
    
    UIButton *locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 500, self.view.bounds.size.width-50, 40)];
    locationBtn.backgroundColor = [UIColor orangeColor];
    [locationBtn setTitle:@"获取当前模拟定位信息" forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationBtn];
    
}

-(void)locationClick{
 
    __weak typeof(self) weakSelf = self;
    [[LocationManager manager]getLocationInfo:^(NSString * _Nonnull longitude, NSString * _Nonnull latitude, NSString * _Nonnull address) {
        weakSelf.longitudeLabel.text = [NSString stringWithFormat:@"模拟经度:%@",longitude];
        weakSelf.latitudeLabel.text = [NSString stringWithFormat:@"模拟纬度:%@",latitude];
        weakSelf.addressLabel.text = [NSString stringWithFormat:@"模拟地址:%@",address];
    }];
}

-(void)closeClick{
    [[LocationManager manager]stopUpdatingLocation];
}


@end
