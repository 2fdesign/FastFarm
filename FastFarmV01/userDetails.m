//
//  userDetails.m
//  FastFarmV01
//
//  Created by Rob Beck on 29/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "userDetails.h"

@implementation userDetails

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

-(NSString *) isUserRemembered
{
   NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   path = [path stringByAppendingPathComponent:@"user.plist"];
   NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
   return [plistDict objectForKey:@"remember"];
}

- (void) saveIsUserRemembered:(NSString *)userRemembered
{
   NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   path = [path stringByAppendingPathComponent:@"user.plist"];
   NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
   [plistDict setValue:userRemembered forKey: @"remember"];
   [plistDict writeToFile:path atomically:YES];
}

-(NSString *) humanDateAndTimeFromString:(NSString *)stringDate
{
   //NSArray *dateItems = [stringDate componentsSeparatedByString:@"T"];
   //NSString *dateString = [dateItems objectAtIndex:0];
   //NSString *timeString = [dateItems objectAtIndex:1];
   
   NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
   [df1 setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
   NSDate *date = [df1 dateFromString:stringDate];
   
   NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
   [df2 setAMSymbol:@"am"];
   [df2 setPMSymbol:@"pm"];
   [df2 setDateFormat:@"dd MMM yyyy h:mma"];
   
   NSString *hdate = [df2 stringFromDate:date];
   
   
   return hdate;
}

-(NSString *) humanDateFromString:(NSString *)stringDate
{
   //NSArray *dateItems = [stringDate componentsSeparatedByString:@"T"];
   //NSString *dateString = [dateItems objectAtIndex:0];
   //NSString *timeString = [dateItems objectAtIndex:1];
   
   NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
   [df1 setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
   NSDate *date = [df1 dateFromString:stringDate];
   
   NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
   [df2 setAMSymbol:@"am"];
   [df2 setPMSymbol:@"pm"];
   [df2 setDateFormat:@"dd MMM yyyy"];
   
   NSString *hdate = [df2 stringFromDate:date];
   
   
   return hdate;
}

-(NSString *) humanTimeFromString:(NSString *)stringDate
{
   //NSArray *dateItems = [stringDate componentsSeparatedByString:@"T"];
   //NSString *dateString = [dateItems objectAtIndex:0];
   //NSString *timeString = [dateItems objectAtIndex:1];
   
   NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
   [df1 setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
   NSDate *date = [df1 dateFromString:stringDate];
   
   NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
   [df2 setAMSymbol:@"am"];
   [df2 setPMSymbol:@"pm"];
   [df2 setDateFormat:@"h:mma"];
   
   NSString *hdate = [df2 stringFromDate:date];
   
   
   return hdate;
}

@end
