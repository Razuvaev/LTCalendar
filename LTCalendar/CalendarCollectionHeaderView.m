//
//  CalendarCollectionHeaderView.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 12.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "CalendarCollectionHeaderView.h"
@interface CalendarCollectionHeaderView ()

@property (nonatomic, strong) UILabel *month;

@end

@implementation CalendarCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self setupUI];
    }
    return self;
}

#pragma mark setupUI
- (void)setupUI {
    [self addSubview:self.month];
    
    for (int i = 0; i < 7; i++) {
        UILabel *currentDay = [[UILabel alloc] initWithFrame:CGRectMake(i * (self.frame.size.width/7), self.frame.size.height - 20, self.frame.size.width/7, 20)];
        [currentDay setTextAlignment:NSTextAlignmentCenter];
        [currentDay setText:[self returnDayOfTheWeek:i+1]];
        [self addSubview:currentDay];
    }
}

- (UILabel *)month {
    if (!_month) {
        _month = [[UILabel alloc] init];
        [_month setTextColor:[UIColor darkTextColor]];
    }
    return _month;
}

#pragma mark Setters
- (void)setupMonth:(NSInteger)month {
    [_month setText:[self returnMonth:month]];
    [self layoutSubviews];
}

- (void)setupDaysOfTheWeekSize:(CGSize)size {
    for (UILabel *label in self.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            if (label != _month) {
                [label setFont:[UIFont systemFontOfSize:size.height]];
            }
        }
    }
}

#pragma mark Helpers
- (NSString *)returnMonth:(NSInteger)number {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    dateComponents.month = number;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"MMMM"];
    
    return [df stringFromDate:builtDate];
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

#pragma mark Layout
- (void)layoutSubviews {
    [_month sizeToFit];
    [_month setFrame:CGRectMake(self.frame.size.width/2 - _month.frame.size.width/2, 10, _month.frame.size.width, _month.frame.size.height)];
}

@end
