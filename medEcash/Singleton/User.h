//
//  User.h
//  medEcash
//
//  Created by Apple on 22/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface User : NSObject
@property(strong,nonatomic)NSString * devicId;
@property(strong,nonatomic)NSString  *username;
@property(strong,nonatomic)NSString  *client_id;
@property(strong,nonatomic)NSString  *token;
@property(strong,nonatomic)NSString  *birthDate;
@property(strong,nonatomic)NSString  *authToken;
@property (strong,nonatomic)UIColor *stausBarClr;
@property (strong,nonatomic)UIColor *bgClr;

-(UIColor*)colorWithHexString:(NSString*)hex;
+(User *)sharedManager;
@end
