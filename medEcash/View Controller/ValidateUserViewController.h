//
//  ValidateUserViewController.h
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentsViewController.h"
#import "SignupOrResetPasswordViewcontroller.h"
#import "CallUsViewcontroller.h"
#import "DHSidebarViewController.h"
#import "UserSignInViewController.h"
@interface ValidateUserViewController : UIViewController
- (IBAction)validationNoBtnAction:(id)sender;
- (IBAction)validationYesBtnAction:(id)sender;
- (IBAction)helpBtnAction:(id)sender;
@end
