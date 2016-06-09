//
//  ResetPasswordViewController.m
//  medEcash
//
//  Created by Apple on 05/06/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ResetPasswordViewController.h"

@implementation ResetPasswordViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =@"Reset Password";
    // Change button color
    
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    
    
    // Set the gesture
   
    
    passwordShown=NO;
    UIColor * color = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0];
    self.passwordTxt.delegate = self;
    self.retypePasswordTextField.delegate = self;
    data = [User sharedManager];
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = color.CGColor;
    border.frame = CGRectMake(0, self.passwordTxt.frame.size.height - borderWidth, self.passwordTxt.frame.size.width, self.passwordTxt.frame.size.height);
    border.borderWidth = borderWidth;
    [self.passwordTxt.layer addSublayer:border];
    self.passwordTxt.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 2;
    border1.borderColor = color.CGColor;
    border1.frame = CGRectMake(0, self.retypePasswordTextField.frame.size.height - borderWidth1, self.retypePasswordTextField.frame.size.width, self.retypePasswordTextField.frame.size.height);
    border1.borderWidth = borderWidth1;
    [self.retypePasswordTextField.layer addSublayer:border1];
    self.retypePasswordTextField.layer.masksToBounds = YES;
    
    // set Logo BG
    
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"] == nil ||[[[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"] isEqualToString:@"logo"] ) {
        
        //data.logoUrlstr = [[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"];
        
        self.logo.image = [UIImage imageNamed:@"logo"];
        
    }
    else
    {
        
        
        NSString *ImageURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        self.logo.image = [UIImage imageWithData:imageData];
        
        
    }
    self.view.backgroundColor =data.bgClr;
}

- (IBAction)showPasswordBtnAction:(id)sender {
    
    if (passwordShown == YES) {
        passwordShown = NO;
        self.passwordTxt.secureTextEntry = YES;
        self.retypePasswordTextField.secureTextEntry = YES;
        
        [self.showPasswordBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        
    } else {
        
        passwordShown =YES;
      self.passwordTxt.secureTextEntry = NO;
        
        self.retypePasswordTextField.secureTextEntry = NO;
        [self.showPasswordBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
- (IBAction)resetPasswordBtnAction:(id)sender; {
    
    
    
        /// 86db5a88975755f76bd733533fa229fe661abf6d
        if (([self.passwordTxt.text length]!=0 || [self.retypePasswordTextField.text length]!=0) && (self.passwordTxt.text == self.retypePasswordTextField.text)) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
            NSMutableURLRequest *request = [NSMutableURLRequest
                                            requestWithURL:[NSURL URLWithString:@"https://assertahealth-debhersom.c9.io/API/V1/authentication"]];
    
            NSDictionary *parametersDictionary = @{
                                                   @"device_uid":data.devicId,
                                                   @"token":data.authToken,
                                                   @"client_id":data.client_id,
                                                   @"pwd":self.passwordTxt.text,
                                                   };
            NSError *error;
            NSData *postData = [NSJSONSerialization dataWithJSONObject:parametersDictionary options:0 error:&error];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPMethod:@"PUT"];
            [request setHTTPBody:postData];
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [connection start];
    
    
        }
    
        else {
    
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"Invalid password.Try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
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
    if (code == 200) {
       
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UserSignInViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"signinVC"];
                [data setMainRootController:vc];
    }
    else {
        

        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:error.localizedDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];

        
    }
    
    
    
}


@end
