//
//  LTTrainingPlanView.h
//  LTCalendar
//
//  Created by Pavel Razuvaev on 13.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainingPlanCollectionViewLayout.h"

@interface LTTrainingPlanView : UIView <TrainingPlanCollectionViewLayout, TrainingPlanCollectionViewDataSource, UIGestureRecognizerDelegate>

@end
