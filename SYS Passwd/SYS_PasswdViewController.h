//
//  SYS_PasswdViewController.h
//  SYS Passwd
//
//  Created by Merlin on 11-9-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYS_PasswdViewController : UIViewController <UITextFieldDelegate>  {
    IBOutlet UITextField *OriginalPasswordTextBox;
    IBOutlet UITextField *NewPasswordTextBox;
    IBOutlet UITextField *RetypePasswordTextBox;
    IBOutlet UITextField *PortField;
    IBOutlet UISegmentedControl *SegmentedControl;
    IBOutlet UILabel *TitleLabel, *SelectLabel, *CurrentLabel, *NewLabel, *RetypeLabel, *Note1Label, *Note2Label;
    IBOutlet UIButton *ChangeButton, *PortButton;
    IBOutlet UIBarButtonItem *AboutButton, *ResetButton;
    IBOutlet UIAlertView *AboutAlert, *ResetAlert, *PasswdAlert, *SSHInstallAlert, *PortAlert;
}

-(IBAction) SelectAccount:(id)sender;
-(IBAction) ChangePassword:(id)sender;
-(IBAction) About:(id)sender;
-(IBAction) Reset:(id)sender;
-(IBAction) DismissKeyboard: (id)sender;
-(IBAction) ChangeSSHPort: (id)sender;

@property(nonatomic, retain) IBOutlet UITextField *OriginalPasswordTextBox, *NewPasswordTextBox, *RetypePasswordTextBox;

@end
