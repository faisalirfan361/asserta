//
//  SignupOrResetPasswordViewcontroller.m
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "SignupOrResetPasswordViewcontroller.h"

@implementation SignupOrResetPasswordViewcontroller
- (void)viewDidLoad {
    [super viewDidLoad];
    passwordShown=NO;
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
}
- (IBAction)showPasswordBtnAction:(id)sender {
    
    if (passwordShown == YES) {
        passwordShown = NO;
        self.passwordTextField.secureTextEntry = YES;

        [self.showPasswordBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        
    } else {
        
        passwordShown =YES;
        self.passwordTextField.secureTextEntry = NO;
        [self.showPasswordBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
- (IBAction)createAccountBtnAction:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PaymentsViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"paymentsVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
