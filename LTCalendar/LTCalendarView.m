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

static CGFloat const heightForHeader = 63;

static NSInteger const numberOfMonthsInYear = 12;
static NSInteger const maximumDaysInMonth = 31;
static NSInteger const numberOfDaysInWeek = 7;

@interface LTCalendarView ()

/**
CollectionView layout
*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

/**
Bool property which shows if collectionView is updating right now
*/
@property (nonatomic) BOOL updating;

@end

@implementation LTCalendarView

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged) name:@"dateChanged" object:nil];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _updating = NO;
        _numberOfSections = 12;
        
        [self fillArrays];
        [self setupUI];
    }
    return self;
}

#pragma mark - LoadData
- (void)fillArrays {
    
}

#pragma mark - setupUI
- (void)setupUI {
    [self addSubview:self.CV];
}

- (UICollectionView *)CV {
    if (!_CV) {
        _CV = [[UICollectionView alloc] initWithFrame:CGRectMake(fmodf(self.frame.size.width, 7)/2, 0, self.frame.size.width - fmodf(self.frame.size.width, 7), self.frame.size.height) collectionViewLayout:self.flowLayout];
        [_CV setDelegate:self];
        [_CV setDataSource:self];
        [_CV registerClass:[CalendarCell class] forCellWithReuseIdentifier:calendarCellIdentifier];
        [_CV registerClass:[CalendarCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:calendarHeaderView];
        [_CV setAlwaysBounceVertical:YES];
        [_CV setScrollsToTop:YES];
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

#pragma mark - CollectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return maximumDaysInMonth + [self returnStartIndexForMonth:section + [self returnStartMonth]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(_CV.frame)/numberOfDaysInWeek, CGRectGetWidth(_CV.frame)/numberOfDaysInWeek);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.width, heightForHeader);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CalendarCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:calendarHeaderView forIndexPath:indexPath];
        [headerView setupTextWithDate:[self returnDateByIndexPath:[NSIndexPath indexPathForItem:[self returnStartIndexForMonth:indexPath.section + [self returnStartMonth]] inSection:indexPath.section]]];
        reusableView = headerView;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:calendarCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[CalendarCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_CV.frame)/numberOfDaysInWeek, CGRectGetWidth(_CV.frame)/numberOfDaysInWeek)];
    }
    
    if (indexPath.item < [self returnStartIndexForMonth:indexPath.section + [self returnStartMonth]] || indexPath.item >= [self returnStartIndexForMonth:indexPath.section + [self returnStartMonth]] + [self returnNumberOfDaysInMonth:indexPath.section + [self returnStartMonth]]) {
        [cell setupCellType:empty];
        [cell setupCellWithDay:0 andNumberOfDays:[self returnNumberOfDaysInMonth:indexPath.section + [self returnStartMonth]]];
    }else {
        [cell setupCellType:workdays];
        
        if (indexPath == [self returnIndexPathByTimeStamp:[NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970]]) {
            [cell setupCellType:currentDay];
        }
        
        if ([self isWeekEnd:indexPath]) {
            [cell setupCellType:holiday];
        }
        
        [cell setupCellWithDay:(indexPath.item+1) - [self returnStartIndexForMonth:indexPath.section + [self returnStartMonth]] andNumberOfDays:[self returnNumberOfDaysInMonth:indexPath.section + [self returnStartMonth]]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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

#pragma mark - Actions
- (void)dateChanged {
    [_CV reloadData];
}

#pragma mark - Helpers
- (NSInteger)returnStartIndexForMonth:(NSInteger)month {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponents.month = month;
    dateComponents.year = dateComponents.year;
    dateComponents.day = 1;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate zeroDateFromDate:builtDate]];
    NSInteger weekday = [weekdayComponents weekday];
    return [self returnCustomWeekdayByOriginal:weekday];
}

- (NSInteger)returnNumberOfDaysInMonth:(NSInteger)month {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    dateComponents.month = month;
    dateComponents.year = dateComponents.year;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    
    NSRange range = [gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate zeroDateFromDate:builtDate]];
    NSUInteger numberOfDaysInMonth = range.length;
    
    return numberOfDaysInMonth;
}

- (NSInteger)returnCurrentDay {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    return dateComponents.day-1;
}

- (NSInteger)returnCurrentMonth {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    return dateComponents.month;
}

- (NSInteger)returnStartMonth {
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    return dateComponents.month;
}

- (NSIndexPath *)returnIndexPathByTimeStamp:(NSNumber *)timeStamp {
    NSInteger section = 0;
    NSInteger item = 0;
    
    NSDate *startDate = [NSDate date];
    NSDateComponents *startDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:startDate];
    NSInteger startYear = startDateComponents.year;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.doubleValue];
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSInteger year = dateComponents.year;
    
    NSInteger yearDiff = year - startYear;
    
    section = dateComponents.month - [self returnStartMonth] + numberOfMonthsInYear*yearDiff;
    item = (dateComponents.day - 1) + [self returnStartIndexForMonth:section + [self returnStartMonth]];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    return indexPath;
}

- (NSNumber *)returnDateByIndexPath:(NSIndexPath *)indexPath {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    dateComponents.month = indexPath.section + [self returnStartMonth];
    dateComponents.year = dateComponents.year;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.day = (indexPath.item + 1) - [self returnStartIndexForMonth:dateComponents.month];
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *builtDate =[gregorian dateFromComponents:dateComponents];
    
    NSNumber *timeStamp = [NSNumber numberFromDate:[NSDate zeroDateFromDate:builtDate]];
    
    return timeStamp;
}

- (NSInteger)returnCustomWeekdayByOriginal:(NSInteger)originalWeekDay {
    switch (originalWeekDay) {
        case 1:
        {
            return originalWeekDay + 5;
        }
        default:
        {
            return originalWeekDay - 2;
        }
    }
}

- (BOOL)isWeekEnd:(NSIndexPath *)indexPath {
    NSNumber *currentDate = [self returnDateByIndexPath:indexPath];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday fromDate:[NSDate dateWithTimeIntervalSince1970:currentDate.doubleValue]];
    
    NSInteger day = [self returnCustomWeekdayByOriginal:dateComponents.weekday];
    
    if (day == 5 || day == 6) {
        return YES;
    }else {
        return NO;
    }
}

- (void)scrollToCurrentMonth {
    [_CV scrollToItemAtIndexPath:[self returnIndexPathByTimeStamp:[NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970]] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_updating) {
        if ((scrollView.contentOffset.y + heightForHeader*_numberOfSections) > scrollView.contentSize.height) {
            _updating = YES;
            _numberOfSections = _numberOfSections + numberOfMonthsInYear;
            [_CV reloadData];
            _updating = NO;
        }
    }
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [_CV setFrame:CGRectMake(fmodf(self.frame.size.width, 7)/2, 0, self.frame.size.width - fmodf(self.frame.size.width, 7), self.frame.size.height)];
    [_flowLayout invalidateLayout];
}

@end