//
//  Help.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 13/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface Help : UIViewController <UITableViewDataSource, UITableViewDelegate,MFMailComposeViewControllerDelegate>{
    NSMutableArray *listofItems;
    UIButton *LCButton;
    UITableView *FirstTable;
    CGRect FirstViewframe;
}
@property (nonatomic, retain) NSMutableArray *listofItems;
@property (nonatomic, retain) UIButton *LCButton;
@property (nonatomic, retain) UITableView *FirstTable;
@property (nonatomic, assign)  CGRect FirstViewframe;

- (void)WebsitebuttonPressed;

@end
