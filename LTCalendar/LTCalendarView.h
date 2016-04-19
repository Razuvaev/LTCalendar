//
//  LTCalendarView.h
//  LTCalendar
//
//  Created by Pavel Razuvaev on 13.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTNSDate.h"
#import "LTNSNumber.h"

@interface LTCalendarView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *CV;
@property (nonatomic) NSInteger numberOfSections;

/**
Return start day of concrete month. Using to find indexPath for the first day in month.
*/
- (NSInteger)returnStartIndexForMonth:(NSInteger)month;

/**
Return number of days in concrete month.
*/
- (NSInteger)returnNumberOfDaysInMonth:(NSInteger)month;

/**
Return current day. Using to find indexPath with concrete day.
*/
- (NSInteger)returnCurrentDay;

/**
Return current month.
*/
- (NSInteger)returnCurrentMonth;

/**
Return start month. From this month the calendar will be started.
*/
- (NSInteger)returnStartMonth;

/**
Return IndexPath for concrete date (timestamp)
*/
- (NSIndexPath *)returnIndexPathByTimeStamp:(NSNumber *)timeStamp;

/**
Return date (timestamp) by IndexPath
*/
- (NSNumber *)returnDateByIndexPath:(NSIndexPath *)indexPath;

/**
Check if day is weekend
*/
- (BOOL)isWeekEnd:(NSIndexPath *)indexPath;

@end
