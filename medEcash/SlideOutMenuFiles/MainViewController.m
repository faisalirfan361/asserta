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
    self.noProcedureView.hidden = YES;
    
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
    
    payIdsArray = [[NSMutableArray alloc]init];
    isSelectedAll = NO;
    
    // setting all unchecks initially
//    for(int i=0; i<5; i++)
//    {
//        [selectedCellsArray addObject:@"Uncheck"];
//    }
//    for(int i=0; i<5; i++)
//    {
//        [expandCellsArray addObject:@"Collapse"];
//    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.payBtn.hidden = YES;

    data = [User sharedManager];
    [self callProcecduresData];
    
    popup =[[UIView alloc]initWithFrame:CGRectMake(15, self.view.frame.size.height/2, self.view.frame.size.width-30, 140)];
    popup.backgroundColor =[UIColor whiteColor];
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, popup.frame.size.width-20, 30)];
    text.text =@"You do not have any procedures available.";
    text.textColor = [UIColor blackColor];
    [popup addSubview:text];
    sections =[[NSMutableArray alloc]init];
    
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
    [checkBtn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [expandBtn addTarget:self action:@selector(collapseExpandButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    //
    if([[[selectedCellsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row ] isEqualToString:@"Uncheck"])
        [checkBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    else
        [checkBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    // [[expandCellsArray objectAtIndex:indexPath.row] isEqualToString:@"Expand"]
    if([[[expandCellsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row ] isEqualToString:@"Expand"])
        [expandBtn setImage:[UIImage imageNamed:@"collapse.png"] forState:UIControlStateNormal];
    else
        [expandBtn setImage:[UIImage imageNamed:@"expand.png"] forState:UIControlStateNormal];
    if ([[data1 valueForKey:@"paid"]boolValue] == 1) {
        payToLbl.text = @"";
        [checkBtn setHidden:YES];
        [expandBtn setHidden:YES];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    else {
    payToLbl.text = @"Pay to";
       
        [checkBtn setHidden:NO];
        [expandBtn setHidden:NO];
        cell.contentView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1.0];
    }
    
        
    UILabel *mainTitleLbk = (UILabel *)[cell viewWithTag:102];
    mainTitleLbk.textColor= [UIColor blackColor];
    mainTitleLbk.text = [data1 valueForKey:@"provider"];
    ((UILabel *)[cell viewWithTag:103]).text = [data1 valueForKey:@"description"];
    ((UILabel *)[cell viewWithTag:104]).text = [NSString stringWithFormat:@"%@ %@ ",
                                                [data1 valueForKey:@"line_1"],
                                                [data1 valueForKey:@"line_2"]
                                                ];
    ((UILabel *)[cell viewWithTag:109]).text = [NSString stringWithFormat:@"%@, %@", [data1 valueForKey:@"city"],[data1 valueForKey:@"state"]];
    
    // [data1 valueForKey:@"zip"]
    ((UILabel *)[cell viewWithTag:105]).text = [NSString stringWithFormat:@"%@ ,%@" ,[data1 valueForKey:@"zip"],[data1 valueForKey:@"phone"]];
    // handeling check uncheck buttons
    
    
    //
    
    
    
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
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 110)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 12, 178, 48)];
    titleLabel.font = [UIFont fontWithName:@"DejaVuSans" size:17];
    
    UILabel * totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.size.width-70, 9, 63, 21)];
    totalPrice.font = [UIFont fontWithName:@"DejaVuSans" size:12];
    totalPrice.text = [NSString stringWithFormat:@"$%@",[data1 valueForKey:@"total_cost"]];
    titleLabel.text = [data1 valueForKey:@"case_name"];
    UILabel * totalPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.size.width-130, 9, 53, 21)];
    totalPriceLbl.font = [UIFont fontWithName:@"DejaVuSans" size:10];
    totalPriceLbl.text = @"total cost";
    
    
    UILabel * yourPrice = [[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.size.width-70, 40, 61, 21)];
    yourPrice.font = [UIFont fontWithName:@"DejaVuSans" size:12];
    yourPrice.text = [NSString stringWithFormat:@"$%@",[data1 valueForKey:@"your_cost"]];
    
    UILabel * yourPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.size.width-130, 40, 51, 21)];
    yourPriceLbl.font = [UIFont fontWithName:@"DejaVuSans" size:10];
    yourPriceLbl.text = @"your cost";
    
   

    
    UIView * selectallView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, tableView.frame.size.width, 47)];
    
    selectallView.backgroundColor =[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
    
    
    UIButton * selectallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectallBtn.tag =section;
    selectallBtn.frame =CGRectMake(4, 7, 30, 30);
    [selectallBtn setBackgroundColor:[UIColor clearColor]];
    if (![sections containsObject:@(section).stringValue]) {
        [selectallBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [selectallBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateHighlighted];
    }
    else {
        [selectallBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [selectallBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateHighlighted];
    }
    [selectallBtn addTarget:self action:@selector(selectAll:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * selectallLbl = [[UILabel alloc]initWithFrame:CGRectMake(46, 15, 72, 16)];
    selectallLbl.font = [UIFont fontWithName:@"DejaVuSans" size:12];
    selectallLbl.textColor =[UIColor colorWithRed:140.0/255.0 green:48.0/255.0 blue:42.0/255.0 alpha:1.0];
    selectallLbl.text = @"Select All";
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 42, selectallView.frame.size.width, 3)];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    
    [selectallView addSubview:bottomView];
    [selectallView addSubview:selectallBtn];
    [selectallView addSubview:selectallLbl];
    [headerView addSubview:selectallView];
    [headerView addSubview:titleLabel];
    [headerView addSubview:totalPriceLbl];
    [headerView addSubview:totalPrice];
    [headerView addSubview:yourPriceLbl];
    [headerView addSubview:yourPrice];
    
    
    
//    ((UILabel *)[cell viewWithTag:110]).text = [data1 valueForKey:@"case_name"];
//    ((UILabel *)[cell viewWithTag:111]).text = [NSString stringWithFormat:@"$%@",[data1 valueForKey:@"total_cost"]];
//    ((UILabel *)[cell viewWithTag:112]).text = [NSString stringWithFormat:@"$%@",[data1 valueForKey:@"your_cost"]];
//    UIButton * selectAllButton = (UIButton *)[cell viewWithTag:105];
//    [selectAllButton addTarget:self action:@selector(selectAll:) forControlEvents:UIControlEventTouchUpInside];
//    selectAllButton.tag = section;
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 110.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[expandCellsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row ] isEqualToString:@"Expand"])
    {
        
        return 120;
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
    
    int row = (int)indexPath.row;
    int section = (int) indexPath.section;
    
    NSLog(@"Row = %d : %d",row,section);
    //Checking the condition button is checked or unchecked.
    //accordingly replace the array object and change the button image
    data1 = [[responseDict valueForKey:@"cases"]objectAtIndex:indexPath.section];
    data1 = [data1 valueForKey:@"procedures"];
    data1 = [data1 objectAtIndex:indexPath.row];
    
    if([[[selectedCellsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row ] isEqualToString:@"Uncheck"])
    {
        [button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [[selectedCellsArray objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@"Check"];
        // [selectedCellsArray replaceObjectAtIndex:@[indexPath.section][indexPath.row] ] withObject:@"Check"];
        [payIdsArray addObject:[data1 valueForKey:@"id"]];
        [self showHidePayBtn];
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [[selectedCellsArray objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@"Uncheck"];
        [payIdsArray removeObject:[data1 valueForKey:@"id"]];
        [self showHidePayBtn];
    }
    [self.tableView reloadData];
}
- (void) collapseExpandButtonTap:(id) sender
{
    UIButton *button = (UIButton *)sender;
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    int row = (int)indexPath.row;
    int section = (int) indexPath.section;
    
    NSLog(@"Row = %d : %d",row,section);
    //Let's assume that you have only one section and button tags directly correspond to rows of your cells.
    //expandedCells is a mutable set declared in your interface section or private class extensiont
    if([[[expandCellsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row ] isEqualToString:@"Expand"])
    {
        
        [[expandCellsArray objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@"Collapse"];
        // [button backgroun:[UIImage imageNamed:@"expand"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"expand.png"] forState:UIControlStateNormal];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
    else
    {
        
        [[expandCellsArray objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:@"Expand"];
        [button setImage:[UIImage imageNamed:@"collapse.png"] forState:UIControlStateNormal];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}
- (IBAction)menuBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectAll:(UIButton *)sender {
   // NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    UIButton *button = (UIButton *)sender;
    //button.hidden = YES;
    
   // NSInteger * tag =(NSInteger)[sender tag];
   
    
    data1 = [[responseDict valueForKey:@"cases"]objectAtIndex:sender.tag];
    data1 = [data1 valueForKey:@"procedures"];
   // data1 = [data1 objectAtIndex:0];
    
    
    
    
    
    
    if (isSelectedAll) {
        isSelectedAll = NO;
        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        
        for (int i=0; i<data1.count; i++) {
            //
            
            if ([[data1 valueForKey:@"city"]objectAtIndex:i] != [NSNull null]) {
                NSString * currentId = [[data1 valueForKey:@"id"]objectAtIndex:i];
                if ([payIdsArray containsObject:currentId]) {
                    [payIdsArray removeObject:currentId];
                }
                
              //  NSLog(@"%@",[[data1 valueForKey:@"id"]objectAtIndex:i]);
            }
            
            
            
        }

        if ([sections containsObject:@(sender.tag).stringValue]) {
            [sections removeObject:@(sender.tag).stringValue];
        }
        
        NSMutableArray * uncheck = [[NSMutableArray alloc]initWithArray:[selectedCellsArray objectAtIndex:sender.tag]];
        for(int i=0; i<[uncheck count]; i++)
        {
            
            if([[uncheck objectAtIndex:i] isEqualToString:@"Check"])
            {
                
                [uncheck replaceObjectAtIndex:i withObject:@"Uncheck"];
            }
            
       }
        
        [selectedCellsArray removeObjectAtIndex:sender.tag];
        [selectedCellsArray insertObject:uncheck atIndex:sender.tag];
        
      [self.tableView reloadData];
       //[self.tableView beginUpdates];
       //[self.tableView endUpdates];
      // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation: UITableViewRowAnimationAutomatic];
        //
    }
    
    else {
        isSelectedAll =YES;
        [button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
//        for(int i=0; i<selectedCellsArray.count; i++)
//        {
//            
//            if([[selectedCellsArray objectAtIndex:i] isEqualToString:@"Uncheck"])
//            {
//                
//                [selectedCellsArray replaceObjectAtIndex:i withObject:@"Check"];
//            }
//            
//            
//        }

        if (![sections containsObject:@(sender.tag).stringValue]) {
            [sections addObject:@(sender.tag).stringValue];
        }

        for (int i=0; i<data1.count; i++) {
            //
            
            if ([[data1 valueForKey:@"city"]objectAtIndex:i] != [NSNull null]) {
                NSString * currentId = [[data1 valueForKey:@"id"]objectAtIndex:i];
                if (![payIdsArray containsObject:currentId]) {
                    [payIdsArray addObject:currentId];
                }
                
                NSLog(@"%@",[[data1 valueForKey:@"id"]objectAtIndex:i]);
            }
            
            
            
        }

        NSMutableArray * check = [[NSMutableArray alloc]initWithArray:[selectedCellsArray objectAtIndex:sender.tag]];
        for(int i=0; i<[check count]; i++)
        {
            
            if([[check objectAtIndex:i] isEqualToString:@"Uncheck"])
            {
                
                [check replaceObjectAtIndex:i withObject:@"Check"];
            }
            
        }
        
        [selectedCellsArray removeObjectAtIndex:sender.tag];
        [selectedCellsArray insertObject:check atIndex:sender.tag];
        [self.tableView reloadData];
        
        
        
        
        
    }
    
   // [self.tableView beginUpdates];
   // [self.tableView endUpdates];
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
   // [self.tableView beginUpdates];
    //[self.tableView endUpdates];
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation: UITableViewRowAnimationAutomatic];
    //
    [self showHidePayBtn];
}

- (IBAction)payBtnAction:(id)sender {
    // Generate content view to present
    UIAlertView * Alert = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure you want to pay?" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Pay", nil];
    
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
    if (isToPay ) {
        if (code == 200) {
            payResponseDict = [[NSMutableDictionary alloc]init];
            payResponseDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            [payIdsArray removeAllObjects];
            
//            for (int i = 0 ; i<selectedCellsArray.count; i++) {
//                
//                if([[selectedCellsArray objectAtIndex:i] isEqualToString:@"Check"])
//                {
//                    
//                    [selectedCellsArray replaceObjectAtIndex:i withObject:@"Uncheck"];
//                    
//                }
//                
//            }
            [self.tableView reloadData];
            self.payBtn.hidden = YES;
            
            // call procedure API again
            [self callProcecduresData];

        }
        else
        {
        
        
        
        }
        
    }
    else {
        
        
    responseDict = [[NSMutableDictionary alloc]init];
    responseDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
        selectedCellsArray = [[NSMutableArray alloc]init];
        expandCellsArray = [[NSMutableArray alloc]init];
        //expandCellsArray = [[NSMutableArray alloc]init];
        for (int i=0; i<[[responseDict objectForKey:@"cases"]count]; i++) {
            NSMutableArray *subArray = [[NSMutableArray alloc] init];
            for (int j=0; j<[[[[responseDict objectForKey:@"cases"]objectAtIndex:i]objectForKey:@"procedures"]count]; j++) {
                
                [subArray addObject:@"Uncheck"];
                
            }
            
            [selectedCellsArray addObject:subArray];
        }
        
        for (int i=0; i<[[responseDict objectForKey:@"cases"]count]; i++) {
            NSMutableArray *subArray = [[NSMutableArray alloc] init];
            for (int j=0; j<[[[[responseDict objectForKey:@"cases"]objectAtIndex:i]objectForKey:@"procedures"]count]; j++) {
                
                [subArray addObject:@"Collapse"];
                
            }
            
            [expandCellsArray addObject:subArray];
        }

  
        
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
            
            logoUrl =@"logo1";
            
        }
        else {
        logoUrl = [NSString stringWithFormat:@"https://assertahealth-debhersom.c9.io%@",[[responseDict objectForKey:@"style"]objectForKey:@"logo"]];
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
        
        // service_phone
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
        [data setHelpLine:[[responseDict objectForKey:@"style"]objectForKey:@"service_phone"]];
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     if (responseDict && code == 200) {
         if ([[responseDict valueForKey:@"cases"] count] == 0) {
             // self.noProcedureView.hidden = NO;
             [[KGModal sharedInstance]showWithContentView:popup];
             [KGModal sharedInstance].closeButtonType  =KGModalCloseButtonTypeRight;
         }

             [self.tableView reloadData];
        // }
         
     }}
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex ==0) {
        //
    }
    else if (buttonIndex == 1) {
     // Call Pay Api here
        [self callPayAction];
        isToPay =YES;
    }
}
- (void) callPayAction {
    isToPay = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
   // int i[] = payIdsArray;
    
   //po str int len = sizeof(payIdsArray) / sizeof(int);

//    NSMutableDictionary *postDict = [[NSMutableDictionary alloc]init];
//    [postDict setValue:rollArray forKey:@"existingRoll"];
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:nil];
//    
//    // Checking the format
//    NSLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://assertahealth-debhersom.c9.io/API/V1/actions"]];
    //NSString * payids =[NSString stringWithFormat:@"[%@Z]",payIdsArray];
    NSString * pays = [payIdsArray componentsJoinedByString:@","];
    NSString * ids =[NSString stringWithFormat:@"[%@]",pays];
    
    NSDictionary *parametersDictionary = @{
                                           @"client_id": data.client_id,
                                           @"device_uid":data.devicId,
                                           @"token":data.authToken,
                                           @"action_code":@"pay" ,
                                           @"data" :ids
                                           };
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parametersDictionary options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

    
    
}
- (void)showHidePayBtn {
    
    if (payIdsArray.count >0) {
        self.payBtn.hidden =NO;
    }
    else {
     self.payBtn.hidden =YES;
    }
    
    
}
@end
