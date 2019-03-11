//
//  NSObject+AlertView.m
//  HUI
//
//  Created by zhuchenglong on 16/3/23.
//  Copyright © 2016年 zhuchenglong. All rights reserved.
//

#import "NSObject+AlertView.h"

@implementation NSObject (AlertView)

-(void)showMessage:(NSString *)message target:(UIViewController *)viewController handle:(HandleAlert)handleAlert{
    
    //告知用户缓存文件大小并争取用户的同意是否可以清除
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (action) {
            handleAlert(@"0");
        }
    }];
    
    [alertController addAction:cancelAction];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (action) {
            handleAlert(@"1");
        }
    }];
    [alertController addAction:action];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

-(void)showCustomTitle:(NSString *)title message:(NSString *)message actionTitleArray:(NSArray *)actionArray target:(UIViewController *)viewController handle:(HandleAlert)handleAlert{
    

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:actionArray[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (action) {
            handleAlert(@"0");
        }
    }];
    
    [alertController addAction:cancelAction];
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionArray[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (action) {
            handleAlert(@"1");
        }
    }];
    [alertController addAction:action];
    [viewController presentViewController:alertController animated:YES completion:nil];
}


-(void)showAlert:(NSString *)message buttonTitle:(NSString *)title target:(UIViewController *)viewController handle:(HandleAlert)handleAlert{
    
    //告知用户缓存文件大小并争取用户的同意是否可以清除
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (action) {
            
            handleAlert(@"1");
        }
    }];
    [alertController addAction:action];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

-(void)showSureMessage:(NSString *)message target:(UIViewController *)viewController handle:(HandleAlert)handleAlert{
    
    //告知用户缓存文件大小并争取用户的同意是否可以清除
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (action) {
            handleAlert(@"1");
        }
    }];
    [alertController addAction:action];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

-(void)showMessage:(NSString*)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}


-(void)showMoreAlertWithTarget:(UIViewController *)target Title:(NSString *)title message:(NSString *)message actionTitleArray:(NSArray *)titleArray handle:(HandleAlert)handle{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:titleArray[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (action) {
            handle(@"0");
        }
    }];
    [alertController addAction:action1];

    UIAlertAction *action2 = [UIAlertAction actionWithTitle:titleArray[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (action) {
            handle(@"1");
        }
    }];
    [alertController addAction:action2];
    
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:titleArray[2] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (action) {
            handle(@"2");
        }

    }];
    [alertController addAction:action3];
    
    [target presentViewController:alertController animated:YES completion:nil];

}




@end
