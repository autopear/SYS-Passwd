//
//  SYS_PasswdViewController.m
//  SYS Passwd
//
//  Created by Merlin on 11-9-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SYS_PasswdViewController.h"
#import "file_passwd.h"
#import <stdio.h>

@implementation SYS_PasswdViewController
@synthesize OriginalPasswordTextBox, NewPasswordTextBox, RetypePasswordTextBox;

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
    [PortButton setTitle:NSLocalizedString(@"SSH Port", @"SSH Port") forState:UIControlStateNormal];
    
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

    PortAlert =[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Change SSH Port", @"Change SSH Port") message:@" " delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"OK", @"OK"), nil];
    
    PortField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    PortField.placeholder = NSLocalizedString(@"Default SSH port is 22", @"Default SSH port is 22");
    [PortField setBackgroundColor:[UIColor whiteColor]];
    [PortField setKeyboardAppearance:UIKeyboardAppearanceAlert];
    [PortField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [PortField setTextAlignment:UITextAlignmentCenter];
    [PortAlert addSubview:PortField];
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
//    [PortField release]
    [super dealloc];
}

- (IBAction) ChangePassword:(id)change {
    CurrentPassword = OriginalPasswordTextBox.text;
    NewPassword = NewPasswordTextBox.text;
    VerificationPassword = RetypePasswordTextBox.text;
        
    if (NewPassword.length >= 6 && VerificationPassword.length >= 6) {
        if ([NewPassword isEqualToString:VerificationPassword]) {
            int err = file_passwd(AccountName, (getuid() == 0), [CurrentPassword UTF8String], [NewPassword UTF8String]);
                
            if(err == ERR_OLD_PW_WRONG) {
                PasswdAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"The current password is incorrect.", @"The current password is incorrect.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            } else if(err != 0) {
                PasswdAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:[NSString stringWithFormat:NSLocalizedString(@"Error code: %d", @"Error code: %d"),err] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            } else {
                PasswdAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success", @"Success") message:[NSString stringWithFormat:NSLocalizedString(@"The password of %s has been changed.\n\nPlease do remember the new password.", @"The password of %s has been changed.\n\nPlease do remember the new password."), AccountName] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            }
        } else {
            PasswdAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"The two passwords do not match.", @"The two passwords do not match.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
        }
    } else {
        PasswdAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"The password must have at least 6 characters.", @"The password must have at least 6 characters.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
    }
        
    [PasswdAlert show];
    [PasswdAlert release];
}

- (IBAction) About:(id)sender {
    AboutAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"About", @"About") message:
                 NSLocalizedString(@"Copyright © 2011 Merlin Mao\nAll rights reserved.", @"Copyright © 2011 Merlin Mao\nAll rights reserved.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
    [AboutAlert show];
    [AboutAlert release];
}



- (IBAction) SelectAccount:(id)sender {
    SegmentedControl = sender ;
    if ([SegmentedControl selectedSegmentIndex] == 0)
        AccountName = "root";
    else
        AccountName = "mobile";
}

- (IBAction) Reset:(id)sender {
    ResetAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", @"Sorry") message:NSLocalizedString(@"There is no way to reset your password except restoring and rejailbreaking your device.", @"There is no way to reset your password except restoring and rejailbreaking your device.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
    [ResetAlert show];
    [ResetAlert release];
}


- (IBAction)DismissKeyboard: (id)sender {
    [sender resignFirstResponder];
}

- (IBAction)ChangeSSHPort: (id)sender {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/LaunchDaemons/com.openssh.sshd.plist"]) {
        [PortAlert show];
    } else {
        SSHInstallAlert =[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Cannot find OpenSSH", @"Cannot find OpenSSH") message:NSLocalizedString(@"OpenSSH is not installed, please install OpenSSH via Cydia first.", @"OpenSSH is not installed, please install OpenSSH via Cydia first.") delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:NSLocalizedString(@"Install", @"Install"), nil];
        [SSHInstallAlert show];
        [SSHInstallAlert release];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == SSHInstallAlert && buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/openssh"]];
    }
    if(alertView == PortAlert && buttonIndex == 1) {
        NSString *ssh_cfg = @"/etc/ssh/ssh_config";
        NSString *sshd_cfg = @"/etc/ssh/sshd_config";
        NSScanner *NumericScanner = [NSScanner scannerWithString:PortField.text];
        int val; 
        if (![NumericScanner scanInt:&val] || ![NumericScanner isAtEnd]) {
            UIAlertView *InvalidPortAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"The port number must be an integer.", @"The port number must be an integer.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            PortField.text = @"";
            [InvalidPortAlert show];
            [InvalidPortAlert release];
        } else {
            if ([[NSFileManager defaultManager] fileExistsAtPath:ssh_cfg]) {
                NSString *content = @"";
                NSArray *lines = [[NSString stringWithContentsOfFile:ssh_cfg encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\n"];
                
                int cnt = 0;
                for (int i=0; i<[lines count]; i++) {
                    NSString *line = [lines objectAtIndex:i];

                    const char *charline = [line UTF8String];
                    bool portLine;
                    if ([line length] <= 1)
                        portLine = false;
                    else {
                        portLine = true;
                        for (int j=0; j<strlen(charline); j++) {
                            if (charline[j] != '#' && charline[j] != 'P' && charline[j] != 'o' && charline[j] != 'r' && charline[j] != 't' && charline[j] != '0' && charline[j] != '1' && charline[j] != '2' && charline[j] != '3' && charline[j] != '4' && charline[j] != '5' && charline[j] != '6' && charline[j] != '7' && charline[j] != '8' && charline[j] != '9' && charline[j] != ' ' && charline[j] != '\t') {
                                portLine = false;
                                break;
                            }
                        }
                    }

                    if (!portLine) {
                        content = [content stringByAppendingString:line];
                    } else {
                        if (cnt++ == 0) {
                            content = [[content stringByAppendingString:@"Port "] stringByAppendingString:PortField.text];
                        } else {
                            content = [content stringByAppendingString:[@"#" stringByAppendingString:[line stringByReplacingOccurrencesOfString:@"#" withString:@""]]];
                        }
                    }
                    content = [content stringByAppendingString:@"\n"];
                }
                [content writeToFile:ssh_cfg atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            if ([[NSFileManager defaultManager] fileExistsAtPath:sshd_cfg]) {
                NSString *content = @"";
                NSArray *lines = [[NSString stringWithContentsOfFile:ssh_cfg encoding:NSUTF8StringEncoding error:nil] componentsSeparatedByString:@"\n"];
                
                int cnt = 0;
                for (int i=0; i<[lines count]; i++) {
                    NSString *line = [lines objectAtIndex:i];
                    
                    const char *charline = [line UTF8String];
                    bool portLine;
                    if ([line length] <= 1)
                        portLine = false;
                    else {
                        portLine = true;
                        for (int j=0; j<strlen(charline); j++) {
                            if (charline[j] != '#' && charline[j] != 'P' && charline[j] != 'o' && charline[j] != 'r' && charline[j] != 't' && charline[j] != '0' && charline[j] != '1' && charline[j] != '2' && charline[j] != '3' && charline[j] != '4' && charline[j] != '5' && charline[j] != '6' && charline[j] != '7' && charline[j] != '8' && charline[j] != '9' && charline[j] != ' ' && charline[j] != '\t') {
                                portLine = false;
                                break;
                            }
                        }
                    }
                    
                    if (!portLine) {
                        content = [content stringByAppendingString:line];
                    } else {
                        if (cnt++ == 0) {
                            content = [[content stringByAppendingString:@"Port "] stringByAppendingString:PortField.text];
                        } else {
                            content = [content stringByAppendingString:[@"#" stringByAppendingString:[line stringByReplacingOccurrencesOfString:@"#" withString:@""]]];
                        }
                    }
                    content = [content stringByAppendingString:@"\n"];
                }
                [content writeToFile:sshd_cfg atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            system("launchctl unload -w /Library/LaunchDaemons/com.openssh.sshd.plist");
            system("launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist");
            UIAlertView *PortChangedAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success", @"Success") message:[NSString stringWithFormat:NSLocalizedString(@"The SSH port has been changed to %d.", @"The SSH port has been changed to %d."), [PortField.text intValue]] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            PortField.text = @"";
            [PortChangedAlert show];
            [PortChangedAlert release];
        }
    }
}

@end
