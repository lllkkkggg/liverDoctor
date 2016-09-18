//
//  AuthorHelper.m
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/9.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import "AuthorHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation AuthorHelper
/**
 *  
 */
+(void)authenticateUser
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    NSString *result = @"fgbfgbf";
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError * _Nullable error) {
            if(success)
            {
                NSLog(@"成功");
            }
            else
            {
                switch (error.code)
                {
                    case LAErrorSystemCancel :
                    {
                        //切换到其他APP，系统取消验证Touch ID
                        NSLog(@"切换到其他APP");
                        break;
                    }
                        case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID ");
                        break;
                    }
                        case LAErrorUserFallback:
                    {
                        NSLog(@"用户选择其他验证方式");
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        
    }
    
    
}

@end
