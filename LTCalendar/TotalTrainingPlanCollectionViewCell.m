//
//  TotalTrainingPlanCollectionViewCell.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 15.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "TotalTrainingPlanCollectionViewCell.h"

static CGFloat const topMargin = 10;

@interface TotalTrainingPlanCollectionViewCell ()

@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) CAShapeLayer *border;

@end

@implementation TotalTrainingPlanCollectionViewCell

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
    [self.contentView addSubview:self.totalLabel];
    [self.layer addSublayer:self.border];
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        [_totalLabel setText:@"Total"];
        [_totalLabel setFont:[UIFont systemFontOfSize:14]];
        [_totalLabel setTextColor:[UIColor colorWithRed:74/255. green:74/255. blue:74/255. alpha:0.8]];
    }
    return _totalLabel;
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

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [_totalLabel sizeToFit];
    [_totalLabel setFrame:CGRectMake(self.frame.size.width/2 - _totalLabel.frame.size.width/2, topMargin, _totalLabel.frame.size.width, _totalLabel.frame.size.height)];
}

@end
