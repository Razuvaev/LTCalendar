//
//  LTTrainingPlanView.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 13.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "LTTrainingPlanView.h"

#import "LTDateHeaderView.h"

#import "TrainingPlanCollectionViewCell.h"

static const CGFloat dateHeaderWidth = 49;

static NSInteger numberOfSections = 7; //days of the week
static NSInteger numberOfItemsInSection = 3; //possible type of trainings in one day
static NSString *trainingPlanCellIdentifier = @"trainingPlanCell";

@interface LTTrainingPlanView ()

@property (nonatomic, strong) LTDateHeaderView *dateHeader;

@property (nonatomic, strong) UICollectionView *CV;
@property (nonatomic, strong) TrainingPlanCollectionViewLayout *layout;

@end

@implementation LTTrainingPlanView

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI
- (void)setupUI {
    [self addSubview:self.dateHeader];
    [self addSubview:self.CV];
}

- (LTDateHeaderView *)dateHeader {
    if (!_dateHeader) {
        _dateHeader = [[LTDateHeaderView alloc] initWithFrame:CGRectMake(0, 0, dateHeaderWidth, self.frame.size.height)];
    }
    return _dateHeader;
}

- (UICollectionView *)CV {
    if (!_CV) {
        _CV = [[UICollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_dateHeader.frame), 0, self.frame.size.width - CGRectGetWidth(_dateHeader.frame), self.frame.size.height) collectionViewLayout:self.layout];
        [_CV setDelegate:self];
        [_CV setDataSource:self];
        [_CV setBounces:YES];
        [_CV setShowsHorizontalScrollIndicator:NO];
        [_CV setScrollsToTop:NO];
        [_CV registerClass:[TrainingPlanCollectionViewCell class] forCellWithReuseIdentifier:trainingPlanCellIdentifier];
        [_CV setBackgroundColor:[UIColor colorWithRed:225/255. green:228/255. blue:232/255. alpha:1.0]];
    }
    return _CV;
}

- (TrainingPlanCollectionViewLayout *)layout {
    if (!_layout) {
        _layout = [[TrainingPlanCollectionViewLayout alloc] init];
        [_layout setNumberOfColumns:numberOfItemsInSection];
    }
    return _layout;
}

#pragma mark - CollectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return numberOfItemsInSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TrainingPlanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:trainingPlanCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    TrainingPlanCollectionViewCell *cell = (TrainingPlanCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.25 animations:^{
        [cell setAlpha:0.5];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    TrainingPlanCollectionViewCell *cell = (TrainingPlanCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.25 animations:^{
        [cell setAlpha:1.0];
    }];
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [_dateHeader setFrame:CGRectMake(0, 0, dateHeaderWidth, self.frame.size.height)];
    [_CV setFrame:CGRectMake(CGRectGetMaxX(_dateHeader.frame), 0, self.frame.size.width - CGRectGetWidth(_dateHeader.frame), self.frame.size.height)];
}

@end
