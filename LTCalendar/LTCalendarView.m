//
//  LTCalendarView.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 13.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "LTCalendarView.h"
#import "CalendarCell.h"

#import "CalendarCollectionHeaderView.h"

static NSString *calendarCellIdentifier = @"calendarCell";
static NSString *calendarHeaderView = @"headerView";

@interface LTCalendarView ()

@property (nonatomic, strong) UICollectionView *CV;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *notTrainingDays;
@property (nonatomic, strong) NSMutableArray *races;
@property (nonatomic, strong) NSMutableArray *swim;
@property (nonatomic, strong) NSMutableArray *run;

@property (nonatomic, strong) NSMutableArray *competitionDays;

@end

@implementation LTCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged) name:@"dateChanged" object:nil];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self fillArrays];
        [self setupUI];
    }
    return self;
}

#pragma mark LoadData
- (void)fillArrays {
    _notTrainingDays = [NSMutableArray new];
    
    _swim = [NSMutableArray new];
    for (int i = 0; i <= 12; i++) {
        [_swim addObject:[self dateWithYear:2016 month:1 day:i]];
    }
    
    _races = [NSMutableArray new];
    for (int i = 14; i <= 17; i++) {
        [_races addObject:[self dateWithYear:2016 month:1 day:i]];
    }
    
    _run = [NSMutableArray new];
    for (int i = 18; i <= 23; i++) {
        [_run addObject:[self dateWithYear:2016 month:1 day:i]];
    }
    
    _competitionDays = [NSMutableArray new];
    [_competitionDays addObject:[self dateWithYear:2016 month:2 day:1]];
    [_competitionDays addObject:[self dateWithYear:2016 month:1 day:22]];
}

#pragma mark setupUI
- (void)setupUI {
    [self addSubview:self.CV];
    [_CV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:[self returnCurrentMonth]] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
}

- (UICollectionView *)CV {
    if (!_CV) {
        _CV = [[UICollectionView alloc] initWithFrame:CGRectMake(fmodf(self.frame.size.width, 7)/2, 0, self.frame.size.width - fmodf(self.frame.size.width, 7), self.frame.size.height) collectionViewLayout:self.flowLayout];
        [_CV setDelegate:self];
        [_CV setDataSource:self];
        [_CV registerClass:[CalendarCell class] forCellWithReuseIdentifier:calendarCellIdentifier];
        [_CV registerClass:[CalendarCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:calendarHeaderView];
        [_CV setAlwaysBounceVertical:YES];
        [_CV setBackgroundColor:[UIColor clearColor]];
    }
    return _CV;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setMinimumLineSpacing:0.0f];
        [_flowLayout setMinimumInteritemSpacing:0.0f];
    }
    return _flowLayout;
}

