//
//  LTNSString.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 30/05/16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "LTNSString.h"

@implementation NSString (LTNSString)

+ (NSString *)returnMonth:(NSInteger)number {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    dateComponents.month = number;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"MMMM"];
    
    NSString *month = [df stringFromDate:builtDate];
    if ([[[NSLocale currentLocale] localeIdentifier] isEqualToString:@"ru_RU"]) {
        if ([month isEqualToString:@"мая"]) {
            month = @"май";
        }
        
        NSString *lastChar = [month substringFromIndex:[month length] - 1];
        if ([lastChar isEqualToString:@"я"]) {
            month = [month stringByReplacingCharactersInRange:NSMakeRange(month.length - 1, 1) withString:@"ь"];
        }
        if ([lastChar isEqualToString:@"а"]) {
            month = [month substringToIndex:[month length] - 1];
        }
    }
    return [month capitalizedString];
}

+ (NSString *)returnDayOfTheWeek:(NSInteger)number {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponents.day = number;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"E"];
    
    return [df stringFromDate:builtDate];
}

@end
