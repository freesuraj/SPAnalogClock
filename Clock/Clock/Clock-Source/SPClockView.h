//
//  SPClockView.h
//  Clock
//
//  Created by Suraj on 16/8/14.
//  Copyright (c) 2014 Su Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPDigitalClock : UILabel
@property (strong,nonatomic) NSTimeZone *timeZone;
@end

@interface SPClockView : UIView

@property (strong,nonatomic) NSTimeZone *timeZone;

@end
