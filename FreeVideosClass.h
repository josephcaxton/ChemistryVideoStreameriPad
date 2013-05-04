//
//  FreeVideos.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 14/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopUpTableviewViewController.h"
@interface FreeVideosClass :  UITableViewController  <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate>{
    
    
    NSMutableArray *ArrayofConfigObjects;
    NSMutableArray *filteredArrayofConfigObjects;
    NSMutableArray *ProductIDs;
    NSMutableArray *ImageObjects;
    NSMutableArray *ProductsSubscibedTo;
    BOOL FullSubscription;
    UIPopoverController *popover;
    UISearchBar  *mySearchBar;
    NSMutableArray* buttons;
    UIBarButtonItem *SubscribeButton;
    UIBarButtonItem *ShareButton;
    
}

@property (nonatomic, retain) NSMutableArray *ArrayofConfigObjects;
@property (nonatomic, retain) NSMutableArray *filteredArrayofConfigObjects;
@property (nonatomic, retain) NSMutableArray *ProductIDs;
@property (nonatomic, retain)  NSMutableArray *ImageObjects;
@property (nonatomic, retain)  NSMutableArray *ProductsSubscibedTo;
@property (nonatomic, assign) BOOL FullSubscription;
@property (nonatomic, retain)  UIPopoverController *popover;
@property (nonatomic, retain) UISearchBar *mySearchBar;
@property (nonatomic, retain) NSMutableArray* buttons;
@property (nonatomic, retain) UIBarButtonItem *SubscribeButton;
@property (nonatomic, retain) UIBarButtonItem *ShareButton;



-(BOOL)ShouldIDownloadOrNot:(NSString*) urllPath :(NSString*)LocalFileLocation;
-(void)GetConfigFileFromServeWriteToPath:(NSString*)Path;
-(void)Alertfailedconnection;
-(void)MyParser:(NSString *)FileLocation;
-(void)ConfigureProductList:(NSString *)ProductID;
-(void)RefreshTable:(NSNotification *)note;
-(void)RefeshTable;
//-(void)AdjustProductSubscribedTo;

- (void)reviewPressed;
-(IBAction)ViewFree:(UIButton*)sender;
-(IBAction)GoSubScribe:(UIButton*)sender;
@end
