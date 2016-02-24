//
//  Day.m
//  SF60
//
//  Created by Estevan Hernandez on 2/22/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import "Day.h"

NSString* const kDate = @"date";
NSString* const kDayType = @"dayType";
//NSString* const kDayComponents = @"dayComponents";
NSString* const kDateComponents = @"dateComponents";
NSString* const kMonthComponents = @"monthComponents";
NSString* const kYearComponents = @"yearComponents";

@implementation Day
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.date = [coder decodeObjectForKey:kDate];
        self.dateComponents = [coder decodeObjectForKey:kDateComponents];
        self.monthComponents = [coder decodeObjectForKey:kMonthComponents];
        self.yearComponents = [coder decodeObjectForKey:kYearComponents];
        self.dayType = [[coder decodeObjectForKey:kDayType] intValue];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.date forKey:kDate];
    [aCoder encodeObject:self.dateComponents forKey:kDateComponents];
    [aCoder encodeObject:self.monthComponents forKey:kMonthComponents];
    [aCoder encodeObject:self.yearComponents forKey:kYearComponents];
    [aCoder encodeObject:[NSNumber numberWithInt:self.dayType] forKey:kDayType];
}
-(id)initWithDate:(NSDate *)aDate {
    self = [super init];
    self.date = aDate;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.dateComponents = [gregorian components:NSCalendarUnitDay fromDate:self.date];
    self.weekDayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:self.date];
    self.monthComponents = [gregorian components:NSCalendarUnitMonth fromDate:self.date];
    self.yearComponents = [gregorian components:NSCalendarUnitYear fromDate:self.date];
    return self;
    
}
@end
