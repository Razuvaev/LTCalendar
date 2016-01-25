//
//  SportTypeTrainingPlanCollectionViewCell.h
//  LTCalendar
//
//  Created by Pavel Razuvaev on 15.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    swim = 0,
    bike,
    run
}sportType;

@interface SportTypeTrainingPlanCollectionViewCell : UICollectionViewCell

- (void)setupCellWithType:(sportType)type;

@end
