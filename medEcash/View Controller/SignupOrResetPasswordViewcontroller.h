//
//  SignupOrResetPasswordViewcontroller.h
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentsViewController.h"
@interface SignupOrResetPasswordViewcontroller : UIViewController <UITextFieldDelegate>{
    BOOL passwordShown;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)showPasswordBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;

- (IBAction)createAccountBtnAction:(id)sender;
@end
