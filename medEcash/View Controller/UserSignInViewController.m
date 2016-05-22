//
//  UserSignInViewController.m
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "UserSignInViewController.h"

@implementation UserSignInViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    passwordShown=NO;
    self.userNameTxtField.delegate = self;
    self.passwordTxtField.delegate = self;
    UIColor * color = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0];
        CALayer *border = [CALayer layer];
        CGFloat borderWidth = 2;
        border.borderColor = color.CGColor;
        border.frame = CGRectMake(0, self.userNameTxtField.frame.size.height - borderWidth, self.userNameTxtField.frame.size.width, self.userNameTxtField.frame.size.height);
        border.borderWidth = borderWidth;
        [self.userNameTxtField.layer addSublayer:border];
        self.userNameTxtField.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 2;
    border1.borderColor = color.CGColor;
    border1.frame = CGRectMake(0, self.passwordTxtField.frame.size.height - borderWidth1, self.passwordTxtField.frame.size.width, self.userNameTxtField.frame.size.height);
    border1.borderWidth = borderWidth1;
    [self.passwordTxtField.layer addSublayer:border1];
    self.passwordTxtField.layer.masksToBounds = YES;
}
- (IBAction)showPasswordTickBtnAction:(id)sender {
    
    if (passwordShown == YES) {
        passwordShown = NO;
        self.passwordTxtField.secureTextEntry = YES;
        [self.showPasswordTickBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        
    } else {
        
        passwordShown =YES;
        self.passwordTxtField.secureTextEntry=NO;
        [self.showPasswordTickBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }

}

- (IBAction)signInBtnAction:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PaymentsViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"paymentsVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
- (IBAction)helpBtnAction:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CallUsViewcontroller *vc =[storyboard instantiateViewControllerWithIdentifier:@"CallUsVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
