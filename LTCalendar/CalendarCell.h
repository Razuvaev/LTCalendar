//
//  CalendarCell.h
//  LTCalendar
//
//  Created by Pavel Razuvaev on 12.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, cellType) {
    workdays,
    holiday,
    currentDay,
    empty
};

@interface CalendarCell : UICollectionViewCell

#pragma mark - Setters
/**
Setup cell with concrete day and days in month
*/
- (void)setupCellWithDay:(NSInteger)day andNumberOfDays:(NSInteger)daysInMonth;

/**
Setup cell with concrete type
*/
- (void)setupCellType:(cellType)type;

@end
