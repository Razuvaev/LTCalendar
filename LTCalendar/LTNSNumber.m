//
//  LTNSNumber.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 19/04/16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "LTNSNumber.h"

@implementation NSNumber (LTNSNumber)

+ (NSNumber *)numberFromDate:(NSDate *)date {
    return [NSNumber numberWithDouble:[date timeIntervalSince1970]];
}

@end
