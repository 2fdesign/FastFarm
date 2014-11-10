//
//  WeatherViewController.m
//  FastFarm
//
//  Created by Rob Beck on 10/11/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "WeatherViewController.h"
#import "userDetails.h"

@interface WeatherViewController ()
{
   NSMutableArray *_objects;
}

@end

@implementation WeatherViewController

- (void)refreshTable
{
   userDetails *user = [userDetails alloc];
   
   //httpInterface *http = [[httpInterface alloc] initWithDelegate:self];
   [_http1 getWeatherDataForUser:[user getUserName] password:[user getPassword]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _http1 = [[httpInterface alloc] initWithDelegate:self];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void) httpNewData:(NSMutableArray *)data
{
   _objects = data;
   [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
   NSLog(@"httpNewData %@", data);
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No weather sites found" message:@"There are no weather sites currently loaded against this user" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
   [alert show];
}

-(void) httpFailure:(NSString *)error
{}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
