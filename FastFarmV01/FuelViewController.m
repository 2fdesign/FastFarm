//
//  MasterViewController.m
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "FuelViewController.h"
#import "DetailViewController.h"
#import "httpInterface.h"
#import "userDetails.h"

@interface FuelViewController ()
{
    NSMutableArray *_objects;
}
@end

@implementation FuelViewController

@synthesize refreshControl = _refreshControl;

- (void)awakeFromNib
{
    //[super awakeFromNib];
    //UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
    //self.navigationItem.titleView = img;
}

-(void)viewDidAppear:(BOOL)animated
{
   [self refreshTable];
   [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
   [_http1 cancelConnection];
   [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   
	// Do any additional setup after loading the view, typically from a nib.
   //self.navigationItem.leftBarButtonItem = self.editButtonItem;
   
   //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(login:)];
   //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
   //self.navigationItem.rightBarButtonItem = addButton;
   
   _refreshControl = [[UIRefreshControl alloc]init];
   //_refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
   [self.tableView addSubview:_refreshControl];
   
   [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
   
   _http1 = [[httpInterface alloc] initWithDelegate:self];
   
      
   //UINavigationBar *navBar = self.navigationController.navigationBar;
   //UIImage *image = [UIImage imageNamed:@"yourNavBarBackground.png"];
   //[navBar setBackgroundImage:image];
}

- (void)refreshTable
{
   userDetails *user = [userDetails alloc];
   
   //httpInterface *http = [[httpInterface alloc] initWithDelegate:self];
   [_http1 getFuelDataForUser:[user getUserName] password:[user getPassword]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*- (void)login:(id)sender
{
   userDetails *user = [userDetails alloc];
   UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Login" message:@"Enter Username & Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
   alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
   [alert addButtonWithTitle:@"Login"];
   [alert textFieldAtIndex:0].text = [user getUserName];//@"stephen";
   [alert textFieldAtIndex:1].text = [user getPassword];//@"Fm0/k#LV5C?Ikh";
   [alert show];
}*/

/*- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
   if (buttonIndex == 1)
   {
      UITextField *username = [alertView textFieldAtIndex:0];
      NSLog(@"username: %@", username.text);
      
      UITextField *password = [alertView textFieldAtIndex:1];
      NSLog(@"password: %@", password.text);
      
      userDetails *user = [userDetails alloc];
      [user saveUserName:username.text password:password.text];
      
      httpInterface *sharedInterface = [httpInterface sharedInstanceWithDelegate:self];
      [sharedInterface getFuelDataForUser:username.text password:password.text];
      
   }
}*/


#pragma mark - httpInterfaceDelegate Protocol methods

-(void) httpNewData:(NSMutableArray *)data
{
   _objects = data;
   [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
   NSLog(@"httpNewData %@", data);
   [_refreshControl endRefreshing];
}

-(void) httpFailure:(NSString *)error
{
   
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
   static NSString *CellIdentifier = @"FuelTableCell";
   FuelViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
   if (cell == nil)
   {
      cell = [[FuelViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   }
   
   NSNumber *capacity = [[_objects objectAtIndex:indexPath.row]objectForKey:@"Capacity"];
   NSNumber *level = [[_objects objectAtIndex:indexPath.row]objectForKey:@"Level"];
   float c = [capacity floatValue];
   float l = [level floatValue];
   float percent = l/c * 100;
   
   NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
   [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
   [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
   NSString *strLevel = [numberFormatter stringFromNumber: [NSNumber numberWithInteger: (int)(l)]];
   
   NSString *strPercent = [[NSString alloc] initWithFormat:@"%d",(int)(percent)];
   
   
   cell.labelTitle.text = [[_objects objectAtIndex:indexPath.row]objectForKey:@"TankName"];
   
   userDetails *user = [userDetails alloc];
   cell.labelupdateTime.text = [user humanDateAndTimeFromString:[[_objects objectAtIndex:indexPath.row]objectForKey:@"DateTime"]];
   
   cell.labelLitres.text = strLevel;
   cell.labelPercentage.text = strPercent;
   
   NSString *alertStr = [NSString stringWithFormat:@"%@",[[_objects objectAtIndex:indexPath.row]objectForKey:@"IsActiveAlerts"]];
   if ([alertStr isEqualToString:@"1"])
   {
      cell.labelAlert.hidden = false;
      cell.imageAlert.hidden = false;
   }
   else
   {
      cell.labelAlert.hidden = true;
      cell.imageAlert.hidden = true;
   }
   return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 100;
}*/

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
