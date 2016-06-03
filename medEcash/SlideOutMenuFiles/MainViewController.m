//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController.navigationBar setBarTintColor:data.bgClr];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.title = @"medEcash";
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainLogo"]];
    self.navigationItem.titleView = imageView;
    isToPay = NO;
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    selectedCellsArray = [[NSMutableArray alloc]init];
    expandCellsArray = [[NSMutableArray alloc]init];
    payIdsArray = [[NSMutableArray alloc]init];
    isSelectedAll = NO;
    // setting all unchecks initially
    for(int i=0; i<5; i++)
    {
        [selectedCellsArray addObject:@"Uncheck"];
    }
    for(int i=0; i<5; i++)
    {
        [expandCellsArray addObject:@"Collapse"];
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.payBtn.hidden = YES;

    data = [User sharedManager];
    [self callProcecduresData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[responseDict valueForKey:@"cases"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([[responseDict valueForKey:@"cases"]valueForKey:@"procedures"] != nil) {
        NSDictionary *dick = [[responseDict valueForKey:@"cases"]valueForKey:@"procedures"];
        if ([dick count] > 0) {
            return  [[[[responseDict valueForKey:@"cases"]valueForKey:@"procedures"]objectAtIndex:section]count];
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    data1 = [[responseDict valueForKey:@"cases"]objectAtIndex:indexPath.section];
    data1 = [data1 valueForKey:@"procedures"];
    data1 = [data1 objectAtIndex:indexPath.row];
    //[[[valueForKey:@"paid"]objectAtIndex:indexPath.row]valueForKey:@"procedures"];
    static NSString *CellIdentifier = @"Cell";
    
        //if ([payemtStr  isEqual:@"0"]) {
        //UnpiadCell
    
    
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    

    UIButton * checkBtn= (UIButton *)[cell viewWithTag:101];
    UILabel *payToLbl = (UILabel *)[cell viewWithTag:100];
    UIButton * expandBtn= (UIButton *)[cell viewWithTag:106];

    if ([[data1 valueForKey:@"paid"]boolValue] ==1) {
        payToLbl.text = @"";
        [checkBtn setHidden:YES];
        [expandBtn setHidden:YES];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    else {
    payToLbl.text = @"Pay to";
        [checkBtn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [expandBtn addTarget:self action:@selector(collapseExpandButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        if([[selectedCellsArray objectAtIndex:indexPath.row] isEqualToString:@"Uncheck"])
            [checkBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        else
            [checkBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        
        if([[expandCellsArray objectAtIndex:indexPath.row] isEqualToString:@"Expand"])
            [expandBtn setImage:[UIImage imageNamed:@"collapse.png"] forState:UIControlStateNormal];
        else
            [expandBtn setImage:[UIImage imageNamed:@"expand.png"] forState:UIControlStateNormal];
        
        if ([selectedCellsArray containsObject:@"Check"]) {
            self.payBtn.hidden = NO;
        }
        else {
            self.payBtn.hidden = YES;
        }

    }
    
        
    UILabel *mainTitleLbk = (UILabel *)[cell viewWithTag:102];
    mainTitleLbk.textColor= [UIColor blackColor];
    mainTitleLbk.text = [data1 valueForKey:@"provider"];
    ((UILabel *)[cell viewWithTag:103]).text = [data1 valueForKey:@"description"];
    ((UILabel *)[cell viewWithTag:104]).text = [NSString stringWithFormat:@"%@ %@ %@ %@, %@",
                                                [data1 valueForKey:@"line_1"],
                                                [data1 valueForKey:@"line_2"],
                                                [data1 valueForKey:@"city"],
                                                [data1 valueForKey:@"state"],
                                                [data1 valueForKey:@"zip"]];
    ((UILabel *)[cell viewWithTag:105]).text = [data1 valueForKey:@"phone"];
    // handeling check uncheck buttons
    return cell;
    

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    data1 = [[responseDict valueForKey:@"cases"]objectAtIndex:section];
    data1 = [data1 valueForKey:@"summary"];
    static NSString *CellIdentifier = @"HeaderCell";
    //UnpiadCell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ((UILabel *)[cell viewWithTag:110]).text = [data1 valueForKey:@"case_name"];
    ((UILabel *)[cell viewWithTag:111]).text = [data1 valueForKey:@"total_cost"];
    ((UILabel *)[cell viewWithTag:112]).text = [data1 valueForKey:@"your_cost"];
    UIButton * selectAllButton = (UIButton *)[cell viewWithTag:105];
    [selectAllButton addTarget:self action:@selector(selectAll:) forControlEvents:UIControlEventTouchUpInside];
    return cell.contentView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 110.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if([[expandCellsArray objectAtIndex:indexPath.row] isEqualToString:@"Expand"])
    {
        
        return 100;
    }
    else
    {
        return 58;
        
    }
    
    return 70;
}
-(void)checkBtnClicked:(id)sender
{
    // Getting the indexPath of cell of clicked button
    
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    
    // No need to use tag sender will keep the reference of clicked button
    UIButton *button = (UIButton *)sender;
    
    //Checking the condition button is checked or unchecked.
    //accordingly replace the array object and change the button image
    data1 = [[responseDict valueForKey:@"cases"]objectAtIndex:indexPath.section];
    data1 = [data1 valueForKey:@"procedures"];
    data1 = [data1 objectAtIndex:indexPath.row];
    
    if([[selectedCellsArray objectAtIndex:indexPath.row] isEqualToString:@"Uncheck"])
    {
        [button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [selectedCellsArray replaceObjectAtIndex:indexPath.row withObject:@"Check"];
        [payIdsArray addObject:[data1 valueForKey:@"id"]];
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [selectedCellsArray replaceObjectAtIndex:indexPath.row withObject:@"Uncheck"];
        [payIdsArray removeObject:[data1 valueForKey:@"id"]];
    }
    [self.tableView reloadData];
}
- (void) collapseExpandButtonTap:(id) sender
{
    UIButton *button = (UIButton *)sender;
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint]; //Let's assume that you have only one section and button tags directly correspond to rows of your cells.
    //expandedCells is a mutable set declared in your interface section or private class extensiont
    if([[expandCellsArray objectAtIndex:indexPath.row] isEqualToString:@"Expand"])
    {
        
        [expandCellsArray replaceObjectAtIndex:indexPath.row withObject:@"Collapse"];
        // [button backgroun:[UIImage imageNamed:@"expand"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"expand.png"] forState:UIControlStateNormal];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
    else
    {
        
        [expandCellsArray replaceObjectAtIndex:indexPath.row withObject:@"Expand"];
        [button setImage:[UIImage imageNamed:@"collapse.png"] forState:UIControlStateNormal];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}
- (IBAction)menuBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectAll:(id)sender {
    UIButton *button = (UIButton *)sender;
    //button.hidden = YES;
    if (isSelectedAll) {
        isSelectedAll = NO;
        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        for(int i=0; i<selectedCellsArray.count; i++)
        {
            
            if([[selectedCellsArray objectAtIndex:i] isEqualToString:@"Check"])
            {
                
                [selectedCellsArray replaceObjectAtIndex:i withObject:@"Uncheck"];
            }
            
            
        }
      [self.tableView reloadData];
       //[self.tableView beginUpdates];
       //[self.tableView endUpdates];
       // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation: UITableViewRowAnimationAutomatic];
        //
    }
    
    else {
        isSelectedAll =YES;
        [button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        for(int i=0; i<selectedCellsArray.count; i++)
        {
            
            if([[selectedCellsArray objectAtIndex:i] isEqualToString:@"Uncheck"])
            {
                
                [selectedCellsArray replaceObjectAtIndex:i withObject:@"Check"];
            }
            
            
        }
        
    }
    [self.tableView reloadData];
   // [self.tableView beginUpdates];
    //[self.tableView endUpdates];
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation: UITableViewRowAnimationAutomatic];
    //
    
}

- (IBAction)payBtnAction:(id)sender {
    // Generate content view to present
    UIAlertView * Alert = [[UIAlertView alloc]initWithTitle:@"Cumming GA Physical Therapy Clinic" message:@"Are you sure you want to pay?" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Pay", nil];
    
    [Alert show];
    
}


-(void)callProcecduresData {
    isToPay = NO;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://assertahealth-debhersom.c9.io/API/V1/resources"]];
    
    NSDictionary *parametersDictionary = @{
                                           @"client_id": data.client_id,
                                           @"device_uid":data.devicId,
                                           @"token":data.authToken,
                                           @"resource_type":@"all"
                                           };
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parametersDictionary options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

    
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
    if (isToPay) {
        payResponseDict = [[NSMutableDictionary alloc]init];
        payResponseDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         // call procedure API again
        [self callProcecduresData];
        
    }
    else {
    responseDict = [[NSMutableDictionary alloc]init];
    responseDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
        
        
        
        // Saving Color Schemes and logo to NAUser Defualts
        
        // [[responseDict objectForKey:@"style"]objectForKey:@"logo"]
        //[[responseDict objectForKey:@"style"]objectForKey:@"logo"]
        //[[responseDict objectForKey:@"style"]objectForKey:@"logo"]
        //  logo = "";
        //"plan_color_1" = "";
       // "plan_color_2" = "";
        NSString * logoUrl;
        NSString * planColor1;
        NSString *planColor2 ;
        if ([[responseDict objectForKey:@"style"]objectForKey:@"logo"] == [NSNull null] || [[[responseDict objectForKey:@"style"]objectForKey:@"logo"] isEqualToString:@""]) {
            
            logoUrl =@"logo";
            
        }
        else {
        logoUrl = [[responseDict objectForKey:@"style"]objectForKey:@"logo"];
        }
        
        if ([[responseDict objectForKey:@"style"]objectForKey:@"plan_color_1"] == [NSNull null] || [[[responseDict objectForKey:@"style"]objectForKey:@"plan_color_1"] isEqualToString:@""]) {
        planColor1 = @"6b322a";
        
        
        }
        else {
        
        planColor1 = [[responseDict objectForKey:@"style"]objectForKey:@"plan_color_1"];
        }
        
        if ([[responseDict objectForKey:@"style"]objectForKey:@"plan_color_2"] == [NSNull null] || [[[responseDict objectForKey:@"style"]objectForKey:@"plan_color_2"] isEqualToString:@""]) {
          planColor2 = @"84271a";
            
        }
        
        else {
        
        planColor2 = [[responseDict objectForKey:@"style"]objectForKey:@"plan_color_2"];
        }
        
        
        
        // save Logo url
        
        
        [[NSUserDefaults standardUserDefaults] setObject:logoUrl forKey:@"appLogo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        // save color scheme 1
        
        
        [[NSUserDefaults standardUserDefaults] setObject:planColor1 forKey:@"colorScheme1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        // save color scheme 1
        
        
        [[NSUserDefaults standardUserDefaults] setObject:planColor2 forKey:@"colorScheme2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        data = [User sharedManager];
        [data setStausBarClr:[data colorWithHexString:planColor1]];
        [data setBgClr:[data colorWithHexString:planColor2]];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     if (responseDict) {
         
         dataArray = [[responseDict valueForKey:@"cases"]valueForKey:@"procedures"];
         [self.tableView reloadData];
     }}
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex ==0) {
        //
    }
    else if (buttonIndex == 1) {
     // Call Pay Api here
    }
}
- (void) callPayAction {
    isToPay = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://assertahealth-debhersom.c9.io/API/UAT/actions"]];
    
    NSDictionary *parametersDictionary = @{
                                           @"client_id": @"asdf1234",
                                           @"device_uid":data.devicId,
                                           @"token":data.authToken,
                                           @"action_code":@"pay" ,
                                           @"data" :@"AddDataArrayValues"
                                           };
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parametersDictionary options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

    
    
}
@end
