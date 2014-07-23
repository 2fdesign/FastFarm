//
//  userDetails.h
//  FastFarmV01
//
//  Created by Rob Beck on 29/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userDetails : NSObject

- (void) saveIsUserRemembered:(NSString *)userRemembered;
-(NSString *) isUserRemembered;
- (void) saveUserName:(NSString *)userName password:(NSString *)password;
-(NSString *) getUserName;
-(NSString *) getPassword;
-(NSString *) humanDateAndTimeFromString:(NSString *)stringDate;
-(NSString *) humanDateFromString:(NSString *)stringDate;
-(NSString *) humanTimeFromString:(NSString *)stringDate;



@end
