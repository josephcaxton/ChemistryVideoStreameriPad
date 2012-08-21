//
//  FreeVideos.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 14/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "FreeVideosClass.h"
#import "AppDelegate.h"
#import "ConfigObject.h"
#import "VideoPlayer.h"
#import "Buy.h"


@implementation FreeVideosClass


@synthesize ArrayofConfigObjects,ProductIDs,ImageObjects,ProductsSubscibedTo,FullSubscription,popover;




- (void)viewDidLoad {
    [super viewDidLoad];
	
	
    
	self.navigationItem.title = @"Free and Subscription Videos";
    
    // Listen to notification
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(RefreshTable:) name:@"ToFreeVideoClass" object:nil];
	 
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
      //NSLog(@"Subscibed products= %@", appDelegate.SubscibedProducts);
    
    // create a toolbar where we can place some buttons
    UIToolbar* toolbar = [[UIToolbar alloc]
                          initWithFrame:CGRectMake(0, 0, 210, 45)];
    [toolbar setBarStyle: UIBarStyleBlack];
    
    
    // create an array for the buttons
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    //create Report Problem Button
    UIBarButtonItem *SendSupportMail = [[UIBarButtonItem alloc] initWithTitle:@"Report Problem" style: UIBarButtonItemStyleBordered target:self action:@selector(ReportProblem:)];
    //self.navigationItem.rightBarButtonItem = SendSupportMail;
    
     [buttons addObject:SendSupportMail];
    
    // create a spacer between the buttons
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                               target:nil
                               action:nil];
    [buttons addObject:spacer];
    
    // Create Share image button
    UIImage *ShareImage = [UIImage imageNamed:@"shareIcon.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 0, 0, ShareImage.size.width, ShareImage.size.height );
    [face setImage:ShareImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(share:)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ShareButton = [[UIBarButtonItem alloc] initWithCustomView:face];
    
     [buttons addObject:ShareButton];
    
    // put the buttons in the toolbar
    [toolbar setItems:buttons animated:NO];
    
    // place the toolbar into the navigation bar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithCustomView:toolbar];
    
    // Get Subscibed products from delegate
    /*if([appDelegate.SubscibedProducts count] > 0){
        
        ProductsSubscibedTo = [[NSMutableArray alloc] initWithArray:appDelegate.SubscibedProducts]; 
        
    }*/
    
    // If User is fully subscibed by logging in or by identifying via DeviceID
    FullSubscription = appDelegate.AccessAll;
    
    // Put all the images into an array
    
    ImageObjects = [[NSMutableArray alloc] init];
    int i;
    NSString *loadString;
    
    for(i = 0; i < 70; i++) {
        loadString = [NSString stringWithFormat:@"%d", i + 1]; 
        [ImageObjects addObject:[UIImage imageNamed:loadString]];
        
    }
	
    
    
	// Copy or Update the VideoConfig File;
   
    NSString *domain = appDelegate.DomainName;
    NSString *queryFeed = [NSString stringWithFormat:@"%@/iosStream/Chemistry/ChemistryConfig.xml",domain]; 
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"ChemistryConfig.xml"];
    
         
   
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
    
    
    
    ArrayofConfigObjects = [[NSMutableArray alloc] init];
    
   
        
    }
    else
    {
    
        [self Alertfailedconnection];
    
    }
	
    [appDelegate.SecondThread cancel];
        
}
- (void)viewWillAppear:(BOOL)animated {

   AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //[self AdjustProductSubscribedTo];
    
    // Get Subscibed Status from delegate or Don't check if user is successfully logged in
    if(appDelegate.AccessAll == TRUE){
        
        // NSLog(@"%@",appDelegate.AccessAll);
    }
    else{
        
        // NSLog(@"%@",appDelegate.AccessAll);
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *DeviceID = [prefs stringForKey:@"LCUIID"];
        
        [appDelegate SubscriptionStatus: DeviceID];
        
        FullSubscription = appDelegate.AccessAll;
        
    }
    
        
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"ChemistryConfig.xml"]; 
   [self MyParser:Dir];
    
    
}

/*-(void)AdjustProductSubscribedTo{

   AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if([appDelegate.TempSubscibedProducts count] > 0){
        
        if([ProductsSubscibedTo count] > 0){
            
            [ProductsSubscibedTo removeAllObjects];
            for(int i = 0; i < [appDelegate.TempSubscibedProducts count]; i++){
                
                [ProductsSubscibedTo addObject:[appDelegate.TempSubscibedProducts objectAtIndex:i]]; 
            }
        }
        else{
            
            
            ProductsSubscibedTo = [[NSMutableArray alloc] initWithArray:appDelegate.TempSubscibedProducts]; 
            
        }
        
        
    }

    
}*/


