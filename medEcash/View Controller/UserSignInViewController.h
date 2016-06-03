//
//  UserSignInViewController.h
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PaymentsViewController.h"
#import "CallUsViewcontroller.h"
#import "SignupOrResetPasswordViewcontroller.h"
#import "User.h"
#import "SWRevealViewController.h"
@interface UserSignInViewController : UIViewController <UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
    BOOL passwordShown;
    NSMutableDictionary * responseDict;
    User *data;

}
@property (nonatomic, retain) IBOutlet UIImageView *logo;
@property (strong, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UITextField *userNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordTickBtn;
- (IBAction)showPasswordTickBtnAction:(id)sender;
- (IBAction)signInBtnAction:(id)sender;
- (IBAction)helpBtnAction:(id)sender;
@end
