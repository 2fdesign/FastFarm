//
//  httpInterface.m
//  FastFarmV01
//
//  Created by Rob Beck on 29/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "httpInterface.h"

@implementation httpInterface
{
   NSMutableArray *_objects;
}
@synthesize interfaceDelegate = _interfaceDelegate;
@synthesize encodedLoginData = _encodedLoginData;
@synthesize connection = _connection;
@synthesize receivedData = _receivedData;

static httpInterface *sharedInstance = nil;
NSString *errorStr;
NSInteger statusCode;

enum httpMessageCodes {LOGIN = 1,
   LOGOUT,
   ALERT,
   GETUSER};
uint16_t httpMessage;

- (httpInterface *) init
{
	if (!(self = [super init])) return self;
   return self;
}

- (httpInterface *) initWithDelegate:(id<httpInterfaceDelegate>)delegateObject
{
	self = [super init];
   if (self)
   {
      _interfaceDelegate = delegateObject;
   }
	return self;
}

- (void) loginWithUser:(NSString *)username password:(NSString *)password
{
}

- (void) logout
{
}

- (void) getFuelDataForUser:(NSString *)username password:(NSString *)password
{
   NSMutableArray *data = [[NSMutableArray alloc] init];
   _objects = data;
   NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", username, password];
   NSData *plainData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
   NSString *base64String = [[NSString alloc]init];
   if ([base64String respondsToSelector:@selector(base64EncodedStringWithOptions:)])
   {
      base64String = [plainData base64EncodedStringWithOptions:0];  // iOS 7+
   }
   else
   {
      base64String = [plainData base64Encoding];                              // pre iOS7
   }
   _encodedLoginData = [@"Basic " stringByAppendingFormat:@"%@", base64String];
   
   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   [self sendHTTPGet];
}

-(void) sendHTTPGet
{
   [_connection cancel];
   NSMutableData *data = [[NSMutableData alloc] init];
   _receivedData = data;
   statusCode = 0;
   NSURL *url = [NSURL URLWithString:@"http://api.m2mnz.com/v1.1/tanks/"];
   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
   [request addValue:_encodedLoginData forHTTPHeaderField:@"Authorization"];
   NSURLConnection *newConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
   _connection = newConnection;
   [_connection start];
}

- (void) cancelConnection
{
   [_connection cancel];
}

#pragma mark - NSURLSessionDelegate protocol methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to fastfarm" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
   [errorView show];
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   [_receivedData appendData:data];
   //NSLog(@"connection received: %@",data);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   // A response has been received, this is where we initialize the instance var you created
   // so that we can append data to it in the didReceiveData method
   // Furthermore, this method is called each time there is a redirect so reinitializing it
   // also serves to clear it
   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
   NSDictionary *allHeaders = [httpResponse allHeaderFields];
   NSLog(@"allHeaders %@",allHeaders);
   statusCode = [httpResponse statusCode];
   NSLog(@"StatusCode: %d",statusCode);
   if ((statusCode == 200) || (statusCode == 201))
   {
   }
   else
   {
   }
   //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   NSString *htmlSTR = [[NSString alloc] initWithData:_receivedData encoding:NSUTF8StringEncoding];
   //NSLog(@"receivedData: %@",_receivedData);
   NSLog(@"connectionDidFinishLoading %@: " , htmlSTR);
   
   
   if (statusCode == 200)
   {
      NSData* json_data = [htmlSTR dataUsingEncoding:NSUTF8StringEncoding];
      NSError *err;
      _objects = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingMutableContainers error:&err];
      NSLog(@"Objects as mutable data: %@",_objects);
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
      if (_interfaceDelegate != nil)
      {
         [[self interfaceDelegate] httpNewData:_objects];
      }
   }
   else
   {
      NSLog(@"No Server Found, or server down. Status Code=%ld",(long)statusCode);
   }
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
}

@end
