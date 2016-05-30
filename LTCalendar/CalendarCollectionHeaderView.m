//
//  CalendarCollectionHeaderView.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 12.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "CalendarCollectionHeaderView.h"

static const CGFloat daysInWeek = 7;

static const CGFloat monthLeftMargin = 12;
static const CGFloat monthTopMargin = 10;

static const CGFloat dayBottomMargin = 22.4;
static const CGFloat dayLabelHeight = 14;

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
    
    for (int i = 0; i < daysInWeek; i++) {
        UILabel *currentDay = [[UILabel alloc] initWithFrame:CGRectMake(i * (self.frame.size.width/daysInWeek), self.frame.size.height - dayBottomMargin, self.frame.size.width/daysInWeek, dayLabelHeight)];
        [currentDay setTextAlignment:NSTextAlignmentCenter];
        [currentDay setText:[NSString returnDayOfTheWeek:i+1]];
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
    [_month setText:[NSString stringWithFormat:@"%@ %li", [NSString returnMonth:dateComponents.month], dateComponents.year]];
    [self layoutSubviews];
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [_month sizeToFit];
    [_month setFrame:CGRectMake(monthLeftMargin, monthTopMargin, _month.frame.size.width, _month.frame.size.height)];
    
    for (int i = 1; i < self.subviews.count; i++) {
        id view = [self.subviews objectAtIndex:i];
        if ([view isKindOfClass:[UILabel class]]) {
            [view setFrame:CGRectMake((i-1) * (self.frame.size.width/7), self.frame.size.height - dayBottomMargin, self.frame.size.width/daysInWeek, dayLabelHeight)];
        }
    }
}

@end
