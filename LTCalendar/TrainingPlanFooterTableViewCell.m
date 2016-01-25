//
//  TrainingPlanFooterTableViewCell.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 14.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "TrainingPlanFooterTableViewCell.h"

#import "TrainingPlanTotalFooterView.h"

static const CGFloat footerHeight = 56;

@interface TrainingPlanFooterTableViewCell ()

@property (nonatomic, strong) TrainingPlanTotalFooterView *footerView;

@end

@implementation TrainingPlanFooterTableViewCell

#pragma mark - Lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI {
    [self.contentView addSubview:self.footerView];
}

- (TrainingPlanTotalFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[TrainingPlanTotalFooterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, footerHeight)];
    }
    return _footerView;
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [_footerView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, footerHeight)];
}

#pragma mark - Actions
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
