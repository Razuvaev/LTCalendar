//
//  CalendarCell.h
//  LTCalendar
//
//  Created by Pavel Razuvaev on 12.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    race = 0,
    swim,
    run,
    competition,
    holiday,
    currentDay,
    empty,
}cellType;

@interface CalendarCell : UICollectionViewCell

@property (nonatomic, strong) UIView *dot;
@property (nonatomic, strong) UIView *competitionView;

- (void)setupCellWithDay:(NSInteger)day andNumberOfDays:(NSInteger)daysInMonth;
- (void)setupCellType:(cellType)type;
- (void)setupCompetition;
- (void)cantTrain;

@end
