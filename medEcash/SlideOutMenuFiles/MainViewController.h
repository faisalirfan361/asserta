//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface MainViewController : UIViewController {
    NSMutableArray * dataArray;
    NSMutableArray * selectedCellsArray;
    NSMutableArray * expandCellsArray;
    BOOL isSelectedAll;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
