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
    User * data;
    data =[User sharedManager];
    self.view.backgroundColor = data.bgClr;
    
    
    
    // set Logo BG
    
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"] == nil ||[[[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"] isEqualToString:@"logo"] ) {
        
        //data.logoUrlstr = [[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"];
        
       // self.logo.image = [UIImage imageNamed:@"logo"];
        
    }
    else
    {
        
        
        NSString *ImageURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        self.logo.image = [UIImage imageWithData:imageData];
        
        
    }

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
