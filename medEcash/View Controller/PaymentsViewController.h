//
//  PaymentsViewController.h
//  medEcash
//
//  Created by Apple on 16/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "MBProgressHUD.h"

@interface PaymentsViewController : UIViewController {
    NSMutableArray * dataArray;
    NSMutableArray * selectedCellsArray;
    NSMutableArray * expandCellsArray;
    BOOL isSelectedAll;
    NSMutableDictionary * responseDict;
    User *data;
}
@property (strong, nonatomic) NSMutableData *responseData;
- (IBAction)menuBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
