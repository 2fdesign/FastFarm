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

@interface MasterViewController ()
{
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

//@synthesize tanks;
@synthesize encodedLoginData = _encodedLoginData;
@synthesize refreshControl = _refreshControl;
//@synthesize sessionConfig = _sessionConfig;
//@synthesize dataTask = _dataTask;
//@synthesize defaultSession = _defaultSession;
@synthesize connection = _connection;
@synthesize receivedData = _receivedData;;

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
   
   _refreshControl = [[UIRefreshControl alloc]init];
   [self.tableView addSubview:_refreshControl];
   [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
   
   //UINavigationBar *navBar = self.navigationController.navigationBar;
   //UIImage *image = [UIImage imageNamed:@"yourNavBarBackground.png"];
   //[navBar setBackgroundImage:image];
}

- (void)refreshTable
{
   NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", [self getUserName], [self getPassword]];
   //NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", @"stephen", @"Fm0/k#LV5C?Ikh"];
   NSString *eLD = [Base64 encode:[loginString dataUsingEncoding:NSUTF8StringEncoding]];
   _encodedLoginData = [@"Basic " stringByAppendingFormat:@"%@", eLD];
   [self sendHTTPGetSync];
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
-(NSString *) getUserName
{
   NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   path = [path stringByAppendingPathComponent:@"user.plist"];
   NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
   return [plistDict objectForKey:@"user"];
}
-(NSString *) getPassword
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
      
      [self saveUserName:username.text password:password.text];
      
      NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", username.text, password.text];
      //NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", @"stephen", @"Fm0/k#LV5C?Ikh"];
      
      // employ the Base64 encoding above to encode the authentication tokens
      NSString *eLD = [Base64 encode:[loginString dataUsingEncoding:NSUTF8StringEncoding]];
      _encodedLoginData = [@"Basic " stringByAppendingFormat:@"%@", eLD];
      
      NSLog(@"encodedLoginData: %@",_encodedLoginData);
      
      NSMutableData *data = [[NSMutableData alloc] init];
      _receivedData = data;
      
      [self sendHTTPGetSync];
   }
}

-(void) sendHTTPGet
{
   [_connection cancel];
   NSMutableData *data = [[NSMutableData alloc] init];
   _receivedData = data;
   NSURL *url = [NSURL URLWithString:@"http://api.m2mnz.com/v1.0/tanks/"];
   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
   [request addValue:_encodedLoginData forHTTPHeaderField:@"Authorization"];
   NSURLConnection *newConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
   _connection = newConnection;
   [_connection start];
}

-(void) sendHTTPGetSync
{
   //if there is a connection going on just cancel it.
   [_connection cancel];
   
   //initialize new mutable data
   NSMutableData *data = [[NSMutableData alloc] init];
   _receivedData = data;
   
   //initialize url that is going to be fetched.
   NSURL *url = [NSURL URLWithString:@"http://api.m2mnz.com/v1.0/tanks/"];
   
   //initialize a request from url
   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
   [request addValue:_encodedLoginData forHTTPHeaderField:@"Authorization"];
   NSURLResponse *response = [[NSURLResponse alloc] init];
   
   [_receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
   
   //initialize convert the received data to string with UTF8 encoding		
   NSString *htmlSTR = [[NSString alloc] initWithData:_receivedData encoding:NSUTF8StringEncoding];
   
   NSHTTPURLResponse *getResponse = (NSHTTPURLResponse *)response;
   //NSDictionary *allHeaders = [getResponse allHeaderFields];
   NSInteger getStatusCode = [getResponse statusCode];
   
   if (getStatusCode == 200)
   {
      NSData* json_data = [htmlSTR dataUsingEncoding:NSUTF8StringEncoding];
      NSError *err;
      _objects = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingMutableContainers error:&err];
      if (!_objects)
      {
         NSLog(@"Error parsing JSON: %@", err);
      } else
      {
         for(NSDictionary *item in _objects)
         {
            NSLog(@"Item: %@", item);
         }
      }
      [_refreshControl endRefreshing];
      [_connection cancel];
      [self.tableView reloadData];
   }
   else
   {
      NSLog(@"No Server Found, or server down. Status Code=%ld",(long)getStatusCode);
      [_refreshControl endRefreshing];
   }
}


#pragma mark - NSURLSessionDelegate protocol methods

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   [_receivedData appendData:data];
   NSLog(@"connection received: %@",_receivedData);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
   
   //initialize convert the received data to string with UTF8 encoding
   NSString *htmlSTR = [[NSString alloc] initWithData:_receivedData encoding:NSUTF8StringEncoding];
   NSLog(@"receivedData: %@",self.receivedData);
   NSLog(@"connectionDidFinishLoading %@: " , htmlSTR);
   //initialize a new webviewcontroller
   //WebViewController *controller = [[WebViewController alloc] initWithString:htmlSTR];
   
   //show controller with navigation
   //[self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   //if (cell == nil)  //cell == nil never called in storyboard UI
   //{
   //   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
   //}
   cell.textLabel.text = [[_objects objectAtIndex:indexPath.row]objectForKey:@"TankName"];
   NSNumber *capacity = [[_objects objectAtIndex:indexPath.row]objectForKey:@"Capacity"];
   NSNumber *level = [[_objects objectAtIndex:indexPath.row]objectForKey:@"Level"];
   float c = [capacity floatValue];
   float l = [level floatValue];
   float percent = l/c * 100;
   NSString *str = [[NSString alloc] initWithFormat:@"Tank is %d%% full",(int)(percent)];
   //NSLog(@"%@",str);
   cell.detailTextLabel.text = str;
   //cell.imageView.image = [UIImage imageNamed:@"guage80.png"];
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
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
