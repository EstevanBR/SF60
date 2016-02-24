//
//  Calendar.h
//  SF60
//
//  Created by Estevan Hernandez on 2/23/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import <Foundation/Foundation.h>

//extern NSString *const kCalendar;
extern NSString *const kDays;

@interface Calendar : NSObject <NSCoding>
@property (strong, nonatomic) NSArray *days;
+(void)saveCalendarToArchive:(Calendar *)aCalendar;
+(NSString *)getPathToArchive;
+(Calendar *)getCalendarFromArchive;
@end
