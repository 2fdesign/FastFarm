//
//  httpInterface.h
//  FastFarmV01
//
//  Created by Rob Beck on 29/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class httpInterface;
@protocol httpInterfaceDelegate <NSObject>
@required
-(void) httpNewData:(NSMutableArray *)data;
-(void) httpFailure:(NSString *)error;
@optional
//-(void) protocolProgressBarUpdate:(float)progress;
//-(void) protocolStatusUpdate:(NSString *)text;
//-(void) protocolFileListing:(NSMutableArray*)fileList fileCounts:(int*)fileCounts numberOfFiles:(int)numberOfFiles;
@end


@interface httpInterface : NSObject <NSURLConnectionDataDelegate>
{
   id <httpInterfaceDelegate> interfaceDelegate;
   //UIView * hostView;
   //UITabBar * hostTabBar;
}
@property (nonatomic,assign) id <httpInterfaceDelegate> interfaceDelegate;
//@property (nonatomic, retain) UIView * hostView;
//@property (nonatomic, retain) UITabBar * hostTabBar;

@property (retain, nonatomic) NSString *encodedLoginData;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSURLConnection *connection;


- (void) logout;
- (id) initWithDelegate:(id<httpInterfaceDelegate>)delegateObject;
- (void) loginWithUser:(NSString *)username password:(NSString *)password;
- (void) getFuelDataForUser:(NSString *)username password:(NSString *)password;
- (void) getWaterDataForUser:(NSString *)username password:(NSString *)password;
- (void) getWeatherDataForUser:(NSString *)username password:(NSString *)password;
- (void) getAlertHistoryForUser:(NSString *)username password:(NSString *)password;
- (void) cancelConnection;
- (void) sendHTTPGetWithURL:(NSString *)urlString;

@end
