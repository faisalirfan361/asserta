//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "KGModal.h"
#import "User.h"
#import "MBProgressHUD.h"
@interface MainViewController : UIViewController<UIPopoverControllerDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray * dataArray;
    NSMutableArray * selectedCellsArray;
    NSMutableArray * expandCellsArray;
    BOOL isSelectedAll;
    NSMutableDictionary * responseDict;
    User *data;
    NSMutableArray * data2;
    NSMutableArray * data1;
}
- (IBAction)payBtnAction:(id)sender;
@property (strong, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
