//
//  TrainingPlanTableViewHeader.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 14.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "TrainingPlanTableViewHeader.h"
@interface TrainingPlanTableViewHeader ()

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation TrainingPlanTableViewHeader

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:65/255. green:147/255. blue:241/255. alpha:0.1]];
        [self addGestureRecognizer:self.tap];
        [self setupUI];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI {
    [self addSubview:self.headerLabel];
}

- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        [_headerLabel setTextColor:[UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1.0]];
        [_headerLabel setFont:[UIFont systemFontOfSize:17]];
        [_headerLabel setUserInteractionEnabled:YES];
    }
    return _headerLabel;
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    }
    return _tap;
}

#pragma mark - Actions
- (void)tapAction {
    [self.delegate sectionTapped:_currentSection];
}

#pragma mark - Setters
- (void)setHeaderLabelWithText:(NSString *)text {
    [_headerLabel setText:text];
    [self layoutSubviews];
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [_headerLabel sizeToFit];
    [_headerLabel setFrame:CGRectMake(self.frame.size.width/2 - _headerLabel.frame.size.width/2, self.frame.size.height/2 - _headerLabel.frame.size.height/2, _headerLabel.frame.size.width, _headerLabel.frame.size.height)];
}

@end
