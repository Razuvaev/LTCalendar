//
//  TrainingPlanTableViewCell.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 14.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "TrainingPlanTableViewCell.h"

#import "LTTrainingPlanView.h"

@interface TrainingPlanTableViewCell ()

@property (nonatomic, strong) LTTrainingPlanView *trainingPlan;

@end

@implementation TrainingPlanTableViewCell

#pragma mark - Lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI
- (void)setupUI {
    [self.contentView addSubview:self.trainingPlan];
}

- (LTTrainingPlanView *)trainingPlan {
    if (!_trainingPlan) {
        _trainingPlan = [[LTTrainingPlanView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120*7)];
    }
    return _trainingPlan;
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [_trainingPlan setFrame:CGRectMake(0, 0, self.frame.size.width, 120*7)];
}

#pragma mark - Actions
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
