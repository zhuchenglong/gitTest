//
//  NSObject+AlertView.h
//  HUI
//
//  Created by zhuchenglong on 16/3/23.
//  Copyright © 2016年 zhuchenglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//把点击的相应的按钮传过去
typedef void (^HandleAlert)(id action);

@interface NSObject (AlertView)


-(void)showMessage:(NSString *)message target:(UIViewController *)viewController handle:(HandleAlert)handleAlert;

-(void)showCustomTitle:(NSString *)title message:(NSString *)message actionTitleArray:(NSArray *)actionArray target:(UIViewController *)viewController handle:(HandleAlert)handleAlert;

-(void)showAlert:(NSString *)message buttonTitle:(NSString *)title target:(UIViewController *)viewController handle:(HandleAlert)handleAlert;

-(void)showMessage:(NSString*)message;

//只显示确定
-(void)showSureMessage:(NSString *)message target:(UIViewController *)viewController handle:(HandleAlert)handleAlert;

-(void)showMoreAlertWithTarget:(UIViewController *)target Title:(NSString *)title message:(NSString *)message actionTitleArray:(NSArray *)titleArray handle:(HandleAlert)handleAlert;
@end
