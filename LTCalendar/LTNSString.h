//
//  LTNSString.h
//  LTCalendar
//
//  Created by Pavel Razuvaev on 30/05/16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LTNSString)

/**
 *  Return month string by integer value
 *
 *  @param number Integer month value
 *
 *  @return String month value
 */
+ (NSString *)returnMonth:(NSInteger)number;

/**
 *  Return day string by integer value
 *
 *  @param number Integer day value
 *
 *  @return String day value
 */
+ (NSString *)returnDayOfTheWeek:(NSInteger)number;

@end
