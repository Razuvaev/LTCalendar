//
//  CalendarCollectionHeaderView.h
//  LTCalendar
//
//  Created by Pavel Razuvaev on 12.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCollectionHeaderView : UICollectionReusableView

- (void)setupTextWithDate:(NSNumber *)timestamp;

@end
