//
//  Trailers.h
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 30/04/2013.
//  Copyright (c) 2013 caxtonidowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Trailers : UIViewController <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate>{
    
    NSMutableArray *ArrayofConfigObjects1;
    NSMutableArray *filteredArrayofConfigObjects1;
    NSMutableArray *ImageEnglish;
    NSMutableArray *ImageBiology;
    UISearchBar  *mySearchBar1;
    UITableView *FirstTable;
 
    
}

@property (nonatomic, retain) NSMutableArray *ArrayofConfigObjects1;
@property (nonatomic, retain) NSMutableArray *filteredArrayofConfigObjects1;

@property (nonatomic, retain)  NSMutableArray *ImageEnglish;
@property (nonatomic, retain)   NSMutableArray *ImageBiology;
@property (nonatomic, retain) UISearchBar *mySearchBar1;
@property (nonatomic, retain) UITableView *FirstTable;


@end
