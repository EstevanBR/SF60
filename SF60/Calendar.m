//
//  Calendar.m
//  SF60
//
//  Created by Estevan Hernandez on 2/23/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import "Calendar.h"

//NSString *const kCalendar = @"calendar";
NSString *const kDays = @"days";

@implementation Calendar
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.days = [coder decodeObjectForKey:kDays];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.days forKey:kDays];
}

+(void)saveCalendarToArchive:(Calendar *)aCalendar {
    [NSKeyedArchiver archiveRootObject:aCalendar toFile:[Calendar getPathToArchive]];
}
+(Calendar *)getCalendarFromArchive {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[Calendar getPathToArchive]];
    
}
+(NSString *)getPathToArchive {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    return [docsDir stringByAppendingString:@"calendar.model"];
}

@end
