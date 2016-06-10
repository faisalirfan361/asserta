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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    CALayer *border = [CALayer layer];
//    CGFloat borderWidth = 2;
//    border.borderColor = [UIColor lightGrayColor].CGColor;
//    border.frame = CGRectMake(0, self.verificationCodeTextField.frame.size.height - borderWidth, self.verificationCodeTextField.frame.size.width, self.verificationCodeTextField.frame.size.height);
//    border.borderWidth = borderWidth;
//    [self.verificationCodeTextField.layer addSublayer:border];
//    self.verificationCodeTextField.layer.masksToBounds = YES;
//    
    self.verificationCodeTextField.delegate=self;
    responseDict = [[NSMutableDictionary alloc]init];
    data = [User sharedManager];
    self.view.backgroundColor = data.bgClr;
    
    
    
    
    // set Logo BG
    
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"] == nil ||[[[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"] isEqualToString:@"logo"] ) {
        
        //data.logoUrlstr = [[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"];
        
        //self.logo.image = [UIImage imageNamed:@"logo"];
        
    }
    else
    {
        
        
        NSString *ImageURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
       self.logo.image = [UIImage imageWithData:imageData];
        
        
    }
    
}
- (IBAction)verificationBtnAction:(id)sender {
    
    
    if ([self.verificationCodeTextField.text length]>0) {
    
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        /// 86db5a88975755f76bd733533fa229fe661abf6d
        
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"https://assertahealth-debhersom.c9.io/API/V1/enrollment"]];
        
        NSDictionary *parametersDictionary = @{
                                                 @"client_id":data.client_id,
                                                 @"device_uid":data.devicId,
                                                 @"enrollment_code":self.verificationCodeTextField.text
                                               };
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:parametersDictionary options:0 error:&error];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
    
    
    }
    
    else {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"Incorrect verification code, try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
 }

    
}

- (IBAction)iHaveAccountBtnAction:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserSignInViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"signinVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)helpBtnAction:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CallUsViewcontroller *vc =[storyboard instantiateViewControllerWithIdentifier:@"CallUsVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [NSMutableData data];
    code = 0;
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    code = (int)[httpResponse statusCode];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"%@",error.localizedDescription);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError * error;
    NSString * responseStr = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"response data - %@", responseStr);
    responseDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if (responseDict ==nil) {
        
        
    }
    
    if (code !=200) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:responseStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        self.verificationCodeTextField.text = @"";
        [alert show];

    }
    if (error == nil || (code == 200 && responseDict == nil)) {
        
        
        if (responseDict == nil) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];

            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UserSignInViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"signinVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            
            
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
            // set token use
        data.token=[responseDict valueForKey:@"enrollment_token"];
        data.authToken =[responseDict valueForKey:@"token"];
        data.birthDate = [responseDict valueForKey:@"date_of_birth"];
            
            
            
        if (data.birthDate != nil) {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ValidateUserViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"ValidateUserVC"];
            vc.dob = [responseDict valueForKey:@"date_of_birth"];
            [self.navigationController pushViewController:vc animated:YES];
//            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            ResetPasswordViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"resetPasswordVC"];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            
            
        else if (data.birthDate == nil) {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
            ResetPasswordViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"resetPasswordVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            
            
        }
   
    }


}
    


@end
