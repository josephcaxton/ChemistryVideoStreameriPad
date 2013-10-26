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

@synthesize listofItems,LCButton,FirstTable,FirstViewframe,PromoImageView,PromoImage;
#define SCREEN_WIDTH 768
#define SCREEN_HEIGHT 950
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Help";
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.navigationItem.titleView.frame.origin.x,55)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = self.navigationItem.title;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    
    

	listofItems = [[NSMutableArray alloc] init];
    
    NSString *HeaderLocation = [[NSBundle mainBundle] pathForResource:@"header_bar" ofType:@"png"];
    UIImage *HeaderBackImage = [[UIImage alloc] initWithContentsOfFile:HeaderLocation];
    [self.navigationController.navigationBar setBackgroundImage:HeaderBackImage forBarMetrics:UIBarMetricsDefault];
    
	
	// Add items to the array this is hardcoded for now .. may need to be migrated to the database
	[listofItems addObject:@"How to use this app"];
    [listofItems addObject:@"Terms and Conditions"];
    [listofItems addObject:@"Report Problem"];
    
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
        PromoImage = [[UIImage alloc] initWithContentsOfFile:PromoImagePath];
        PromoImageView = [[UIImageView alloc] initWithImage:PromoImage];
        PromoImageView.frame = CGRectMake(0, 05.0, 665, 361);
        [PromoView addSubview:PromoImageView];
        [cell addSubview:PromoView];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *LCImageLocation = [[NSBundle mainBundle] pathForResource:@"web_promo_btn" ofType:@"png"];
        
        UIImage *LCImage = [[UIImage alloc] initWithContentsOfFile:LCImageLocation];
        
        
        LCButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [LCButton setImage:LCImage forState:UIControlStateNormal];
        LCButton.frame = CGRectMake(200, 280, 250, 50);
        [LCButton addTarget:self action:@selector(WebsitebuttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:LCButton];
    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
  	 [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
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
            case 2:
            {
                ;
                [self ReportProblem:self] ;
                
                break;
            }
                
                
        }
        
    }
}


- (void)WebsitebuttonPressed {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.learnerscloud.com"]];
    
}

-(IBAction)ReportProblem:(id)sender{
	
	if ([MFMailComposeViewController canSendMail]) {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *DeviceID = [prefs stringForKey:@"LCUIID"];
        
        NSArray *SendTo = [NSArray arrayWithObjects:@"support@LearnersCloud.com",nil];
        
        MFMailComposeViewController *SendMailcontroller = [[MFMailComposeViewController alloc]init];
        SendMailcontroller.mailComposeDelegate = self;
        [SendMailcontroller setToRecipients:SendTo];
        [SendMailcontroller setSubject:[NSString stringWithFormat:@"%@ Chemistry video streaming iPad",DeviceID]];
        
        [SendMailcontroller setMessageBody:[NSString stringWithFormat:@"Add Message here "] isHTML:NO];
        [self presentModalViewController:SendMailcontroller animated:YES];
        
		
	}
	
	else {
		UIAlertView *Alert = [[UIAlertView alloc] initWithTitle: @"Cannot send mail"
                                                        message: @"Device is unable to send email in its current state. Configure email" delegate: self
                                              cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		
		
		
		[Alert show];
		
		
	}
    
	
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
	
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
	
	
	
	
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
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ) {
		
        //To fix ios7 extending edges
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            
            FirstViewframe = CGRectMake(0 ,0, SCREEN_WIDTH, SCREEN_HEIGHT);
            FirstTable.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
            PromoImageView.frame  = CGRectMake(55, 05.0, 665, 361);
            LCButton.frame = CGRectMake(280, 280, 250, 50);
        }
        else{
            
            FirstViewframe = CGRectMake(0 ,0, SCREEN_WIDTH, SCREEN_HEIGHT);
            FirstTable.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
            PromoImageView.frame  = CGRectMake(50, 05.0, 665, 361);
            LCButton.frame = CGRectMake(260, 280, 250, 50);
        }
	}
	
	else {
        
        //To fix ios7 extending edges
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            
            FirstViewframe = CGRectMake(0 ,0, SCREEN_HEIGHT, SCREEN_WIDTH);
            FirstTable.frame = CGRectMake(50.0,0,SCREEN_HEIGHT,SCREEN_WIDTH);
            PromoImageView.frame  = CGRectMake(130, 05.0, 665, 361);
            LCButton.frame = CGRectMake(340, 280, 250, 50);
            
            
        }
        else{
            
            FirstViewframe = CGRectMake(0 ,0, SCREEN_HEIGHT, SCREEN_WIDTH);
            FirstTable.frame = CGRectMake(50.0,0,SCREEN_HEIGHT,SCREEN_WIDTH);
            PromoImageView.frame  = CGRectMake(140, 05.0, 665, 361);
            LCButton.frame = CGRectMake(360, 280, 250, 50);
        }
		
	}
    

    
    
}

@end
