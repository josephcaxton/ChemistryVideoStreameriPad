//
//  Help.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 13/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "Help.h"
#import "TermsAndConditions.h"
#import "HowtoUse.h"
@implementation Help

@synthesize listofItems,LCButton,FirstTable,FirstViewframe;
#define SCREEN_WIDTH 768
#define SCREEN_HEIGHT 950


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Help";
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,185,55)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = self.navigationItem.title;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    
	listofItems = [[NSMutableArray alloc] init];
    
    NSString *HeaderLocation = [[NSBundle mainBundle] pathForResource:@"header_bar" ofType:@"png"];
    UIImage *HeaderBackImage = [[UIImage alloc] initWithContentsOfFile:HeaderLocation];
    [self.navigationController.navigationBar setBackgroundImage:HeaderBackImage forBarMetrics:UIBarMetricsDefault];
    
	
	// Add items to the array this is hardcoded for now .. may need to be migrated to the database
	[listofItems addObject:@"How to use this app"];
    [listofItems addObject:@"Terms and Conditions"];
    
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
    [super viewWillAppear:animated]; 
    
    self.FirstTable.center = self.view.center;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(150, 0, 0, 0);
    self.FirstTable.contentInset = inset;
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return [listofItems count];
    }
	else {
        
		return 1;
	}
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1 && indexPath.row == 0  ) {
        return  371;
    }
   	
    else
        return 50;
}






// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    if (indexPath.section == 0) {
        
        NSString *cellValue = [[NSString alloc] initWithFormat:@"%@",[listofItems objectAtIndex:indexPath.row]];
        cell.textLabel.text = cellValue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    else if (indexPath.section == 1) {
        
        UIView *PromoView = [[UIView alloc] init];
        NSString *PromoImagePath = [[NSBundle mainBundle] pathForResource:@"website_promo" ofType:@"png"];
        UIImage *PromoImage = [[UIImage alloc] initWithContentsOfFile:PromoImagePath];
        UIImageView *PromoImageView = [[UIImageView alloc] initWithImage:PromoImage];
        PromoImageView.frame = CGRectMake(52, 05.0, 665, 361);
        [PromoView addSubview:PromoImageView];
        [cell addSubview:PromoView];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *LCImageLocation = [[NSBundle mainBundle] pathForResource:@"web_promo_btn" ofType:@"png"];
        
        UIImage *LCImage = [[UIImage alloc] initWithContentsOfFile:LCImageLocation];
        
        
        LCButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [LCButton setImage:LCImage forState:UIControlStateNormal];
        LCButton.frame = CGRectMake(265, 280, 250, 50);
        [LCButton addTarget:self action:@selector(WebsitebuttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:LCButton];
    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
  	
	return cell;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        
        int index = indexPath.row;
        
        switch (index) {
                
            case 0:
            {
                ;
                HowtoUse *Howto = [[HowtoUse alloc] initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:Howto animated:YES];
                
                break;
            }
                
            case 1:
            {
                ;
                TermsAndConditions *Terms = [[TermsAndConditions alloc] initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:Terms animated:YES];
                
                
                break; 
            }
                
        }
        
    }
}

- (void)WebsitebuttonPressed {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.learnerscloud.com"]];
    
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
    
    self.FirstTable.center = self.view.center;
    
    // [FirstTable reloadData];
    
    
}


@end
