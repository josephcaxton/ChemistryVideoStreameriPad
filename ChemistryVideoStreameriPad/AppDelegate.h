//
//  AppDelegate.h
//  ChemistryVideoStreameriPad
//
//  Created by Joseph caxton-Idowu on 04/06/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface AppDelegate : NSObject <UIApplicationDelegate,NSXMLParserDelegate>{
    
    NSThread *SecondThread;
    UIWindow *window;
    UITabBarController *tabBarController;
    NSString *SelectProductID;
    UITableViewController *buyScreen;
    NSString *DomainName;
    NSMutableData *SubscriptionStatusData;
    //NSMutableArray *SubscibedProducts;
    BOOL PassageFlag;
    BOOL EmailFlag;
    NSString *UserEmail;
    BOOL DoesUserHaveEmail;
    BOOL AccessAll;
    NSNumber *FlagToLoginOrLogout;

    
    // this is to handle return from facebook
    
    Facebook *m_facebook;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSThread *SecondThread;
@property (nonatomic, retain) NSString *SelectProductID;
@property (nonatomic, retain) UITableViewController *buyScreen;
@property (nonatomic, retain) NSString *DomainName;
@property (nonatomic, retain)  NSMutableData *SubscriptionStatusData;
//@property (nonatomic, retain) NSMutableArray *SubscibedProducts;
@property (nonatomic, assign) BOOL PassageFlag;
@property (nonatomic, assign) BOOL EmailFlag;
@property (nonatomic, retain) NSString *UserEmail;
@property (nonatomic, assign) BOOL DoesUserHaveEmail;
@property (nonatomic, assign) BOOL AccessAll;
@property (nonatomic, retain)  Facebook *m_facebook;
@property (nonatomic, retain)  NSNumber *FlagToLoginOrLogout;


- (NSString *)applicationDocumentsDirectory;
-(BOOL)isDeviceConnectedToInternet;
-(BOOL)downloadfileifUpdated:(NSString*)urLString location:(NSString*)LocalFileLocation;
- (NSString *)GetUUID;
-(void)SubscriptionStatus:(NSString *)DeviceID;
//-(void)WorkOutSubsriptionName:(NSMutableArray*)SubscibedProductsInArray;

@end
