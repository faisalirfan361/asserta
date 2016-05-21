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

@end
