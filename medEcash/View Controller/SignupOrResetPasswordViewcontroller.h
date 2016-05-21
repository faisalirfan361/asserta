//
//  SignupOrResetPasswordViewcontroller.h
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentsViewController.h"
#import "CallUsViewcontroller.h"
#import "User.h"
#import "MBProgressHUD.h"
@interface SignupOrResetPasswordViewcontroller : UIViewController <UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
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
@end
