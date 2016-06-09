//
//  PhotoViewController.m
//  SidebarDemo
//
//  Created by Simon on 30/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "PhotoViewController.h"
#import "SWRevealViewController.h"

@interface PhotoViewController ()

@end


@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =@"Reset Password";
    self.navigationController.navigationBar.hidden =YES;
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.verificationCodeTextField.delegate=self;
    responseDict = [[NSMutableDictionary alloc]init];
    data = [User sharedManager];
    self.view.backgroundColor = data.bgClr;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"Invalid code , please try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        self.verificationCodeTextField.text = @"";
        [alert show];
        
    }
    if (error == nil || (code == 200 && responseDict == nil)) {
        
        
        if (responseDict == nil) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"Invalid code , please try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            self.verificationCodeTextField.text = @"";
            [alert show];
            
        }
        else {
            
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
            // set token use
            data.token=[responseDict valueForKey:@"enrollment_token"];
            data.authToken =[responseDict valueForKey:@"token"];
            data.birthDate = [responseDict valueForKey:@"date_of_birth"];
            
            
            
            if (data.birthDate != nil) {
//                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                ValidateUserViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"ValidateUserVC"];
//                vc.dob = [responseDict valueForKey:@"date_of_birth"];
//                [self.navigationController pushViewController:vc animated:YES];
                //            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                //            ResetPasswordViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"resetPasswordVC"];
                //            [self.navigationController pushViewController:vc animated:YES];
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"Invalid code , please try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                self.verificationCodeTextField.text = @"";
                [alert show];
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