-(void)RefreshTable:(NSNotification *)note{
    
    
   [self performSelectorOnMainThread:@selector(RefeshTable) withObject:nil waitUntilDone:NO];
}

-(void)RefeshTable{
    
   /* UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	[self navigationItem].rightBarButtonItem = barButton;
    [(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView startAnimating];*/
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //NSLog(@"%@", appDelegate.TempSubscibedProducts);
   
    NSString *Dir = [appDelegate.applicationDocumentsDirectory stringByAppendingPathComponent:@"ChemistryConfig.xml"];
    //[self AdjustProductSubscribedTo];
     FullSubscription = appDelegate.AccessAll;
     //NSLog(@"%@", appDelegate.TempSubscibedProducts);
     //NSLog(@"%@",  ProductsSubscibedTo);
    [ArrayofConfigObjects removeAllObjects];
    [self MyParser:Dir];
    [self.tableView reloadData];
    
    //[activityIndicator stopAnimating];
    //[activityIndicator hidesWhenStopped];
    
}


-(BOOL)ShouldIDownloadOrNot:(NSString*)urllPath:(NSString*)LocalFileLocation{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
   BOOL ReturnVal =  [appDelegate downloadFileIfUpdated:urllPath:LocalFileLocation];
    
    return ReturnVal;
   
    
    
    
}
-(void)GetConfigFileFromServeWriteToPath:(NSString*)Path{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *domain = appDelegate.DomainName;
    NSString *queryFeed = [NSString stringWithFormat:@"%@/iosStream/Chemistry/ChemistryConfig.xml", domain];
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
        obj.M3u8 = M3u8;
        
        if ([Sociallyfree isEqualToString: @"1"]){
            
            obj.SociallyFree = YES;
        }
        else
        {
            obj.SociallyFree = NO; 
        }

        
        obj.ProductID = @"ChemistryiPad";
        //NSLog(@"Product is: %@",obj.ProductID);
       /* for (int i = 0; i < ProductsSubscibedTo.count; i++) {
            
            if ([obj.ProductID isEqualToString:[ProductsSubscibedTo objectAtIndex:i]]) {
                
                //NSLog(@"Product is: %@",obj.ProductID);
                obj.Subcribed = YES;
            }
        }*/
        
        [ArrayofConfigObjects addObject:obj];
        
        
       // NSLog(@"Title in my array is: %@",obj.VideoTitle);
				
		

	}
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	
	int	count = 1;
	
	return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    NSInteger numberOfRows =[ArrayofConfigObjects count];
	
    return numberOfRows;
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    ConfigObject *obj = [ArrayofConfigObjects objectAtIndex:indexPath.row];
    //Change how image is loaded
    //NSString *PicLocation = [[NSString alloc] initWithFormat:@"%@",[obj Thumbnail]];
    //UIImage* theImage = [UIImage imageNamed:PicLocation];
    UIImage* theImage =[ImageObjects objectAtIndex:indexPath.row];
    cell.imageView.image = theImage;
    
    cell.textLabel.text = [obj VideoTitle];
    
    // Is it free?
    if ([obj Free] == YES){
       
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         NSString* descriptiontxt = [obj VideoDescription];
         NSString* FullDesciption = [descriptiontxt stringByAppendingString:@" - Free view"];
        cell.detailTextLabel.text =FullDesciption;
         cell.detailTextLabel.textColor = [UIColor blueColor];
        
    }
    
    else if ([obj SociallyFree] == YES){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString* descriptiontxt = [obj VideoDescription];
         NSString* FullDesciption = @"";
        // Check if we are in full subscription if so Change text to paid
        if(FullSubscription == TRUE){
            FullDesciption = [descriptiontxt stringByAppendingString:@" - Subscription Paid"];
        }
        else {
            FullDesciption = [descriptiontxt stringByAppendingString:@" - Free gift if you share"];
        }

       
        cell.detailTextLabel.text =FullDesciption;
        cell.detailTextLabel.textColor = [UIColor blueColor];
        
        
    }

    // Is user Subscribed?
    else if([obj Subcribed] == YES || FullSubscription == TRUE){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString* descriptiontxt = [obj VideoDescription];
        NSString* FullDesciption = [descriptiontxt stringByAppendingString:@" - Subscription Paid"];
        cell.detailTextLabel.text =FullDesciption;
        cell.detailTextLabel.textColor = [UIColor blueColor];
        
    }
    // Sorry mate you have to buy
    else
    {
        
         cell.accessoryType =  UITableViewCellAccessoryNone;
          NSString* descriptiontxt = [obj VideoDescription];
        NSString* FullDesciption = [descriptiontxt stringByAppendingString:@" - Subscribe"];
         cell.detailTextLabel.text = FullDesciption;
         cell.detailTextLabel.textColor = [UIColor redColor];
    }
   
    
    
	
	
    return cell;
	
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ConfigObject *obj = [ArrayofConfigObjects objectAtIndex:indexPath.row];
    
    if ([obj Free] == YES || [obj Subcribed] == YES || FullSubscription == TRUE) {
        
    VideoPlayer *VP1 = [[VideoPlayer alloc] initWithNibName:nil bundle:nil];
    VP1.FreeView = self;
    VP1.VideoFileName =[NSString stringWithString:[obj M3u8]];
    [self.navigationController pushViewController:VP1 animated:YES];
    }
    
    else if ([obj SociallyFree] == YES){
        // Have you shared if so view video
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if([[prefs objectForKey:@"AddOneFreeChemistry"] isEqualToString:@"1"]){
            
            VideoPlayer *VP1 = [[VideoPlayer alloc] initWithNibName:nil bundle:nil];
            VP1.FreeView = self;
            VP1.VideoFileName =[NSString stringWithString:[obj M3u8]];
            [self.navigationController pushViewController:VP1 animated:YES];
            
        }
        
        else {
            
            UIAlertView *alertView = [[UIAlertView alloc] 
                                      initWithTitle:@"Sorry"                                                             
                                      message:@"You can only view this video for free if you share"                                                          
                                      delegate:self                                              
                                      cancelButtonTitle:@"OK"                                                   
                                      otherButtonTitles:nil];
            [alertView show];
            
            return;
            
        }
        
    }

    else{
        // To store for buying
        //NSLog(@"my product id is %@",[obj ProductID]);
               
        [self ConfigureProductList:[obj ProductID]];
        
        Buy *buyer = [[Buy alloc ]initWithNibName:nil bundle:nil];
        buyer.ProductsToIstore = ProductIDs;
        //NSLog(@"%@",ProductIDs);
        [self.navigationController pushViewController:buyer animated:YES];
        
        
        
    }
         


}

