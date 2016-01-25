//
//  CalendarCell.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 12.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "CalendarCell.h"

static const CGFloat dotSize = 4;
static const CGFloat borderWidth = 4;

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

- (UIView *)dot {
    if (!_dot) {
        _dot = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - dotSize/2, CGRectGetMaxY(_day.frame) + 3, dotSize, dotSize)];
        [_dot.layer setCornerRadius:_dot.frame.size.width/2];
        [_dot.layer setRasterizationScale:[UIScreen mainScreen].scale];        
        [_dot.layer setShouldRasterize:YES];
        [_dot setBackgroundColor:[UIColor blackColor]];
    }
    return _dot;
}

- (UIView *)competitionView {
    if (!_competitionView) {
        _competitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_competitionView setBackgroundColor:[UIColor clearColor]];
        [_competitionView.layer setBorderWidth:borderWidth];
        [_competitionView.layer setBorderColor:[UIColor blackColor].CGColor];
        [_competitionView.layer setRasterizationScale:[UIScreen mainScreen].scale];
        [_competitionView.layer setShouldRasterize:YES];
    }
    return _competitionView;
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

- (void)cantTrain {
    [self.contentView addSubview:self.dot];
    if ([_day.textColor isEqual:[UIColor blackColor]]) {
        [_dot setBackgroundColor:[UIColor blackColor]];
    }else {
        [_dot setBackgroundColor:[UIColor whiteColor]];
    }
}

#pragma mark Helpers
- (UIColor *)returnColorForType:(cellType)type {
    [_day setTextColor:[UIColor blackColor]];
    switch (type) {
        case race:
        {
            return [UIColor colorWithRed:255/255. green:244/255. blue:167/255. alpha:1.0];
        }
        case swim:
        {
            return [UIColor colorWithRed:123/255. green:213/255. blue:246/255. alpha:1.0];
            break;
        }
        case run:
        {
            return [UIColor colorWithRed:255/255. green:203/255. blue:137/255. alpha:1.0];
            break;
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
