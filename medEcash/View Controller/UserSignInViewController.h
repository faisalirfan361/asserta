//
//  UserSignInViewController.h
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentsViewController.h"
@interface UserSignInViewController : UIViewController <UITextFieldDelegate>{
    BOOL passwordShown;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordTickBtn;
- (IBAction)showPasswordTickBtnAction:(id)sender;
- (IBAction)signInBtnAction:(id)sender;

@end
