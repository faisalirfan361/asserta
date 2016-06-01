//
//  PaymentsViewController.m
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "PaymentsViewController.h"

@implementation PaymentsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self loadData];
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
    
    data = [User sharedManager];
    self.view.backgroundColor = data.bgClr;
}
#pragma mark - Table view data source


-(void) loadData {

    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://assertahealth-debhersom.c9.io/API/UAT/resources"]];
    
    NSDictionary *parametersDictionary = @{
                                           @"client_id": @"IOS",
                                           @"device_uid":data.devicId,
                                           @"token":data.token,
                                           @"resource_type": @"all"
                                           };
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parametersDictionary options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

        
    
        // Display recipe in the table cell
        UILabel *payToLbl = (UILabel *)[cell viewWithTag:100];
        payToLbl.text = @"Pay To";
        
        UIButton * checkBtn= (UIButton *)[cell viewWithTag:101];
        
        UILabel *mainTitleLbk = (UILabel *)[cell viewWithTag:102];
        mainTitleLbk.textColor= [UIColor blackColor];
        mainTitleLbk.text=@"Cumming GA Physical Therpay Clinic";
        
        UILabel *subTitleLbk = (UILabel *)[cell viewWithTag:103];
        subTitleLbk.text=@"Physical Therapy Treatements";
        
        UILabel *addressLbl = (UILabel *)[cell viewWithTag:104];
        
        addressLbl.text=@"2920 Ronals Regan Blvd Suit 102 Cumming GA , 30041";
        
        
        UILabel *numberLbl = (UILabel *)[cell viewWithTag:105];
        
        numberLbl.text=@"(0404) 555-1212";
   
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

    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    static NSString *CellIdentifier = @"HeaderCell";
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
    
    return 0;
}
-(void)checkBtnClicked:(id)sender
{
    // Getting the indexPath of cell of clicked button
    
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    
    // No need to use tag sender will keep the reference of clicked button
    UIButton *button = (UIButton *)sender;
    NSString * tagStr = [NSString stringWithFormat:@"%li", (long)((UIControl*)sender).tag];
    //Checking the condition button is checked or unchecked.
    //accordingly replace the array object and change the button image
    if([selectedCellsArray containsObject:tagStr])
    {
        [button setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [selectedCellsArray removeObject:tagStr];
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        [selectedCellsArray addObject:tagStr];
    }
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
    if ([responseStr isEqualToString:@"\"No Procedures Found\""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:responseStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    else if (responseDict) {
        
        
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
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
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
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
  //
    
}
@end
