//
//  ValidateUserViewController.m
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ValidateUserViewController.h"

@implementation ValidateUserViewController

@synthesize dob = _dob;

- (void) passDOB:(NSString *)value {
    
    _dob = value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dobLabel.text = _dob;
}

- (IBAction)validationNoBtnAction:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserSignInViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"signinVC"];
    [self.navigationController pushViewController:vc animated:YES];
   // [self helpBtnAction:nil];
}

- (IBAction)validationYesBtnAction:(id)sender {

        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SignupOrResetPasswordViewcontroller *vc =[storyboard instantiateViewControllerWithIdentifier:@"signupVC"];
        [self.navigationController pushViewController:vc animated:YES];
    
    
    

}

- (IBAction)helpBtnAction:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CallUsViewcontroller *vc =[storyboard instantiateViewControllerWithIdentifier:@"CallUsVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
