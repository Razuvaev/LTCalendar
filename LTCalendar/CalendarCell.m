//
//  CalendarCell.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 12.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "CalendarCell.h"

@interface CalendarCell ()

@property (nonatomic, strong) UILabel *day;

@end

@implementation CalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        [self setClipsToBounds:YES];
        [self setupUI];
    }
    return self;
}

#pragma mark setupUI
- (void)setupUI {
    [self.contentView addSubview:self.day];
}

- (UILabel *)day {
    if (!_day) {
        _day = [[UILabel alloc] init];
        [_day setFont:[UIFont systemFontOfSize:self.frame.size.height/3]];
        [_day setTextColor:[UIColor blackColor]];
    }
    return _day;
}

#pragma mark Setters
- (void)setupCellWithDay:(NSInteger)day andNumberOfDays:(NSInteger)daysInMonth {
    if (day >= 1 && day <= daysInMonth) {
        [_day setText:[NSString stringWithFormat:@"%li", (long)day]];
    }else {
        [_day setText:@""];
    }
    [self layoutSubviews];
}

- (void)setupCellType:(cellType)type {
    [self setBackgroundColor:[self returnColorForType:type]];
}

- (void)setupCompetition {
    [self.contentView addSubview:self.competitionView];
}

#pragma mark Helpers
- (UIColor *)returnColorForType:(cellType)type {
    [_day setTextColor:[UIColor blackColor]];
    switch (type) {
        case workdays:
        {
            return [UIColor colorWithRed:245/255. green:245/255. blue:245/255. alpha:1.0];
        }
        case holiday:
        {
            return [UIColor colorWithRed:231/255. green:234/255. blue:238/255. alpha:1.0];
        }
        case currentDay:
        {
            [_day setTextColor:[UIColor whiteColor]];
            return [UIColor colorWithRed:12/255. green:46/255. blue:77/255. alpha:1.0];
        }
        default:
        {
            return [UIColor whiteColor];
        }
    }
}

#pragma mark Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_day sizeToFit];
    [_day setFrame:CGRectMake(self.frame.size.width/2 - _day.frame.size.width/2, self.frame.size.height/2 - _day.frame.size.height, _day.frame.size.width, _day.frame.size.height)];
}

@end
