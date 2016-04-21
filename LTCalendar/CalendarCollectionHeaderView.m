//
//  CalendarCollectionHeaderView.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 12.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "CalendarCollectionHeaderView.h"

static const CGFloat monthLeftMargin = 12;
static const CGFloat monthTopMargin = 10;

@interface CalendarCollectionHeaderView ()

@property (nonatomic, strong) UILabel *month;

@end

@implementation CalendarCollectionHeaderView

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];

        [self setupUI];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI {
    [self addSubview:self.month];
    
    for (int i = 0; i < 7; i++) {
        UILabel *currentDay = [[UILabel alloc] initWithFrame:CGRectMake(i * (self.frame.size.width/7), self.frame.size.height - 22.4, self.frame.size.width/7, 14)];
        [currentDay setTextAlignment:NSTextAlignmentCenter];
        [currentDay setText:[self returnDayOfTheWeek:i+1]];
        [currentDay setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        [currentDay setTextColor:[UIColor blackColor]];
        [self addSubview:currentDay];
    }
}

- (UILabel *)month {
    if (!_month) {
        _month = [[UILabel alloc] init];
        [_month setFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
        [_month setTextColor:[UIColor darkTextColor]];
    }
    return _month;
}

#pragma mark - Setters
- (void)setupTextWithDate:(NSNumber *)timestamp {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue]];
    [_month setText:[NSString stringWithFormat:@"%@ %li", [self returnMonth:dateComponents.month], dateComponents.year]];
    [self layoutSubviews];
}

#pragma mark - Helpers
- (NSString *)returnMonth:(NSInteger)number {
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

- (NSString *)returnDayOfTheWeek:(NSInteger)number {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponents.day = number;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"E"];
    
    return [df stringFromDate:builtDate];
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [_month sizeToFit];
    [_month setFrame:CGRectMake(monthLeftMargin, monthTopMargin, _month.frame.size.width, _month.frame.size.height)];
    
    for (int i = 1; i < self.subviews.count; i++) {
        id view = [self.subviews objectAtIndex:i];
        if ([view isKindOfClass:[UILabel class]]) {
            [view setFrame:CGRectMake((i-1) * (self.frame.size.width/7), self.frame.size.height - 22.4, self.frame.size.width/7, 14)];
        }
    }
}

@end
