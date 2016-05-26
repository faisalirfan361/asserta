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
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:143.0/255.0 green:38.0/255.0 blue:30.0/255.0 alpha:1.0]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.title = @"medEcash";
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainLogo"]];
    self.navigationItem.titleView = imageView;

    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    selectedCellsArray = [[NSMutableArray alloc]init];
    expandCellsArray = [[NSMutableArray alloc]init];
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
    return [responseDict count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   return  [[[[responseDict valueForKey:@"cases"]valueForKey:@"procedures"]objectAtIndex:section]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *payemtStr =[[[[[responseDict valueForKey:@"cases"]valueForKey:@"procedures"]objectAtIndex:indexPath.section]valueForKey:@"paid"]objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
        //if ([payemtStr  isEqual:@"0"]) {
        //UnpiadCell
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
//    if (indexPath.section == 0) {
//        if (dataArray) {
//             data1 = [[NSMutableArray alloc]initWithArray:[dataArray objectAtIndex:0]];
//        }
//        UILabel *payToLbl = (UILabel *)[cell viewWithTag:100];
//         BOOL is = [[[data1 valueForKey:@"paid"]objectAtIndex:indexPath.row] boolValue];
//        if (is == YES) {
//            payToLbl.text = @"";
//        }
//        else
//        {
//          payToLbl.text = @"Pay To";
//        }
//    }
//    
//    if (indexPath.section == 1) {
//        if (dataArray) {
//            data2 = [[NSMutableArray alloc]initWithArray:[dataArray objectAtIndex:1]];
//        
//            
//            UILabel *payToLbl = (UILabel *)[cell viewWithTag:100];
//            BOOL is = [[[data2 valueForKey:@"paid"]objectAtIndex:indexPath.row]boolValue];
//            if (is== YES) {
//                payToLbl.text = @"";
//            }
//            else
//            {
//                payToLbl.text = @"Pay To";
//            }
//  
//        
//        }
//
//    }

        // Display recipe in the table cell
//        UILabel *payToLbl = (UILabel *)[cell viewWithTag:100];
//        payToLbl.text = @"Pay To";
    
        UIButton * checkBtn= (UIButton *)[cell viewWithTag:101];
        
        UILabel *mainTitleLbk = (UILabel *)[cell viewWithTag:102];
        mainTitleLbk.textColor= [UIColor blackColor];
        //mainTitleLbk.text=[[[[[responseDict valueForKey:@"cases"]valueForKey:@"procedures"]objectAtIndex:indexPath.section]valueForKey:@"provider"]objectAtIndex:indexPath.row];
        
       // UILabel *subTitleLbk = (UILabel *)[cell viewWithTag:103];
       // subTitleLbk.text=[[[[[responseDict valueForKey:@"cases"]valueForKey:@"procedures"]objectAtIndex:indexPath.section]valueForKey:@"description"]objectAtIndex:indexPath.row];
        //NSString * completeAddressString = [NSString stringWithFormat:@"%@ %@",[[[[[responseDict valueForKey:@"cases"]valueForKey:@"line_1"]objectAtIndex:indexPath.section]valueForKey:@"line_2"]objectAtIndex:indexPath.row],[[[[[responseDict valueForKey:@"cases"]valueForKey:@"procedures"]objectAtIndex:indexPath.section]valueForKey:@"provider"]objectAtIndex:indexPath.row]];
        //UILabel *addressLbl = (UILabel *)[cell viewWithTag:104];
        
      // addressLbl.text=completeAddressString;
        
        
       // UILabel *numberLbl = (UILabel *)[cell viewWithTag:105];
        
       // numberLbl.text=[[[[[responseDict valueForKey:@"cases"]valueForKey:@"procedures"]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]valueForKey:@"phone"];
    
    
    
        UIButton * expandBtn= (UIButton *)[cell viewWithTag:106];
        
        // handeling check uncheck buttons
        
        
        if([[selectedCellsArray objectAtIndex:indexPath.row] isEqualToString:@"Uncheck"])
            [checkBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        else
            [checkBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        
        if([[expandCellsArray objectAtIndex:indexPath.row] isEqualToString:@"Expand"])
            [expandBtn setImage:[UIImage imageNamed:@"collapse.png"] forState:UIControlStateNormal];
        else
            [expandBtn setImage:[UIImage imageNamed:@"expand.png"] forState:UIControlStateNormal];
        
        
        [checkBtn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [expandBtn addTarget:self action:@selector(collapseExpandButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([selectedCellsArray containsObject:@"Check"]) {
            self.payBtn.hidden = NO;
        }
        else {
            self.payBtn.hidden = YES;
        }
      return cell;
    }
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    static NSString *CellIdentifier = @"HeaderCell";
    //UnpiadCell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
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
    if([[selectedCellsArray objectAtIndex:indexPath.row] isEqualToString:@"Uncheck"])
    {
        [button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [selectedCellsArray replaceObjectAtIndex:indexPath.row withObject:@"Check"];
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [selectedCellsArray replaceObjectAtIndex:indexPath.row withObject:@"Uncheck"];
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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://assertahealth-debhersom.c9.io/API/UAT/resources"]];
    
    NSDictionary *parametersDictionary = @{
                                           @"client_id": @"asdf1234",
                                           @"device_uid":@"364364636747364",
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
    responseDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     if (responseDict) {
         
         dataArray = [[responseDict valueForKey:@"cases"]valueForKey:@"procedures"];
        
         [self.tableView reloadData];
}
    
    
    
}


@end