#pragma mark CollectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 12;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 31 + [self returnStartIndexForMonth:section+1];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(_CV.frame)/7, CGRectGetWidth(_CV.frame)/7);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.width, 60);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CalendarCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:calendarHeaderView forIndexPath:indexPath];
        [headerView setupMonth:indexPath.section+1];
        [headerView setupDaysOfTheWeekSize:CGSizeMake(CGRectGetWidth(_CV.frame)/21, CGRectGetWidth(_CV.frame)/21)];
        reusableView = headerView;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:calendarCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[CalendarCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_CV.frame)/7, CGRectGetWidth(_CV.frame)/7)];
    }
    
    if (indexPath.item < [self returnStartIndexForMonth:indexPath.section+1] || indexPath.item >= [self returnStartIndexForMonth:indexPath.section+1] + [self returnNumberOfDaysInMonth:indexPath.section+1]) {
        [cell setupCellType:empty];
        [cell setupCellWithDay:0 andNumberOfDays:[self returnNumberOfDaysInMonth:indexPath.section+1]];
    }else {
        if ((indexPath.item == [self returnStartIndexForMonth:indexPath.section+1] + [self returnCurrentDay]) && indexPath.section == [self returnCurrentMonth]) {
            [cell setupCellType:currentDay];
        }else {
            BOOL foundType = NO;
            if (!foundType) {
                for (NSDate *date in _races) {
                    if ([indexPath isEqual:[self returnIndexPathByDate:date]]) {
                        [cell setupCellType:race];
                        foundType = YES;
                        break;
                    }
                }
            }
            if (!foundType) {
                for (NSDate *date in _swim) {
                    if ([indexPath isEqual:[self returnIndexPathByDate:date]]) {
                        [cell setupCellType:swim];
                        foundType = YES;
                        break;
                    }
                }
            }
            if (!foundType) {
                for (NSDate *date in _run) {
                    if ([indexPath isEqual:[self returnIndexPathByDate:date]]) {
                        [cell setupCellType:run];
                        foundType = YES;
                        break;
                    }
                }
            }
            if (!foundType) {
                [cell setupCellType:holiday];
            }
        }
        [cell setupCellWithDay:(indexPath.item+1) - [self returnStartIndexForMonth:indexPath.section+1] andNumberOfDays:[self returnNumberOfDaysInMonth:indexPath.section+1]];
    }
    
    for (NSIndexPath *currentIndexPath in _notTrainingDays) {
        if (currentIndexPath == indexPath) {
            [cell cantTrain];
            break;
        }else {
            [cell.dot removeFromSuperview];
        }
    }
    
    for (NSDate *date in _competitionDays) {
        if ([indexPath isEqual:[self returnIndexPathByDate:date]]) {
            [cell setupCompetition];
            break;
        }else {
            [cell.competitionView removeFromSuperview];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < [self returnStartIndexForMonth:indexPath.section+1] || indexPath.item >= [self returnStartIndexForMonth:indexPath.section+1] + [self returnNumberOfDaysInMonth:indexPath.section+1]) {
        return;
    }
    CalendarCell *cell = (CalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([_notTrainingDays containsObject:indexPath]) {
        [_notTrainingDays removeObject:indexPath];
        [cell.dot removeFromSuperview];
    }else {
        [_notTrainingDays addObject:indexPath];
        [cell cantTrain];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = (CalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.25 animations:^{
        [cell setAlpha:0.5];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = (CalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.25 animations:^{
        [cell setAlpha:1.0];
    }];
}

#pragma mark Actions
- (void)dateChanged {
    [_CV reloadData];
}

#pragma mark Helpers
- (NSInteger)returnStartIndexForMonth:(NSInteger)month {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponents.month = month;
    dateComponents.day = 0;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:builtDate];
    NSInteger weekday = [weekdayComponents weekday];
    return weekday - 1;
}

- (NSInteger)returnNumberOfDaysInMonth:(NSInteger)month {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponents.month = month;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    
    NSRange range = [gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:builtDate];
    NSUInteger numberOfDaysInMonth = range.length;
    
    return numberOfDaysInMonth;
}

- (NSInteger)returnCurrentDay {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    return dateComponents.day-1;
}

- (NSInteger)returnCurrentMonth {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    return dateComponents.month-1;
}

- (NSIndexPath *)returnIndexPathByDate:(NSDate *)date {
    NSInteger section = 0;
    NSInteger item = 0;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    section = dateComponents.month - 1;
    item = (dateComponents.day - 1) + [self returnStartIndexForMonth:section+1];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    return indexPath;
}

- (NSDate *)returnDateByIndexPath:(NSIndexPath *)indexPath {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponents.month = indexPath.section + 1;
    dateComponents.day = (indexPath.item + 1) - [self returnStartIndexForMonth:dateComponents.month];
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    return builtDate;
}

#pragma mark Layout
- (void)layoutSubviews {
    [_CV setFrame:CGRectMake(fmodf(self.frame.size.width, 7)/2, 0, self.frame.size.width - fmodf(self.frame.size.width, 7), self.frame.size.height)];
}

#pragma mark Others
- (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

@end
