//
//  ResetPasswordViewController.h
//  medEcash
//
//  Created by Apple on 05/06/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "CallUsViewcontroller.h"
#import "MBProgressHUD.h"
#import "UserSignInViewController.h"
@interface ResetPasswordViewController : UIViewController <UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
    
 BOOL passwordShown;
 NSMutableDictionary * responseDict;
 User *data;
}
@property (nonatomic, retain) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordTextField;
@property (strong, nonatomic) NSMutableData *responseData;
- (IBAction)helpBtnAction:(id)sender;
- (IBAction)showPasswordBtnAction:(id)sender;
- (IBAction)resetPasswordBtnAction:(id)sender;
@end
