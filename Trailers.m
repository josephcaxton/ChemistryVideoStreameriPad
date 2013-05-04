//
//  Trailers.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 30/04/2013.
//  Copyright (c) 2013 caxtonidowu. All rights reserved.
//

#import "Trailers.h"
#import "AppDelegate.h"
#import "ConfigObject.h"
#import "TrailerPlayer.h"
#import "GANTracker.h"

@implementation Trailers

@synthesize ArrayofConfigObjects1,filteredArrayofConfigObjects1,ImageEnglish,ImageBiology,mySearchBar1,FirstTable;

#define SCREEN_WIDTH 768
#define SCREEN_HEIGHT 950

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    self.navigationItem.title = @"Trailers";
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,185,55)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = self.navigationItem.title;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    
    NSString *HeaderLocation = [[NSBundle mainBundle] pathForResource:@"header_bar" ofType:@"png"];
    UIImage *HeaderBackImage = [[UIImage alloc] initWithContentsOfFile:HeaderLocation];
    [self.navigationController.navigationBar setBackgroundImage:HeaderBackImage forBarMetrics:UIBarMetricsDefault];
    
    CGRect FirstViewframe = CGRectMake(0 ,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.FirstTable = [[UITableView alloc] initWithFrame:FirstViewframe style:UITableViewStyleGrouped];
    FirstTable.delegate = self;
	FirstTable.dataSource = self;
    
    FirstTable.backgroundView = nil;
    NSString *BackImagePath = [[NSBundle mainBundle] pathForResource:@"Background" ofType:@"png"];
	UIImage *BackImage = [[UIImage alloc] initWithContentsOfFile:BackImagePath];
    FirstTable.backgroundColor = [UIColor colorWithPatternImage:BackImage];
    
    [self.view addSubview:FirstTable];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //NSLog(@"Subscibed products= %@", appDelegate.SubscibedProducts);
    
    ImageEnglish = [[NSMutableArray alloc] init];
    ImageBiology = [[NSMutableArray alloc] init];
    int i;
    NSString *loadEnglish;
    NSString *loadBiology;
    
    for(i = 0; i < 8; i++) {
        loadEnglish = [NSString stringWithFormat:@"English%d", i + 1];
        [ImageEnglish addObject:[UIImage imageNamed:loadEnglish]];
        
        loadBiology = [NSString stringWithFormat:@"Biology%d", i + 1];
        [ImageBiology addObject:[UIImage imageNamed:loadBiology]];
        
        
    }
	
    
    
	// Copy or Update the VideoConfig File;
    
    NSString *domain = appDelegate.DomainName;
    NSString *queryFeed = [NSString stringWithFormat:@"%@/iosStreamv2/Trailers/TrailerConfig.xml",domain];
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"TrailerConfig.xml"];
    
    
    
    if(appDelegate.isDeviceConnectedToInternet){
        
        BOOL DownloadIt =  [self ShouldIDownloadOrNot:queryFeed :Dir];
        
        if(DownloadIt == YES){
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSError *error=[[NSError alloc]init];
            
            BOOL success=[fileManager fileExistsAtPath:Dir];
            
            if(success)
        	{
        		[fileManager removeItemAtPath:Dir error:&error];
            }
            
            
            [self GetConfigFileFromServeWriteToPath:Dir];
            
        }
        
        
        
        ArrayofConfigObjects1 = [[NSMutableArray alloc] init];
        filteredArrayofConfigObjects1 = [[NSMutableArray alloc] init];
        
        
    }
    else
    {
        
        [self Alertfailedconnection];
        
    }
	
    [appDelegate.SecondThread cancel];
    
    mySearchBar1 = [[UISearchBar alloc] init];
    mySearchBar1.placeholder = @"Type a search term";
    mySearchBar1.tintColor = [UIColor blackColor];
    mySearchBar1.delegate = self;
    [mySearchBar1 sizeToFit];
    [mySearchBar1 setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar1 sizeToFit];
    FirstTable.tableHeaderView = mySearchBar1;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [ArrayofConfigObjects1 removeAllObjects];
    [filteredArrayofConfigObjects1 removeAllObjects];
    
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"TrailerConfig.xml"];
    [self MyParser:Dir];
    //[self.tableView reloadData];
    
     [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
    
}


-(void)RefreshTable:(NSNotification *)note{
    
    
    [self performSelectorOnMainThread:@selector(RefeshTable) withObject:nil waitUntilDone:NO];
}

