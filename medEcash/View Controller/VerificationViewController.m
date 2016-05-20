//
//  VerificationViewController.m
//  medEcash
//
//  Created by Apple on 12/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "VerificationViewController.h"

@implementation VerificationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//   //self.
//    
//    
//    CALayer *border = [CALayer layer];
//    CGFloat borderWidth = 2;
//    border.borderColor = [UIColor lightGrayColor].CGColor;
//    border.frame = CGRectMake(0, self.verificationCodeTextField.frame.size.height - borderWidth, self.verificationCodeTextField.frame.size.width, self.verificationCodeTextField.frame.size.height);
//    border.borderWidth = borderWidth;
//    [self.verificationCodeTextField.layer addSublayer:border];
//    self.verificationCodeTextField.layer.masksToBounds = YES;
//    
    self.verificationCodeTextField.delegate=self;
}
- (IBAction)verificationBtnAction:(id)sender {
//    if ([self.verificationCodeTextField.text isEqual: @"1234"]) {
//        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ValidateUserViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"ValidateUserVC"];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    
//    else {
//        
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"Incorrect , try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//        [alert show];
//        
//    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    /// 86db5a88975755f76bd733533fa229fe661abf6d
    NSDictionary *parametersDictionary = @{
                                           @"clinet_id": @"asdf1234",
                                           @"device_ui":@"86db5a88975755f76bd733533fa229fe661abf6d",
                                           @"Enrollment_code":@"000000"
                                           };
   // NSString *jsonStr = @"[{ \"clinet_id\":\"asdf1234\" },{ \"device_ui\":\"86db5a88975755f76bd733533fa229fe661abf6d\" },{ \"Enrollment_code\":\"000000\"}]";
   
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
   // [manager.requestSerializer setValue:@"Fiddler" forHTTPHeaderField:@"user-agent"];
    //[manager.requestSerializer setValue:@"assertahealth-debhersom.c9.io" forHTTPHeaderField:@"host"];
   // [manager.requestSerializer setValue:@"76" forHTTPHeaderField:@"content-length"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-Type"];
    [manager POST:@"https://assertahealth-debhersom.c9.io/API/UAT/enrollment" parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"success!");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error.localizedDescription);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];


}

- (IBAction)iHaveAccountBtnAction:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserSignInViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"signinVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)helpBtnAction:(id)sender {
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
@end
