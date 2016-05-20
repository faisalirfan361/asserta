//
//  ValidateUserViewController.m
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ValidateUserViewController.h"

@implementation ValidateUserViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)validationNoBtnAction:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignupOrResetPasswordViewcontroller *vc =[storyboard instantiateViewControllerWithIdentifier:@"signupVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)validationYesBtnAction:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PaymentsViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"paymentsVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
