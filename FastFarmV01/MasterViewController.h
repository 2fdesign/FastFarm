//
//  MasterViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <NSURLSessionDelegate>
{
   NSArray *tanks;
   NSMutableData *Jdata;
   NSString *encodedLoginData;
}
-(void) sendHTTPGet;
-(void) saveUserName:(NSString *)userName password:(NSString *)password;
- (NSString *) getUserName;
- (NSString *) getPassword;

@end
