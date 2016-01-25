//
//  AllTrainingPlanCollectionViewCell.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 13.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "AllTrainingPlanCollectionViewCell.h"

static const CGFloat leftMargin = 10;

@interface AllTrainingPlanCollectionViewCell ()

@property (nonatomic, strong) UIImageView *trainingTypeImageView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) CAShapeLayer *border;

@end

@implementation AllTrainingPlanCollectionViewCell

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setupUI];
        
        [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
        [self.layer setShouldRasterize:YES];
    }
    return self;
}

#pragma makr - setupUI
- (void)setupUI {
    [self.contentView addSubview:self.trainingTypeImageView];
    [self.contentView addSubview:self.durationLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.descriptionLabel];
    
    [self.layer addSublayer:self.border];
}

- (CAShapeLayer *)border {
    if (!_border) {
        CGRect layerFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0, layerFrame.size.height);
        CGPathAddLineToPoint(path, NULL, layerFrame.size.width, layerFrame.size.height);
        
        CGPathMoveToPoint(path, NULL, layerFrame.size.width, 0);
        CGPathAddLineToPoint(path, NULL, layerFrame.size.width, layerFrame.size.height);
        
        _border = [CAShapeLayer layer];
        _border.path = path;
        _border.lineWidth = [UIScreen mainScreen].scale;
        _border.frame = layerFrame;
        _border.strokeColor = [UIColor colorWithRed:14/255. green:45/255. blue:79/255. alpha:0.15].CGColor;
    }
    return _border;
}

- (UIImageView *)trainingTypeImageView {
    if (!_trainingTypeImageView) {
        _trainingTypeImageView = [[UIImageView alloc] init];
        [_trainingTypeImageView setBackgroundColor:[UIColor yellowColor]];
    }
    return _trainingTypeImageView;
}

- (UILabel *)durationLabel {
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        [_durationLabel setText:@"2h"];
        [_durationLabel setFont:[UIFont systemFontOfSize:14]];
        [_durationLabel setTextColor:[UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1.0]];
    }
    return _durationLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
        [_distanceLabel setText:@"15Km"];
        [_distanceLabel setFont:[UIFont systemFontOfSize:14]];
        [_distanceLabel setTextColor:[UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1.0]];
    }
    return _distanceLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        [_typeLabel setText:@"Combination"];
    }
    return _typeLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        [_descriptionLabel setText:@"Description..."];
        [_descriptionLabel setFont:[UIFont systemFontOfSize:12]];
        [_descriptionLabel setTextColor:[UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:1.0]];
    }
    return _descriptionLabel;
}

#pragma mark - Setters
- (void)setupCellWithDistance:(NSString *)distance {
    [_distanceLabel setText:distance];
    [self layoutSubviews];
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [_trainingTypeImageView setFrame:CGRectMake(leftMargin, 8, 29, 29)];
    
    [_typeLabel sizeToFit];
    [_typeLabel setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_trainingTypeImageView.frame) + 2, _typeLabel.frame.size.width, _typeLabel.frame.size.height)];
    
    [_durationLabel sizeToFit];
    [_durationLabel setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_typeLabel.frame) + 4, _durationLabel.frame.size.width, _durationLabel.frame.size.height)];
    
    [_distanceLabel sizeToFit];
    [_distanceLabel setFrame:CGRectMake(CGRectGetMaxX(_durationLabel.frame) + 10, CGRectGetMaxY(_typeLabel.frame) + 4, _distanceLabel.frame.size.width, _distanceLabel.frame.size.height)];
    
    [_descriptionLabel sizeToFit];
    [_descriptionLabel setFrame:CGRectMake(leftMargin, CGRectGetMaxY(_durationLabel.frame) + 7, _descriptionLabel.frame.size.width, _descriptionLabel.frame.size.height)];
}

@end
