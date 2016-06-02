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
        border.frame = CGRectMake(0, self.userNameTxtField.frame.size.height - borderWidth, self.view.frame.size.width, self.userNameTxtField.frame.size.height);
        border.borderWidth = borderWidth;
        [self.userNameTxtField.layer addSublayer:border];
        self.userNameTxtField.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 2;
    border1.borderColor = color.CGColor;
    border1.frame = CGRectMake(0, self.passwordTxtField.frame.size.height - borderWidth1, self.view.frame.size.width, self.userNameTxtField.frame.size.height);
    border1.borderWidth = borderWidth1;
    [self.passwordTxtField.layer addSublayer:border1];
    self.passwordTxtField.layer.masksToBounds = YES;
      data = [User sharedManager];
      self.view.backgroundColor = data.bgClr;
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
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PaymentsViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"paymentsVC"];
//    [self.navigationController pushViewController:vc animated:YES];
    if ([self.userNameTxtField.text length]!=0 || [self.passwordTxtField.text length]!=0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"https://assertahealth-debhersom.c9.io/API/V1/authentication"]];
        
        NSDictionary *parametersDictionary = @{
                                               @"client_id": data.client_id,
                                               @"device_uid":data.devicId,
                                               @"usn":self.userNameTxtField.text,
                                               @"pwd":self.passwordTxtField.text
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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
        data.authToken = [responseDict valueForKey:@"token"];
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SWRevealViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"revealVC"];
            [self.navigationController pushViewController:vc animated:YES];

        
        
    }
    
    
    
}










@end
