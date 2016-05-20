//
//  VerificationViewController.h
//  medEcash
//
//  Created by Apple on 12/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UserSignInViewController.h"
#import "ValidateUserViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
@interface VerificationViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
- (IBAction)verificationBtnAction:(id)sender;
- (IBAction)iHaveAccountBtnAction:(id)sender;
- (IBAction)helpBtnAction:(id)sender;

@end
