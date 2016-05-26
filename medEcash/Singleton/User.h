//
//  User.h
//  medEcash
//
//  Created by Apple on 22/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(strong,nonatomic)NSString * devicId;
@property(strong,nonatomic)NSString  *username;
@property(strong,nonatomic)NSString  *token;
@property(strong,nonatomic)NSString  *birthDate;
@property(strong,nonatomic)NSString  *authToken;
+(User *)sharedManager;
@end
