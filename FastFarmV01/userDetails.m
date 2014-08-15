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
   bool dateEqualsToday = NO, dateEqualsYesterday = NO;
   NSString *hdate;
   
   NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
   [df1 setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
   NSDate *date = [df1 dateFromString:stringDate];
   NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
   
   NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
   NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
   now = [now dateByAddingTimeInterval:-86400];
   NSDateComponents *yesterday = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
   if ([today day] == [otherDay day])
      dateEqualsToday = YES;
   if ([yesterday day] == [otherDay day])
      dateEqualsYesterday = YES;
   
   NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
   [df2 setAMSymbol:@"am"];
   [df2 setPMSymbol:@"pm"];
   
   if (dateEqualsToday)
   {
      [df2 setDateFormat:@"h:mma"];
      hdate = @"Last update today at ";
      NSString *dstr = [df2 stringFromDate:date];
      hdate = [hdate stringByAppendingString:dstr];
   }
   else if (dateEqualsYesterday)
   {
      [df2 setDateFormat:@"h:mma"];
      hdate = @"Last update yesterday at ";
      NSString *dstr = [df2 stringFromDate:date];
      hdate = [hdate stringByAppendingString:dstr];
   }
   else
   {
      [df2 setDateFormat:@"dd MMM yyyy h:mma"];
      hdate = @"Last update ";
      NSString *dstr = [df2 stringFromDate:date];
      hdate = [hdate stringByAppendingString:dstr];
   }
   
   return hdate;
}

-(NSString *) humanDateFromString:(NSString *)stringDate
{
   bool dateEqualsToday = NO, dateEqualsYesterday = NO;
   NSString *hdate;
   
   NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
   [df1 setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
   NSDate *date = [df1 dateFromString:stringDate];
   NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
   
   NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
   NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
   now = [now dateByAddingTimeInterval:-86400];
   NSDateComponents *yesterday = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
   if ([today day] == [otherDay day])
      dateEqualsToday = YES;
   if ([yesterday day] == [otherDay day])
      dateEqualsYesterday = YES;
   
   if (dateEqualsToday)
   {
      hdate = @"Today at";
   }
   else if (dateEqualsYesterday)
   {
      hdate = @"Yesterday at";
   }
   else
   {
      NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
      [df2 setDateFormat:@"dd MMM yyyy"];
      hdate = [df2 stringFromDate:date];
   }
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
