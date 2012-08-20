//
//  PopUpTableviewViewController.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 15/06/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "FBConnect.h"
#import "AppDelegate.h"
#import <Twitter/Twitter.h>
#import "GANTracker.h"

@interface PopUpTableviewViewController : UITableViewController<MFMailComposeViewControllerDelegate,FBSessionDelegate,FBDialogDelegate>{

   // NSMutableArray *listofItems;
    
    UIPopoverController *m_popover;
    Facebook *facebook;
    UIButton *logoutFacebook;
    
    UIActivityIndicatorView * activityIndicator;

}
//@property (nonatomic, retain) NSMutableArray *listofItems;
@property (nonatomic, retain) UIPopoverController *m_popover;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) UIButton *logoutFacebook;
@property (nonatomic, retain)  UIActivityIndicatorView * activityIndicator;

- (void)AddProgress;

@end
