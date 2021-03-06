//
//  AppDelegate.m
//  medEcash
//
//  Created by Apple on 12/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "AppDelegate.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"dejavu-sans.bold" size:18], NSFontAttributeName, nil]];
    [application setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
   // 
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    User *data;
    data = [User sharedManager];
    [data setDevicId:uniqueIdentifier];
    [data setClient_id:@"10ba5c72-1463-42f5-8a27-61f815d7d552"];
    [data setHelpLine:@"801-783-3391"];
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"colorScheme1"] == nil || [[[NSUserDefaults standardUserDefaults] stringForKey:@"colorScheme1"] length] >8) {
         data.statusBarCrlStr = @"6b322a";
        [data setStausBarClr:[data colorWithHexString:@"6b322a"]];
    }
    
    else {
    
    [data setStausBarClr:[data colorWithHexString:[[NSUserDefaults standardUserDefaults] stringForKey:@"colorScheme1"]]];
    }
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"colorScheme2"] == nil || [[[NSUserDefaults standardUserDefaults] stringForKey:@"colorScheme2"]length ]> 8 ) {
        
        data.bgBarCrlStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"colorScheme2"];
        data.bgClr =[data colorWithHexString:@"84271a"];
        [data setBgClr:[data colorWithHexString:@"84271a"]];
    }
    else {
        data.bgClr =[data colorWithHexString:[[NSUserDefaults standardUserDefaults] stringForKey:@"colorScheme2"]];
        data.bgBarCrlStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"colorScheme2"];
    }
    
    //
    //
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"]) {
     //   go as normal
    } else {
    //already used verification code soe show sign in view controller
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UserSignInViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"signinVC"];
        UINavigationController * navVC =[[UINavigationController alloc]initWithRootViewController:vc];
        [navVC.navigationBar setHidden:YES];
        self.window.rootViewController =navVC;
    }
    
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"] == nil ||[[[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"] isEqualToString:@"logo"] ) {
        
        data.logoUrlstr = [[NSUserDefaults standardUserDefaults] stringForKey:@"appLogo"];
        
    }
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
        view.backgroundColor=data.stausBarClr;
        [self.window.rootViewController.view addSubview:view];
    }
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
@end
