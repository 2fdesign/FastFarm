//
//  MasterViewController.m
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Base64.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   //self.navigationItem.leftBarButtonItem = self.editButtonItem;

   UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(login:)];
   self.navigationItem.rightBarButtonItem = addButton;
   
   //UINavigationBar *navBar = self.navigationController.navigationBar;
   //UIImage *image = [UIImage imageNamed:@"yourNavBarBackground.png"];
   //[navBar setBackgroundImage:image];
   
   //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   //NSURL *url = [NSURL URLWithString:@"http://www.airimage.co.nz/jd.txt"];
   //NSURLRequest *request = [NSURLRequest requestWithURL:url];
   //[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   Jdata = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
   [Jdata appendData:theData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   NSString *strData = [[NSString alloc]initWithData:Jdata encoding:NSUTF8StringEncoding];
   NSLog(@"%@", strData);
   NSError *err;
   tanks = [NSJSONSerialization JSONObjectWithData:Jdata options:NSJSONReadingMutableContainers error:&err];
   if (!tanks)
   {
      NSLog(@"Error parsing JSON: %@", err);
   } else
   {
      for(NSDictionary *item in tanks)
      {
         NSLog(@"Item: %@", item);
      }
   }
   [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The download could not complete" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
   [errorView show];
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveUserName:(NSString *)userName password:(NSString *)password
{
   NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   path = [path stringByAppendingPathComponent:@"user.plist"];
   NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
   [plistDict setValue:userName forKey: @"user"];
   [plistDict setValue:password forKey: @"password"];
   [plistDict writeToFile:path atomically:YES];
}
- (NSString *) getUserName
{
   NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   path = [path stringByAppendingPathComponent:@"user.plist"];
   NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
   return [plistDict objectForKey:@"user"];
}
- (NSString *) getPassword
{
   NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   path = [path stringByAppendingPathComponent:@"user.plist"];
   NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
   return [plistDict objectForKey:@"password"];
}

- (void)login:(id)sender
{
   UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Login" message:@"Enter Username & Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
   alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
   [alert addButtonWithTitle:@"Login"];
   [alert textFieldAtIndex:0].text = [self getUserName];//@"stephen";
   [alert textFieldAtIndex:1].text = [self getPassword];//@"Fm0/k#LV5C?Ikh";
   [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
   if (buttonIndex == 1)
   {
      UITextField *username = [alertView textFieldAtIndex:0];
      NSLog(@"username: %@", username.text);
      
      UITextField *password = [alertView textFieldAtIndex:1];
      NSLog(@"password: %@", password.text);
      
      //username.text = @"stephen";
      //password.text = @"Fm0/k#LV5C?Ikh";
      [self saveUserName:username.text password:password.text];
      
      NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", username.text, password.text];
      
      // employ the Base64 encoding above to encode the authentication tokens
      NSString *eLD = [Base64 encode:[loginString dataUsingEncoding:NSUTF8StringEncoding]];
      encodedLoginData = [@"Basic " stringByAppendingFormat:@"%@", eLD];
      
      NSLog(@"encodedLoginData: %@",encodedLoginData);
      
      [self sendHTTPGet];
   }
}

-(void) sendHTTPGet
{
   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
   
   sessionConfig.allowsCellularAccess = YES;
   [sessionConfig setHTTPAdditionalHeaders: @{@"Accept": @"application/json"}];
   [sessionConfig setHTTPAdditionalHeaders: @{@"Authorization": encodedLoginData}];
   
   // 3
   sessionConfig.timeoutIntervalForRequest = 30.0;
   sessionConfig.timeoutIntervalForResource = 60.0;
   sessionConfig.HTTPMaximumConnectionsPerHost = 1;
   
   NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: sessionConfig delegate: self delegateQueue: [NSOperationQueue mainQueue]];
   //NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
   NSURL * url = [NSURL URLWithString:@"http://api.m2mnz.com/v1.0/tanks/"];
   
   NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
   {
      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
      if(error == nil)
      {
         //NSLog(@"HTTP Response: %@", response);
         NSHTTPURLResponse *getResponse = (NSHTTPURLResponse *)response;
         //NSDictionary *allHeaders = [getResponse allHeaderFields];
         NSInteger getStatusCode = [getResponse statusCode];
         //NSLog(@"HTTPResponce Status Code: %d",getStatusCode);
         if (getStatusCode == 200)
         {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"Data = %@",text);
            NSData* json_data = [text dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            tanks = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingMutableContainers error:&err];
            if (!tanks)
            {
               NSLog(@"Error parsing JSON: %@", err);
            } else
            {
               for(NSDictionary *item in tanks)
               {
                  NSLog(@"Item: %@", item);
               }
            }
            [self.tableView reloadData];
         }
         else
         {
            NSLog(@"No Server Found, or server down. Status Code=%ld",(long)getStatusCode);
         }
      }
      else
      {
         NSLog(@"HTTP Get Error: %@",error);
         NSLog(@"HTTP Response: %@", response);
      }
   }];
   
   [dataTask resume];
   
}

#pragma mark - NSURLSessionDelegate protocol methods

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
{
   NSLog(@"session didBecomeInvalidWithError: %@",error);
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [tanks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   if (cell == nil)
   {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
   }
   cell.textLabel.text = @"Hello";//[[tanks objectAtIndex:indexPath.row]objectForKey:@"\"name\""];
   //NSNumber *capacity = [[tanks objectAtIndex:indexPath.row]objectForKey:@"\"capacity\""];
   //NSNumber *level = [[tanks objectAtIndex:indexPath.row]objectForKey:@"\"level\""];
   //float c = [capacity floatValue];
   //float l = [level floatValue];
   //float percent = l/c * 100;
   //NSString *str = [[NSString alloc] initWithFormat:@"Tank is %d%% full", (int)(percent)];
   //cell.detailTextLabel.text = str;
   cell.imageView.image = [UIImage imageNamed:@"guage80.png"];
   return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
