//
//  Start.m
//  VideoStreamer
//
//  Created by Joseph caxton-Idowu on 13/03/2012.
//  Copyright (c) 2012 caxtonidowu. All rights reserved.
//

#import "Start.h"
#import "FreeVideosClass.h"
#import "AppDelegate.h"
#import "GANTracker.h"
#import "UnderlinedButton.h"

@implementation Start

@synthesize FirstView,FreeVideos,BtnTransfermysubscription,RentaVideo,Image,ImageView,UsernameText,PasswordText,TextField,ReponseFromServer,PassageFlag,LoginViaLearnersCloud,WhichButton,LoginTitle,TVHeaderImage,TVHeaderImageView,LoginImage,LogoutImage,LoginLogoutbtn;

#define SCREEN_WIDTH  768    
#define SCREEN_HEIGHT 950



- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.navigationItem.title = @"LearnersCloud";
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,185,55)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = self.navigationItem.title;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    
    

    // Header
    
    NSString *HeaderLocation = [[NSBundle mainBundle] pathForResource:@"header_bar" ofType:@"png"];
    UIImage *HeaderBackImage = [[UIImage alloc] initWithContentsOfFile:HeaderLocation];
    [self.navigationController.navigationBar setBackgroundImage:HeaderBackImage forBarMetrics:UIBarMetricsDefault];
    
    NSString *LoginImagePath = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"png"];
    LoginImage = [[UIImage alloc] initWithContentsOfFile:LoginImagePath];
    
    
    
    NSString *LogoutImagePath = [[NSBundle mainBundle] pathForResource:@"logout" ofType:@"png"];
    LogoutImage = [[UIImage alloc] initWithContentsOfFile:LogoutImagePath];
    

    
    // Login and logout does not work
    /* NSString *LoginImagePath = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"png"];
     LoginImage = [[UIImage alloc] initWithContentsOfFile:LoginImagePath];
     
     NSString *LogoutImagePath = [[NSBundle mainBundle] pathForResource:@"logout" ofType:@"png"];
     LogoutImage = [[UIImage alloc] initWithContentsOfFile:LogoutImagePath];
     
     LoginViaLearnersCloud = [[UIBarButtonItem alloc]initWithImage:LoginImage style:UIBarButtonItemStylePlain target:self action:@selector(TransferSubscription:)]; */
    
    
    //LoginViaLearnersCloud = [[UIBarButtonItem alloc] initWithTitle:@"Login" style: UIBarButtonItemStyleBordered target:self action:@selector(TransferSubscription:)];
    //This will only worl on ios 5 up
    //[LoginViaLearnersCloud setTintColor:[UIColor whiteColor]];
    //[LoginViaLearnersCloud setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], UITextAttributeFont,nil] forState:UIControlStateNormal];
    //self.navigationItem.rightBarButtonItem = LoginViaLearnersCloud;
    
    
    // We need to change the color of the Buttons using images... Which means we need to move away from using button.text on decisions. May be next version
    
    
    
    
    NSString *BackImagePath = [[NSBundle mainBundle] pathForResource:@"Background" ofType:@"png"];
	UIImage *BackImage = [[UIImage alloc] initWithContentsOfFile:BackImagePath];
    self.view.backgroundColor = [UIColor colorWithPatternImage:BackImage];
    
    
    
    
    
    CGRect FirstViewframe = CGRectMake(0 ,0, SCREEN_WIDTH, SCREEN_HEIGHT);
	self.FirstView = [[UIView alloc] initWithFrame:FirstViewframe];
    
    LoginTitle = @"";
    
    TVHeaderImage = [UIImage imageNamed:@"TV_chemistry_header.png"];
    TVHeaderImageView = [[UIImageView alloc] initWithImage:TVHeaderImage];
    TVHeaderImageView.frame = CGRectMake(130 ,30, 495, 223);
    [FirstView addSubview:TVHeaderImageView];
    
    
    Image = [UIImage imageNamed:@"hero_chemistry.png"];
    ImageView = [[UIImageView alloc] initWithImage:Image];
    // ImageView.frame = CGRectMake(0 ,0, 540, 950);
    ImageView.frame = CGRectMake(60 ,350, 640, 190);
    [FirstView addSubview:ImageView];
    
    // UIColor *patternColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Cinema_port.png"]];
    
    
    
    [self.view addSubview:FirstView];
    
    
    NSString *StartImageLocation = [[NSBundle mainBundle] pathForResource:@"free_and_paid_videos" ofType:@"png"];
    UIImage *StartImage = [[UIImage alloc] initWithContentsOfFile:StartImageLocation];
    
    FreeVideos = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [FreeVideos setImage:StartImage forState:UIControlStateNormal];
    FreeVideos.frame = CGRectMake(40 ,330, 250, 47);
    
    
    [FreeVideos addTarget:self action:@selector(ViewFreeVideos:) forControlEvents:UIControlEventTouchUpInside];
    
    [FirstView addSubview:FreeVideos];
    
    
    
    BtnTransfermysubscription = [UnderlinedButton buttonWithType:UIButtonTypeCustom];
    BtnTransfermysubscription.frame = CGRectMake(250,730, 300, 64);
    BtnTransfermysubscription.backgroundColor = [UIColor clearColor];
    [BtnTransfermysubscription setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [BtnTransfermysubscription setTitle:@"Transfer my subscription" forState:UIControlStateNormal];
    BtnTransfermysubscription.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size: 24.0];
    BtnTransfermysubscription.tag = 999;
    
    [BtnTransfermysubscription addTarget:self action:@selector(TransferSubscription:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //[FirstView addSubview:BtnTransfermysubscription];
    
    
    
    NSError *error;
    // Report to  analytics
    if (![[GANTracker sharedTracker] trackPageview:@"/StartPage"
                                         withError:&error]) {
        NSLog(@"error in trackPageview");
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if(appDelegate.UserEmail == nil){
        
        self.navigationItem.rightBarButtonItem = nil;
        LoginLogoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [LoginLogoutbtn setBackgroundImage:LoginImage forState:UIControlStateNormal];
        [LoginLogoutbtn addTarget:self action:@selector(TransferSubscription:) forControlEvents:UIControlEventTouchUpInside];
        LoginLogoutbtn.frame=CGRectMake(0.0, 0.0, 60.0, 40.0);
        LoginViaLearnersCloud = [[UIBarButtonItem alloc] initWithCustomView:LoginLogoutbtn];
        LoginViaLearnersCloud.tag  = 1;
        //LoginViaLearnersCloud.title = @"Login";
        self.navigationItem.rightBarButtonItem = LoginViaLearnersCloud;
    }
    
    else {
        
        self.navigationItem.rightBarButtonItem = nil;
        LoginLogoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [LoginLogoutbtn setBackgroundImage:LogoutImage forState:UIControlStateNormal];
        [LoginLogoutbtn addTarget:self action:@selector(LogoutUser:) forControlEvents:UIControlEventTouchUpInside];
        LoginLogoutbtn.frame=CGRectMake(0.0, 0.0, 71.0, 40.0);
        LoginViaLearnersCloud = [[UIBarButtonItem alloc] initWithCustomView:LoginLogoutbtn];
        LoginViaLearnersCloud.tag  = 2;
        self.navigationItem.rightBarButtonItem = LoginViaLearnersCloud;
    }
    
    
    // Check if we are suppose to show login
    if(appDelegate.FlagToLoginOrLogout == [NSNumber numberWithInt:1]){
        
        appDelegate.FlagToLoginOrLogout = [NSNumber numberWithInt:0];
        LoginViaLearnersCloud.tag = 1;
        [self TransferSubscription:LoginViaLearnersCloud];
        
    }
    //Check if we are suppose to logout
    else if (appDelegate.FlagToLoginOrLogout == [NSNumber numberWithInt:2]){
        
        appDelegate.FlagToLoginOrLogout = [NSNumber numberWithInt:0];
        LoginViaLearnersCloud.tag = 2;
        [self LogoutUser:LoginViaLearnersCloud];
        
    }
    
    
    
    
    
}

-(IBAction)ViewFreeVideos:(id)sender{
    
   
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(AddProgress) object:nil];
    [appDelegate.SecondThread start];
        
   
   
    FreeVideosClass *Free_View = [[FreeVideosClass alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:Free_View animated:YES];
    
    
}

-(IBAction)RefreshSubsciptionStatus:(id)sender{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(AddProgress) object:nil];
    [appDelegate.SecondThread start];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *DeviceID = [prefs stringForKey:@"LCUIID"];
    
    [appDelegate SubscriptionStatus:DeviceID];

    
}

-(IBAction)LogoutUser:(id)sender{
    if (LoginViaLearnersCloud.tag == 1) {
        
        
    }
    else {
        
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.AccessAll = FALSE;
        if (appDelegate.UserEmail) {
             appDelegate.UserEmail = nil;
        }
   
   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Logout successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        alertView.tag = 1111;
   
        
    [alertView show];
    
    }
   
}


-(IBAction)TransferSubscription:(id)sender{
    if (LoginViaLearnersCloud.tag == 2) {
         
        
    }
    else {
        
    
    
    WhichButton = (UIButton *)sender;
   // NSLog(@"%i",WhichButton.tag);
    
    NSString *myTitle = @"Enter your details";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:myTitle message:@"\n \n \n \n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    
    UsernameText = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 60.0, 260.0, 30.0)];
    UsernameText.placeholder = @"EmailAddress";
    UsernameText.tag = 1717;
    [UsernameText setBackgroundColor:[UIColor whiteColor]];
    UsernameText.enablesReturnKeyAutomatically = YES;
    [UsernameText setReturnKeyType:UIReturnKeyDone];
    [UsernameText setDelegate:self];
        // Do we have stored UseName if so let add to box
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *StoredUserName = [prefs stringForKey:@"LCUserName"];
        if ([StoredUserName length] > 1) {
            UsernameText.text = StoredUserName;
        }
        

    [alertView addSubview:UsernameText];
    
    // Adds a password Field
   PasswordText = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 95.0, 260.0, 30.0)];
    PasswordText.placeholder = @"Password";
    PasswordText.tag = 1818;
    [PasswordText setSecureTextEntry:YES];
    PasswordText.enablesReturnKeyAutomatically = YES;
    [PasswordText setBackgroundColor:[UIColor whiteColor]];
    [PasswordText setReturnKeyType:UIReturnKeyDone];
    [PasswordText setDelegate:self];   
    [alertView addSubview:PasswordText];
    
    alertView.tag = 1313;
    [alertView show];
    
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1 && actionSheet.tag == 1313){
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
            BOOL notAValidEmail = ![emailTest evaluateWithObject:UsernameText.text];
            
            if (notAValidEmail || [UsernameText.text length] == 0) {
                // Your email is not valid or you have not entered an emailaddress
               NSString *AlertTitle = @"Your email is not valid or you have not entered an email address. Try again?";
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                alertView.tag = 1212;
                [alertView show];
            }
            else if([PasswordText.text length] == 0 ){
                // "password missing
                NSString *AlertTitle = @"You did not enter a password. Try again?";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:AlertTitle message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                alertView.tag = 1212;
                [alertView show];

            }
            else
            {
                // To database with email address,password and UIID;
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                NSString *MyDeviceId = [prefs stringForKey:@"LCUIID"];
                [self SubscriptionTransferServer:MyDeviceId];
                
            }
            
            
        
    }
    else if(buttonIndex == 1 && actionSheet.tag == 1212){
        
        
        [self TransferSubscription:self];
        
    }
    
    else if(actionSheet.tag == 1111) {
        
        self.navigationItem.rightBarButtonItem = nil;
        LoginLogoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [LoginLogoutbtn setBackgroundImage:LoginImage forState:UIControlStateNormal];
        [LoginLogoutbtn addTarget:self action:@selector(TransferSubscription:) forControlEvents:UIControlEventTouchUpInside];
        LoginLogoutbtn.frame=CGRectMake(0.0, 0.0, 60.0, 40.0);
        LoginViaLearnersCloud = [[UIBarButtonItem alloc] initWithCustomView:LoginLogoutbtn];
        LoginViaLearnersCloud.tag  = 1;
        self.navigationItem.rightBarButtonItem = LoginViaLearnersCloud;
        }
    else {
        
        
    }
    
}



