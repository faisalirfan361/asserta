//
//  PhotoViewController.h
//  SidebarDemo
//
//  Created by Simon on 30/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ValidateUserViewController.h"
#import "UserSignInViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "CallUsViewcontroller.h"
#import "User.h"
#import "SignupOrResetPasswordViewcontroller.h"
#import "ResetPasswordViewController.h"
@interface PhotoViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate> {
    NSMutableDictionary * responseDict;
    User *data;
    int code;
}
@property (strong, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
- (IBAction)verificationBtnAction:(id)sender;
- (IBAction)iHaveAccountBtnAction:(id)sender;
- (IBAction)helpBtnAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSString *photoFilename;
@end
