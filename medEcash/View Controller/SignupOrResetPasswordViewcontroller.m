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
    UIColor * color = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0];
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    data = [User sharedManager];
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = color.CGColor;
    border.frame = CGRectMake(0, self.userNameTextField.frame.size.height - borderWidth, self.userNameTextField.frame.size.width, self.userNameTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [self.userNameTextField.layer addSublayer:border];
    self.userNameTextField.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 2;
    border1.borderColor = color.CGColor;
    border1.frame = CGRectMake(0, self.passwordTextField.frame.size.height - borderWidth1, self.passwordTextField.frame.size.width, self.userNameTextField.frame.size.height);
    border1.borderWidth = borderWidth1;
    [self.passwordTextField.layer addSublayer:border1];
    self.passwordTextField.layer.masksToBounds = YES;

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
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PaymentsViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"paymentsVC"];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
    
    /// 86db5a88975755f76bd733533fa229fe661abf6d
    if ([self.userNameTextField.text length]!=0 || [self.passwordTextField.text length]!=0) {
[MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://assertahealth-debhersom.c9.io/API/UAT/authentication"]];
    
    NSDictionary *parametersDictionary = @{
                                           @"client_id": @"asdf1234",
                                        @"device_uid":data.devicId,
                                           @"enrollment_code":data.token,
                                           @"usn":self.userNameTextField.text,
                                           @"pwd":self.passwordTextField.text
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
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"Username or Password can not be empty." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
    
}




}
- (IBAction)helpBtnAction:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CallUsViewcontroller *vc =[storyboard instantiateViewControllerWithIdentifier:@"CallUsVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [NSMutableData data];
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
    if ([responseStr isEqualToString:@"\"Please specify another USN\""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:responseStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    else if (responseDict) {

        
        
    }
    
    
    
}

@end
