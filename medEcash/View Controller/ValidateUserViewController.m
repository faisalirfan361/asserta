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
    UserSignInViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"signinVC"];
    [self.navigationController pushViewController:vc animated:YES];
   // [self helpBtnAction:nil];
}

- (IBAction)validationYesBtnAction:(id)sender {
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    UIViewController* sidebarViewController = [storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
//   
//     PaymentsViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"paymentsVC"];
//    DHSidebarViewController* sidebarVC = [[DHSidebarViewController alloc] initWithRootViewController:vc
//                                                                               sidebarViewController:sidebarViewController];
//    [self.navigationController setViewControllers:[NSArray arrayWithObject:sidebarVC] animated:YES];
//    [sidebarVC toggleSidebar];
//    [sidebarVC showRootViewController];
    
  
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
