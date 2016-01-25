//
//  TrainingPlanTotalFooterView.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 14.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "TrainingPlanTotalFooterView.h"

#import "TotalTrainingPlanCollectionViewCell.h"
#import "SportTypeTrainingPlanCollectionViewCell.h"

static NSString * const totalCellIdentifier = @"totalCellIdentifier";
static NSString * const sportTypeCellIdentifier = @"sportTypeCellIdentifier";

static const CGFloat totalCellItemWidth = 49;
static const CGFloat sportTypeCellItemWidth = 111;

@interface TrainingPlanTotalFooterView ()

@property (nonatomic, strong) UICollectionView *footerCV;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation TrainingPlanTotalFooterView

#pragma mark - Lifecycle
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
    [self addSubview:self.footerCV];
}

- (UICollectionView *)footerCV {
    if (!_footerCV) {
        _footerCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.layout];
        [_footerCV registerClass:[TotalTrainingPlanCollectionViewCell class] forCellWithReuseIdentifier:totalCellIdentifier];
        [_footerCV registerClass:[SportTypeTrainingPlanCollectionViewCell class] forCellWithReuseIdentifier:sportTypeCellIdentifier];
        [_footerCV setDelegate:self];
        [_footerCV setDataSource:self];
        [_footerCV setScrollsToTop:NO];
        [_footerCV setShowsHorizontalScrollIndicator:NO];
        [_footerCV setBackgroundColor:[UIColor whiteColor]];
    }
    return _footerCV;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        [_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [_layout setMinimumInteritemSpacing:CGFLOAT_MIN];
        [_layout setMinimumLineSpacing:CGFLOAT_MIN];
    }
    return _layout;
}

#pragma mark - CollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width;
    if (indexPath.row == 0) {
        width = totalCellItemWidth;
    }else {
        width = sportTypeCellItemWidth;
    }
    return CGSizeMake(width, _footerCV.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width;
    if (indexPath.row == 0) {
        width = totalCellItemWidth;
    }else {
        width = sportTypeCellItemWidth;
    }
    
    if (indexPath.item == 0) {
        TotalTrainingPlanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:totalCellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[TotalTrainingPlanCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, width, _footerCV.frame.size.height)];
        }
        return cell;
    }else {
        SportTypeTrainingPlanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sportTypeCellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[SportTypeTrainingPlanCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, width, _footerCV.frame.size.height)];
        }
        if (indexPath.item == 1) {
            [cell setupCellWithType:swim];
        }
        if (indexPath.item == 2) {
            [cell setupCellWithType:bike];
        }
        if (indexPath.item == 3) {
            [cell setupCellWithType:run];
        }
        return cell;
    }
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_footerCV setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