-(void)ConfigureProductList:(NSString *)ProductID{
    
    ProductIDs = [[NSMutableArray alloc] init];
    
    NSString* OneMonth = [ProductID stringByAppendingString:@"1month"];
    [ProductIDs addObject:OneMonth];
    
    NSString* ThreeMonths = [ProductID stringByAppendingString:@"3months"];
    [ProductIDs addObject:ThreeMonths];
    
    NSString* SixMonths = [ProductID stringByAppendingString:@"6months"];
    [ProductIDs addObject:SixMonths];
    
    NSString* NineMonths = [ProductID stringByAppendingString:@"9months"];
    [ProductIDs addObject:NineMonths];
    
    NSString* TwelveMonths = [ProductID stringByAppendingString:@"12months"];
    [ProductIDs addObject:TwelveMonths]; 
    


    
    
    
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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
        
        [SendMailcontroller setMessageBody:[NSString stringWithFormat:@"Add message here "] isHTML:NO];
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

- (IBAction)share:(id)sender{
    UIButton *button = (UIButton*)sender;
    
    PopUpTableviewViewController *tableViewController = [[PopUpTableviewViewController alloc] initWithStyle:UITableViewStylePlain];
    
    
    popover = [[UIPopoverController alloc] initWithContentViewController:tableViewController];
    tableViewController.m_popover = popover;
    [popover setPopoverContentSize:CGSizeMake(420, 380) animated:YES];
    
    [popover presentPopoverFromRect:CGRectMake(button.frame.size.width / 2, button.frame.size.height / 1, 1, 1) inView:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
    
    if(popover){
        
        [popover dismissPopoverAnimated:YES];
        [popover.delegate popoverControllerDidDismissPopover:self.popover];
        
    }
    
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
    if (![[GANTracker sharedTracker] trackEvent:@"User Sent to Review Chemistry Videos iPad at app store"
                                         action:@"User Sent to Review Chemistry Videos iPad at app store"
                                          label:@"User Sent to Review Chemistry Videos iPad at app store"
                                          value:1
                                      withError:&error]) {
        NSLog(@"error in trackEvent");
    }
    
    
    NSString *str = @"https://userpub.itunes.apple.com/WebObjects/MZUserPublishing.woa/wa/addUserReview?id=554591114&type=Purple+Software"; 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