-(void)RefeshTable{
    
  
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"TrailerConfig.xml"];
    
    [ArrayofConfigObjects1 removeAllObjects];
    [filteredArrayofConfigObjects1 removeAllObjects];
    
    [self MyParser:Dir];
    [self.FirstTable reloadData];
    
    //[activityIndicator stopAnimating];
    //[activityIndicator hidesWhenStopped];
    
}


-(BOOL)ShouldIDownloadOrNot:(NSString*) urllPath :(NSString*)LocalFileLocation{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BOOL ReturnVal =  [appDelegate downloadfileifUpdated:urllPath location:LocalFileLocation];
    
    return ReturnVal;
    
    
    
    
}
-(void)GetConfigFileFromServeWriteToPath:(NSString*)Path{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *domain = appDelegate.DomainName;
    NSString *queryFeed = [NSString stringWithFormat:@"%@/iosStreamv2/Trailers/TrailerConfig.xml", domain];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:queryFeed]];
    NSURLResponse *resp = nil;
    NSError *err = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
    
    if (response) {
        
        NSError* error;
        
        [response writeToFile:Path options:NSDataWritingAtomic error:&error];
        
        if(error != nil)
            NSLog(@"write error %@", error);
    }
    
    
    
    
}

-(void)Alertfailedconnection{
    
    NSString *message = [[NSString alloc] initWithFormat:@"Your device is not connected to the internet. You need access to the internet to stream our videos "];
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Important Notice"
                                                   message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    
    
    
}

-(void)MyParser:(NSString *)FileLocation{
	
	NSError* error;
	
	NSString* fileContents = [NSString stringWithContentsOfFile:FileLocation encoding:NSWindowsCP1252StringEncoding error:&error];
	
	
	NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"±"]];
	
	for(int idx = 0; idx < pointStrings.count - 1; idx++)
	{
		// break the string down even further to the columns
		NSString* currentPointString = [pointStrings objectAtIndex:idx];
		NSArray* arr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"|"]];
		
		NSString *Title = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:1]];
		NSString *Description = [[NSString alloc] initWithFormat:@"%@", [arr objectAtIndex:3]];
		NSString *Free = [[NSString alloc] initWithFormat:@"%@", [arr objectAtIndex:5]];
		NSString *Subject = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:7]];
		NSString *M3u8 = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:9]];
		NSString *Sociallyfree = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:11]];
        //Reconfigure for apple approval
        //NSString *ProductID = [[NSString alloc] initWithFormat:@"%@",[arr objectAtIndex:13]];
		
        //if ([Show isEqualToString: @"1"]){
        
        ConfigObject *obj = [[ConfigObject alloc] init];
        obj.VideoTitle = Title;
        obj.VideoDescription = Description;
        if ([Free isEqualToString: @"1"]){
            obj.Free = YES;
        }
        else
        {
            obj.Free = NO;
        }
        obj.Subject = Subject;
        obj.M3u8 = [M3u8 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([Sociallyfree isEqualToString: @"1"]){
            
            obj.SociallyFree = YES;
        }
        else
        {
            obj.SociallyFree = NO;
        }
        
        [ArrayofConfigObjects1 addObject:obj];
        
        
        // NSLog(@"Title in my array is: %@",obj.VideoTitle);
        
		
        
	}
    filteredArrayofConfigObjects1 = [ArrayofConfigObjects1 mutableCopy];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	
	int	count = 1;
	
	return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numberOfRows =[filteredArrayofConfigObjects1 count];
	
    return numberOfRows;
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = nil;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    ConfigObject *obj = [filteredArrayofConfigObjects1 objectAtIndex:indexPath.row];
    
    if ([[obj.Subject lowercaseString] isEqualToString:@"biology"]) {
        UIImage* theImage =[ImageBiology objectAtIndex:arc4random() % 8];
        cell.imageView.image = theImage;
        
    }
    else if ([[obj.Subject lowercaseString] isEqualToString:@"english"]) {
        UIImage* theImage =[ImageEnglish objectAtIndex:arc4random() % 8];
        cell.imageView.image = theImage;
    }
    
    
    
        cell.textLabel.text = [obj VideoTitle];
        NSString* descriptiontxt = [obj Subject];
        cell.detailTextLabel.text =descriptiontxt;
        cell.detailTextLabel.textColor = [UIColor blueColor];
        UIImage *FreeImage = [UIImage imageNamed:@"free.png"];
        UIButton *btnFree = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        
        
        if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
        {
            btnFree.frame = CGRectMake(650, 5, 72, 35);
        }
        else{
            
            btnFree.frame = CGRectMake(900, 5, 72, 35);
        }
        
        [btnFree setBackgroundImage:FreeImage forState:UIControlStateNormal];
        btnFree.tag = indexPath.row;
        [btnFree addTarget:self action:@selector(ViewFree:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btnFree];
        

    
   
      
          
    
               
     
    
    
    
	return cell;
	
    
	
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConfigObject *obj = [filteredArrayofConfigObjects1 objectAtIndex:indexPath.row];
    
    
        
        TrailerPlayer *VP1 = [[TrailerPlayer alloc] initWithNibName:nil bundle:nil];
        //VP1.FreeView = self;
        VP1.VideoFileName =[NSString stringWithString:[obj M3u8]];
        
        [self.navigationController pushViewController:VP1 animated:YES];
      
    
}

