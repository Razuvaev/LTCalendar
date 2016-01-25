//
//  SportTypeTrainingPlanCollectionViewCell.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 15.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "SportTypeTrainingPlanCollectionViewCell.h"

static CGFloat const margin = 10;

@interface SportTypeTrainingPlanCollectionViewCell ()

@property (nonatomic, strong) UILabel *sportLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) CAShapeLayer *border;

@end

@implementation SportTypeTrainingPlanCollectionViewCell

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
        [self.layer setShouldRasterize:YES];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI {
    [self.contentView addSubview:self.sportLabel];
    [self.contentView addSubview:self.durationLabel];
    [self.contentView addSubview:self.distanceLabel];
    
    [self.layer addSublayer:self.border];
}

- (UILabel *)sportLabel {
    if (!_sportLabel) {
        _sportLabel = [[UILabel alloc] init];
        [_sportLabel setTextColor:[UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1.0]];
        [_sportLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _sportLabel;
}

- (UILabel *)durationLabel {
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        [_durationLabel setTextColor:[UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:0.6]];
        [_durationLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _durationLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
        [_distanceLabel setTextColor:[UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:0.6]];
        [_distanceLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _distanceLabel;
}

- (CAShapeLayer *)border {
    if (!_border) {
        CGRect layerFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0, layerFrame.size.height);
        CGPathAddLineToPoint(path, NULL, layerFrame.size.width, layerFrame.size.height);
                
        _border = [CAShapeLayer layer];
        _border.path = path;
        _border.lineWidth = [UIScreen mainScreen].scale;
        _border.frame = layerFrame;
        _border.strokeColor = [UIColor colorWithRed:14/255. green:45/255. blue:79/255. alpha:0.15].CGColor;
    }
    return _border;
}

#pragma mark - Setter
- (void)setupCellWithType:(sportType)type {
    switch (type) {
        case swim:
        {
            [_sportLabel setText:@"Swim"];
            [_durationLabel setText:@"1 h"];
            [_distanceLabel setText:@"10 Km"];
            break;
        }
        case bike:
        {
            [_sportLabel setText:@"Bike"];
            [_durationLabel setText:@"2 h"];
            [_distanceLabel setText:@"30 Km"];
            break;
        }
        case run:
        {
            [_sportLabel setText:@"Run"];
            [_durationLabel setText:@"20 m"];
            [_distanceLabel setText:@"5 Km"];
            break;
        }
        default:
            break;
    }
    [self layoutSubviews];
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_sportLabel sizeToFit];
    [_sportLabel setFrame:CGRectMake(margin, margin, _sportLabel.frame.size.width, _sportLabel.frame.size.height)];
    
    [_durationLabel sizeToFit];
    [_durationLabel setFrame:CGRectMake(margin, CGRectGetMaxY(_sportLabel.frame) + 4, _durationLabel.frame.size.width, _durationLabel.frame.size.height)];
    
    [_distanceLabel sizeToFit];
    [_distanceLabel setFrame:CGRectMake(CGRectGetMaxX(_durationLabel.frame) + 8, CGRectGetMaxY(_sportLabel.frame) + 4, _distanceLabel.frame.size.width, _distanceLabel.frame.size.height)];
}

@end
