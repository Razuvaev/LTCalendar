//
//  LTDateHeaderView.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 14.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "LTDateHeaderView.h"

@implementation LTDateHeaderView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark setupUI
- (void)setupUI {
    for (int i = 0; i < 7; i++) {
        UILabel *concreteDay = [[UILabel alloc] initWithFrame:CGRectMake(0, i * self.frame.size.height/7, self.frame.size.width, self.frame.size.height/7)];
        [concreteDay setText:@"24\nMon"];
        [concreteDay setNumberOfLines:2];
        [concreteDay setTextAlignment:NSTextAlignmentCenter];
        if (i % 2) {
            [concreteDay setBackgroundColor:[UIColor whiteColor]];
            [concreteDay setTextColor:[UIColor colorWithRed:66/255. green:147/255. blue:241/255. alpha:1.0]];
        }else {
            [concreteDay setBackgroundColor:[UIColor colorWithRed:66/255. green:147/255. blue:241/255. alpha:1.0]];
            [concreteDay setTextColor:[UIColor whiteColor]];
        }
        
        CGRect layerFrame = CGRectMake(0, 0, concreteDay.frame.size.width, concreteDay.frame.size.height);
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0, layerFrame.size.height);
        CGPathAddLineToPoint(path, NULL, layerFrame.size.width, layerFrame.size.height);
        
        CAShapeLayer *border = [CAShapeLayer layer];
        border.path = path;
        border.lineWidth = [UIScreen mainScreen].scale;
        border.frame = layerFrame;
        border.strokeColor = [UIColor colorWithRed:14/255. green:45/255. blue:79/255. alpha:0.15].CGColor;

        [concreteDay.layer addSublayer:border];
        
        [self addSubview:concreteDay];
    }
}

@end
