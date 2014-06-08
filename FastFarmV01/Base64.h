//
//  Base64.h
//  FastFarmV01
//
//  Created by Rob Beck on 7/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+(NSString *)encode:(NSData *)plainText;

@end
