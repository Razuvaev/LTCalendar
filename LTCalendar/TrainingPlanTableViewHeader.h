//
//  TrainingPlanTableViewHeader.h
//  LTCalendar
//
//  Created by Pavel Razuvaev on 14.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrainingPlanTableViewHeaderDelegate;

@interface TrainingPlanTableViewHeader : UIView

@property (nonatomic) NSInteger currentSection;

- (void)setHeaderLabelWithText:(NSString *)text;

@property (nonatomic, weak) NSObject<TrainingPlanTableViewHeaderDelegate> *delegate;

@end

@protocol TrainingPlanTableViewHeaderDelegate <NSObject>
@optional

- (void)sectionTapped:(NSInteger)section;

@end
