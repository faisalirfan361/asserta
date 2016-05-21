//
//  CallUsViewcontroller.h
//  medEcash
//
//  Created by Apple on 21/05/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCDialPad.h"
#import "JCPadButton.h"
#import "FontasticIcons.h"
@interface CallUsViewcontroller : UIViewController<JCDialPadDelegate>
@property (strong, nonatomic) JCDialPad *view;
@end
