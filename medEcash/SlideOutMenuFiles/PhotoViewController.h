//
//  PhotoViewController.h
//  SidebarDemo
//
//  Created by Simon on 30/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentsViewController.h"
#import "CallUsViewcontroller.h"
#import "User.h"
#import "MBProgressHUD.h"
#import "UserSignInViewController.h"
@interface PhotoViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
    BOOL passwordShown;
    NSMutableDictionary * responseDict;
    User *data;
}
@property (strong, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)showPasswordBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;
- (IBAction)helpBtnAction:(id)sender;
- (IBAction)createAccountBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) NSString *photoFilename;
@end
