//
//  User.m
//  medEcash
//
//  Created by Apple on 22/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "User.h"

@implementation User

+(User *)sharedManager{
    
    static User * share=nil;
    
    @synchronized(self)
    {
        if(!share)
        {
            share = [[User alloc] init];
            
        }
        
    }
    return share;
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
- (void)setMainRootController:(UIViewController*)rootController {
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [UIView
     transitionWithView:window
     duration:0.5
     options:UIViewAnimationOptionTransitionFlipFromLeft
     animations:^(void) {
         BOOL oldState = [UIView areAnimationsEnabled];
         [UIView setAnimationsEnabled:NO];
         UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:rootController];
         [[[[UIApplication sharedApplication] delegate] window] setRootViewController:nav];
         [UIView setAnimationsEnabled:oldState];
     }
     completion:nil];
}
@end
