//
//  Alerts_TableViewController.m
//  FastFarmV01
//
//  Created by Rob Beck on 23/07/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "Alerts_TableViewController.h"
#import "httpInterface.h"
#import "userDetails.h"

@interface Alerts_TableViewController ()
{
   NSMutableArray *_objects;
}
@end

@implementation Alerts_TableViewController

@synthesize refreshControl = _refreshControl;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
   
    _refreshControl = [[UIRefreshControl alloc]init];
    //_refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.tableView addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
   
    UIEdgeInsets inset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.contentInset = inset;
   
    _http1 = [[httpInterface alloc] initWithDelegate:self];
}

- (void)refreshTable
{
   userDetails *user = [userDetails alloc];
   
   //httpInterface *http = [[httpInterface alloc] initWithDelegate:self];
   [_http1 getAlertHistoryForUser:[user getUserName] password:[user getPassword]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)awakeFromNib
{
   [super awakeFromNib];
   UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   self.navigationItem.titleView = img;
}

#pragma mark - httpInterfaceDelegate Protocol methods

-(void) httpNewData:(NSMutableArray *)data
{
   _objects = data;
   [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
   NSLog(@"httpNewAlertData %@", data);
   [_refreshControl endRefreshing];
}

-(void) httpFailure:(NSString *)error
{
   
}


#pragma mark - Table view data source

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
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
   NSString *tankName = [NSString stringWithFormat:@"%@",[[_objects objectAtIndex:indexPath.row]objectForKey:@"TankName"]];
   NSString *alertDesc = [NSString stringWithFormat:@"%@",[[_objects objectAtIndex:indexPath.row]objectForKey:@"AlertDesc"]];
   NSString *dateStr = [NSString stringWithFormat:@"%@",[[_objects objectAtIndex:indexPath.row]objectForKey:@"AlertDateTime"]];
   userDetails *user = [userDetails alloc];
   NSString *readableDateStr = [NSString stringWithFormat:@"%@ %@",[user humanDateFromString:dateStr],[user humanTimeFromString:dateStr]];
   
   cell.textLabel.text = tankName;
   cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",alertDesc,readableDateStr];
   
   return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
