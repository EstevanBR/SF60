//
//  Day.h
//  SF60
//
//  Created by Estevan Hernandez on 2/22/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kDate;
extern NSString *const kDateComponents;
extern NSString *const kDayType;
//extern NSString *const kDayComponents;
extern NSString *const kMonthComponents;
extern NSString *const kYearComponents;


@interface Day : NSObject <NSCoding>
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSDateComponents *dateComponents;
@property (strong, nonatomic) NSDateComponents *weekDayComponents;
@property (strong, nonatomic) NSDateComponents *monthComponents;
@property (strong, nonatomic) NSDateComponents *yearComponents;
@property (nonatomic, assign) int dayType;

-(id)initWithDate:(NSDate *)aDate;
@end