- (BOOL)textFieldShouldEndEditing:(UITextView *)textView{
    
    if(textView.tag == 1717){
        if(UsernameText.text.length > 0 ){
            
            
            [UsernameText resignFirstResponder];
            
            
            return true;
        }
        else
        {
           
            [UsernameText resignFirstResponder];
            return true;
        }
        
    }
    
    else if(textView.tag == 1818){
            
        if(PasswordText.text.length > 0 ){
            
           
            [PasswordText resignFirstResponder];
            
            return true;
            }
        else
            {
                
                [PasswordText resignFirstResponder];
                return true;
                
            }
    }
    else
    {
        return false;
    }
}




-(void)SubscriptionTransferServer:(NSString *)DeviceID{
    
    int ButtonNumber = WhichButton.tag;
    if(ReponseFromServer){
        [ReponseFromServer setLength:0];
    }

    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *domain = appDelegate.DomainName;
    
    appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(AddProgress) object:nil];
    [appDelegate.SecondThread start];

    if (ButtonNumber == 999) {
        
    NSString *queryString = [NSString stringWithFormat:@"%@/Services/iOS/VideoSubscription.asmx/UpdateDeviceID",domain];
    NSURL *url = [NSURL URLWithString:queryString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    NSString *FullString = [NSString stringWithFormat:@"DeviceID=%@&email=%@&password=%@&",DeviceID,UsernameText.text,PasswordText.text];
    //NSLog(@"%@",DeviceID);
    NSData* data=[FullString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *contentType = @"application/x-www-form-urlencoded; charset=utf-8";
    [req addValue:contentType forHTTPHeaderField:@"Content-Length"];
    unsigned long long postLength = data.length;
    NSString *contentLength = [NSString stringWithFormat:@"%llu",postLength];
    [req addValue:contentLength forHTTPHeaderField:@"Content-Length"];
    
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:data];
        
    NSURLConnection *conn;
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
        if (!conn) {
            NSLog(@"error while starting the connection");
        } 

        
    }
    
    else {
        
        // This is requesting access via Silverlight credentials
        
        NSString *AppID = @"64";    // 58 is English , 62 means this is maths,  63 is physics  64 is Chemistry
        NSString *queryString = [NSString stringWithFormat:@"%@/Services/iOS/VideoSubscription.asmx/FindSLSubscription2",domain];
        NSURL *url = [NSURL URLWithString:queryString];
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        
         NSString *FullString = [NSString stringWithFormat:@"DeviceID=%@&CourseID=%@&SLemail=%@&SLpassword=%@&",DeviceID,AppID,UsernameText.text,PasswordText.text];
        NSData* data=[FullString dataUsingEncoding:NSUTF8StringEncoding];

        NSString *contentType = @"application/x-www-form-urlencoded; charset=utf-8";
        [req addValue:contentType forHTTPHeaderField:@"Content-Length"];
        unsigned long long postLength = data.length;
        NSString *contentLength = [NSString stringWithFormat:@"%llu",postLength];
        [req addValue:contentLength forHTTPHeaderField:@"Content-Length"];
        
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:data];
        
        NSURLConnection *conn;
        conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
        if (!conn) {
            NSLog(@"error while starting the connection");
        } 


    }
    
       
    
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)someData {
    
    /* Response from server for Transfer subscription:
      0 = Successfully updated
     -1 = Error
     -2 = Error
     -3 = Error
     -4 = User does not exist */
     
    /* Response from Silverlight Authentication
      0 = OK
     -1 = No current subscription
     -2 = Authentication failed
     -3 = AppID not recognised
     -4 = Any other exception*/
    
    if(!ReponseFromServer){
        ReponseFromServer = [[NSMutableData alloc]init ];
    }
    
    
    [ReponseFromServer appendData:someData];
    
    
    
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.SecondThread = [[NSThread alloc]initWithTarget:self selector:@selector(AddProgress) object:nil];
    [appDelegate.SecondThread cancel];
    [self navigationItem].rightBarButtonItem = nil;
    
    NSString *returnedString = [[NSString alloc] initWithData:ReponseFromServer encoding:NSASCIIStringEncoding];
    //NSLog(@"%@",returnedString);
    NSString *Clean1 = [returnedString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString *Clean2 =[Clean1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    NSString *Clean3 =[Clean2 stringByReplacingOccurrencesOfString:@"&lt;/" withString:@"/>"];
    //NSLog(@"%@",Clean3);
    NSData *xmlData = [Clean3 dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    }


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    NSString *CleanString = [string stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([CleanString isEqualToString:@""]){
        
        //Do nothing
       
        return;
        
    }
    
        int Returnid = [string intValue];
        
        //NSLog(@"%i",Returnid);
    
        int ButtonNumber = WhichButton.tag;
    
    if (ButtonNumber == 999) {
        
    
            if (Returnid == 0) {
        
                NSError *error;
                // Report to  analytics
                if (![[GANTracker sharedTracker] trackEvent:@"User transfer subscription to another device"
                                                     action:@"Transfer successful"
                                                      label:@"Transfer successful"
                                                      value:89
                                                  withError:&error]) {
                    NSLog(@"error in trackEvent");
                }
                
                

                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"Update successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag = 4444;
                [self RefreshSubsciptionStatus:self];
                [alertView show];
             }
    
          else if (Returnid < 0){
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"You don't have any running subscription" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alertView.tag = 4444;
            [alertView show];
              
            
             }

     }
    else {
        
          if (Returnid == 0) {
              // User is allowed access to all videos
               NSError *error;
              // Report to  analytics
              if (![[GANTracker sharedTracker] trackEvent:@"Successful Login via credentials"
                                                   action:@"Login to maths successful"
                                                    label:@"Login to maths successful"
                                                    value:79
                                                withError:&error]) {
                  NSLog(@"error in trackEvent");
              }
              //Store UserName for Later Use
              
              NSString *UsernameToStore = UsernameText.text;
              NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
              [userDefaults setObject:UsernameToStore forKey:@"LCUserName"];


              AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
              appDelegate.AccessAll = TRUE;
              appDelegate.UserEmail =  UsernameText.text;
              /*LoginTitle = @"Logout";
               [LoginViaLearnersCloud setImage:nil];
               [LoginViaLearnersCloud setImage:LogoutImage];
               [LoginViaLearnersCloud setTarget:self];
               [LoginViaLearnersCloud setAction:@selector(LogoutUser:)];
               LoginViaLearnersCloud.tag = 2;*/
              

              [self ViewFreeVideos:self];
          }
         else if (Returnid == -1)
             
         {
             NSError *error;
             // Report to  analytics
             if (![[GANTracker sharedTracker] trackEvent:@"User rejected login due to no subscription"
                                                  action:@"No subscription"
                                                   label:@"No subscription"
                                                   value:79
                                               withError:&error]) {
                 NSLog(@"error in trackEvent");
             }

             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"You don't have any running subscription" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             alertView.tag = 4444;
             [alertView show];
             [self viewWillAppear:TRUE];
         
         }
         else {
             
             NSError *error;
             // Report to  analytics
             if (![[GANTracker sharedTracker] trackEvent:@"User login failed"
                                                  action:@"Login to chemistry failed"
                                                   label:@"Login to chemistry failed"
                                                   value:79
                                               withError:&error]) {
                 NSLog(@"error in trackEvent");
             }

             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not successful" message:@"Login failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             alertView.tag = 4444;
             [alertView show];
             [self viewWillAppear:TRUE];
         }
    
    }

       
    
}




- (void)AddProgress{
	
    @autoreleasepool {

	
	UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[activityIndicator stopAnimating];
    [activityIndicator hidesWhenStopped];
	UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	[self navigationItem].rightBarButtonItem = barButton;
	
	[(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView startAnimating];
	
    }
	
}

// For ios 6
-(NSUInteger)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskAll;
    
    
}

// for ios 5


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return YES;
	
	
}



- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
    
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait  || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        TVHeaderImageView.frame = CGRectMake(130 ,30, 495, 223);
        FreeVideos.frame = CGRectMake(85,630, 600, 64);
        BtnTransfermysubscription.frame = CGRectMake(250,730, 300, 64);
        ImageView.frame = CGRectMake(60,350, 640, 190);
        FirstView.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT);
        
        
    }
    else
    {
        TVHeaderImageView.frame = CGRectMake(280 ,30, 495, 223);
        FreeVideos.frame = CGRectMake(220,480, 600, 64);
        BtnTransfermysubscription.frame = CGRectMake(370 ,570, 300, 64);
        ImageView.frame = CGRectMake(200,250, 640, 190);
        FirstView.frame = CGRectMake(0, 0, SCREEN_HEIGHT + 80 , SCREEN_WIDTH);
        
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    //[(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView stopAnimating];
    [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    
    return YES;

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
- (void)dealloc {
// NSLog(@"I am gone dear");

}
- (void)viewDidUnload
{
    [super viewDidUnload];
   
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
