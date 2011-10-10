//
//  SYS_PasswdViewController.m
//  SYS Passwd
//
//  Created by Merlin on 11-9-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SYS_PasswdViewController.h"
#import "file_passwd.h"

@implementation SYS_PasswdViewController
@synthesize OriginalPasswordTextBox, NewPasswordTextBox, RetypePasswordTextBox;//, SegmentedControl;

char * AccountName;
int SelectedIndex;
NSString *CurrentPassword, *NewPassword, *VerificationPassword;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    AboutButton.title = NSLocalizedString(@"About", @"About");
    ResetButton.title = NSLocalizedString(@"Reset", @"Reset");
    [ChangeButton setTitle:NSLocalizedString(@"Change Password", @"Change Password") forState:UIControlStateNormal];
    TitleLabel.text = NSLocalizedString(@"SYS Passwd", @"SYS Passwd");
    SelectLabel.text = NSLocalizedString(@"Change Passwd for", @"Change Passwd for");
    CurrentLabel.text = NSLocalizedString(@"Current Passwd", @"Current Passwd");
    NewLabel.text = NSLocalizedString(@"New Passwd", @"New Passwd");
    RetypeLabel.text = NSLocalizedString(@"Retype Passwd", @"Retype Passwd");
    Note1Label.text = NSLocalizedString(@"* The password will be used for login, ssh, etc.", @"* The password will be used for login, ssh, etc.");
    Note2Label.text = NSLocalizedString(@"* There is NO way to recover the password.", @"* There is NO way to recover the password.");
    OriginalPasswordTextBox.placeholder = NSLocalizedString(@"Default is \"alpine\"", @"Default is \"alpine\"");
    NewPasswordTextBox.placeholder = NSLocalizedString(@"Type new password here", @"Type new password here");
    RetypePasswordTextBox.placeholder = NSLocalizedString(@"Retype the new password", @"Retype the new password");

    AccountName = "root";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.OriginalPasswordTextBox = nil;
    self.NewPasswordTextBox = nil;
    self.RetypePasswordTextBox = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    BOOL iPad = NO;
    #ifdef UI_USER_INTERFACE_IDIOM
    iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    #endif
    if (iPad) {
        return YES;
    } else {
        return NO;
    }
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction) ChangePassword:(id)change {
    CurrentPassword = OriginalPasswordTextBox.text;
    NewPassword = NewPasswordTextBox.text;
    VerificationPassword = RetypePasswordTextBox.text;
    
    
    UIAlertView *alertView;
    
    if (NewPassword.length >= 6 && VerificationPassword.length >= 6) {
        if ([NewPassword isEqualToString:VerificationPassword]) {
            int err = file_passwd(AccountName, (getuid() == 0), [CurrentPassword UTF8String], [NewPassword UTF8String]);
                
            if(err == ERR_OLD_PW_WRONG) {
                alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"The current password is incorrect.", @"The current password is incorrect.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            } else if(err != 0) {
                alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:[NSString stringWithFormat:NSLocalizedString(@"Error code: %d", @"Error code: %d"),err] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            } else {
                alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success", @"Success") message:[NSString stringWithFormat:NSLocalizedString(@"The password of %s has been changed.\n\nPlease do remember the new password.", @"The password of %s has been changed.\n\nPlease do remember the new password."), AccountName] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            }
        } else {
            alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"The two passwords do not match.", @"The two passwords do not match.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
        }
    } else {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"The password must have at least 6 characters.", @"The password must have at least 6 characters.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
    }
        
    [alertView show];
    [alertView release];
}

- (IBAction) About:(id)sender {
    UIAlertView *alertView;
    alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"About", @"About") message:
                 NSLocalizedString(@"Copyright © 2011 Merlin Mao\nAll rights reserved.", @"Copyright © 2011 Merlin Mao\nAll rights reserved.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}



- (IBAction) SelectAccount:(id)sender {
    SegmentedControl = sender ;
    if ([SegmentedControl selectedSegmentIndex] == 0)
        AccountName = "root";
    else
        AccountName = "mobile";
}

- (IBAction) Reset:(id)sender {
    UIAlertView *alertView;
    alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", @"Sorry") message:NSLocalizedString(@"There is no way to reset your password except restoring and rejailbreaking your device.", @"There is no way to reset your password except restoring and rejailbreaking your device.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}


-(IBAction)DismissKeyboard: (id)sender {
    [sender resignFirstResponder];
}
@end
