//
//  LTNSDate.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 19/04/16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "LTNSDate.h"

@implementation NSDate (LTNSDate)

+ (NSDate *)zeroDateFromDate:(NSDate *)date {
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate:date];
    
    NSDate *dateToReturn = [NSDate dateWithTimeInterval:seconds sinceDate:date];
    
    return dateToReturn;
}

@end