-(IBAction)ViewFree:(UIButton*)sender{
    
    int tag = sender.tag;
    
    ConfigObject *obj = [filteredArrayofConfigObjects1 objectAtIndex:tag];
    
    TrailerPlayer *VP1 = [[TrailerPlayer alloc] initWithNibName:nil bundle:nil];
   // VP1.FreeView = self;
    VP1.VideoFileName =[NSString stringWithString:[obj M3u8]];
    
    [self.navigationController pushViewController:VP1 animated:YES];
    
    
    
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
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait  || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        FirstTable.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    else{
        
        FirstTable.frame = CGRectMake(0, 0, SCREEN_HEIGHT + 80, SCREEN_WIDTH);
    }
    
    [self.FirstTable reloadData];
    
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1){
        
        [self reviewPressed];
        
    }
    else {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *ReviewID = [prefs stringForKey:@"Review"];
        NSInteger Counter = [ReviewID integerValue];
        NSInteger CounterPlus = Counter + 1;
        NSString *ID = [NSString stringWithFormat:@"%d",CounterPlus];
        [prefs setObject:ID  forKey:@"Review"];
        [prefs synchronize];
        
    }
    
    
}

- (void)reviewPressed {
    
    //Set user has reviewed.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *ID = @"1";
    [prefs setObject:ID forKey:@"IHaveLeftReview"];
    
    [prefs synchronize];
    
    // Report to  analytics
    NSError *error;
    if (![[GANTracker sharedTracker] trackEvent:@"User Sent to Review Math Videos iPad at app store"
                                         action:@"User Sent to Review Math Videos iPad at app store"
                                          label:@"User Sent to Review Math Videos iPad at app store"
                                          value:1
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    
    
    NSString *str = @"https://userpub.itunes.apple.com/WebObjects/MZUserPublishing.woa/wa/addUserReview?id=522347113&type=Purple+Software";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    mySearchBar1.showsCancelButton = YES;
    mySearchBar1.autocorrectionType = UITextAutocorrectionTypeNo;
    
    //empty previous search results
    [filteredArrayofConfigObjects1 removeAllObjects];
    [self.FirstTable reloadData];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    mySearchBar1.showsCancelButton = NO;
    [self.FirstTable reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    //empty previous search results
    [filteredArrayofConfigObjects1 removeAllObjects];
    NSString *searchString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([searchString isEqualToString:@""] || searchString==nil){
        //show original dataset records
        filteredArrayofConfigObjects1 = [ArrayofConfigObjects1 mutableCopy];
        [self.FirstTable reloadData];
    }
    
    else {
        
        for(ConfigObject *obj in ArrayofConfigObjects1){
            
            NSRange foundInTitle = [[obj.VideoTitle lowercaseString] rangeOfString:[searchString lowercaseString]];
            
            if(foundInTitle.location != NSNotFound){
                
                [filteredArrayofConfigObjects1 addObject:obj];
                
            }else {
                
                NSRange foundInDescrption = [[obj.VideoDescription lowercaseString] rangeOfString:[searchString lowercaseString]];
                
                if(foundInDescrption.location != NSNotFound){
                    
                    [filteredArrayofConfigObjects1 addObject:obj];
                }
            }
        }
        
        [self.FirstTable reloadData];
        
    }
    
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [filteredArrayofConfigObjects1 removeAllObjects];
    filteredArrayofConfigObjects1 = [ArrayofConfigObjects1 mutableCopy];
    [self.FirstTable reloadData];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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


@end

