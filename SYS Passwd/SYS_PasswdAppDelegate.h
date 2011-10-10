//
//  SYS_PasswdAppDelegate.h
//  SYS Passwd
//
//  Created by Merlin on 11-9-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYS_PasswdViewController;

@interface SYS_PasswdAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SYS_PasswdViewController *viewController;

@end
