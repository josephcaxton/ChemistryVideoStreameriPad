//
//  Coverage.m
//  MathsiGCSEVideosiPad
//
//  Created by Joseph caxton-Idowu on 04/01/2013.
//  Copyright (c) 2013 caxtonidowu. All rights reserved.
//

#import "Coverage.h"
#import "CoverageViewer.h"

@implementation Coverage

@synthesize listofItems,listofItemsFileNames,FirstTable,FirstViewframe;
#define SCREEN_WIDTH 768
#define SCREEN_HEIGHT 950

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Coverage";
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,185,55)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = self.navigationItem.title;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    
	listofItems = [[NSMutableArray alloc] init];
    listofItemsFileNames = [[NSMutableArray alloc] init];
    
    NSString *HeaderLocation = [[NSBundle mainBundle] pathForResource:@"header_bar" ofType:@"png"];
    UIImage *HeaderBackImage = [[UIImage alloc] initWithContentsOfFile:HeaderLocation];
    [self.navigationController.navigationBar setBackgroundImage:HeaderBackImage forBarMetrics:UIBarMetricsDefault];
    
	
	// Add items to the array this is hardcoded for now .. may need to be migrated to the database
	[listofItems addObject:@"GCSE Chemistry WJEC Examination Coverage"];
    [listofItemsFileNames addObject:@"GCSE-Chemistry-WJEC-Examination-Coverage"];
    
    [listofItems addObject:@"GCSE Chemistry OCR Gateway B Examination Coverage"];
    [listofItemsFileNames addObject:@"GCSE-Chemistry-OCR-Gateway-B-Examination-Coverage"];
    
    [listofItems addObject:@"GCSE Chemistry OCR 21st Century A Examination Coverage"];
    [listofItemsFileNames addObject:@"GCSE-Chemistry-OCR-21st-Century-A-Examination-Coverage"];
    
    [listofItems addObject:@"GCSE Chemistry Edexcel Examination Coverage"];
    [listofItemsFileNames addObject:@"GCSE-Chemistry-Edexcel-Examination-Coverage"];
    
    [listofItems addObject:@"GCSE Chemistry CCEA Examination Coverage"];
    [listofItemsFileNames addObject:@"GCSE-Chemistry-CCEA-Examination-Coverage"];
    
    [listofItems addObject:@"GCSE Chemistry AQA Examination Coverage"];
    [listofItemsFileNames addObject:@"GCSE-Chemistry-AQA-Examination-Coverage"];
    
    FirstViewframe = CGRectMake(0 ,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.FirstTable = [[UITableView alloc] initWithFrame:FirstViewframe style:UITableViewStyleGrouped];
    FirstTable.delegate = self;
	FirstTable.dataSource = self;
    FirstTable.backgroundColor = [UIColor clearColor];
    FirstTable.backgroundView = nil;
    NSString *BackImagePath = [[NSBundle mainBundle] pathForResource:@"Background" ofType:@"png"];
	UIImage *BackImage = [[UIImage alloc] initWithContentsOfFile:BackImagePath];
    //FirstTable.backgroundColor = [UIColor colorWithPatternImage:BackImage];
    self.view.backgroundColor = [UIColor colorWithPatternImage:BackImage];
    [self.view addSubview:FirstTable];
    
	
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        
		return [listofItems count];
	
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
           return 50;
}




// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
        
        NSString *cellValue = [[NSString alloc] initWithFormat:@"%@",[listofItems objectAtIndex:indexPath.row]];
        cell.textLabel.text = cellValue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    
    	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
  	
	return cell;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
        
        NSString *FileName = [[NSString alloc] initWithFormat:@"%@",[listofItemsFileNames objectAtIndex:indexPath.row]];
        
        CoverageViewer *CoverageView = [[CoverageViewer alloc] initWithNibName:nil bundle:nil];
        CoverageView.DocumentName = FileName;
    
        [self.navigationController pushViewController:CoverageView animated:YES];
                
                       
    }


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// For ios 6
-(NSUInteger)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskAll;
    
    
}
//ios 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ) {
        
        self.FirstTable.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
        
    }
    else {
        self.FirstTable.frame = CGRectMake(0,0,SCREEN_HEIGHT + 80 ,SCREEN_WIDTH);
        
    }

    
    
}




@end
