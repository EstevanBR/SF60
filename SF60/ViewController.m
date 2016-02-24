//
//  ViewController.m
//  SF60
//
//  Created by Estevan Hernandez on 2/22/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewLoaded");
    //self.calendar = [[Calendar alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                             target:self
                                           selector:@selector(ifSameDayReactivateButton)
                                           userInfo:nil
                                            repeats:YES];
    self.calendar = [Calendar getCalendarFromArchive];
    if (self.calendar == nil) {
        self.calendar = [Calendar new];
    }
    if ([self.calendar.days count] == 0) {
        NSMutableArray *mutableArray = [NSMutableArray new];
        for (int i = 30; i > 0; i--) {
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-(i*86400)];
            Day *day = [[Day alloc] initWithDate:date];
            if ([day.weekDayComponents weekday] == 1 || [day.weekDayComponents weekday] == 7) {
                day.dayType = 2;
            }
            [mutableArray insertObject:day atIndex:0];
        }
        self.calendar.days = (NSArray *)mutableArray;
    }
    self.dateFormatter = [NSDateFormatter new];
    [self.dateFormatter setDateFormat:@"E MMM dd YYYY"];
    [self.addDayButton addTarget:self
                          action:@selector(buttonPressed)
                forControlEvents:UIControlEventTouchUpInside];
    [self ifSameDayReactivateButton];
    self.donutView.linePercentage = 0.20;
    self.donutView.percentage = 0.0;
    self.donutView.fillColor = [UIColor colorWithRed:0.9 green:1.0 blue:0.9 alpha:0.75];
    self.donutView.unfillColor = [UIColor colorWithRed:1.0 green:0.9 blue:0.9 alpha:0.75];
    if (self.calendar.days.count > 0) {
        self.donutView.percentage = [self getPercentageOfOfficeDays];
    }
    self.donutView.animatesBegining = YES;//
}

-(void)ifSameDayReactivateButton {
    NSLog(@"checking if same day");
    if ([self sameDay:[[Day alloc] initWithDate:[NSDate date]] andDay:self.calendar.days[0]]) {
        [self.addDayButton setEnabled:NO];
    }

}

-(void)viewWillAppear:(BOOL)animated {
}

-(BOOL)sameDay:(Day *)aDay andDay:(Day *)bDay {
    return (aDay.dateComponents.day == bDay.dateComponents.day && aDay.monthComponents.month == bDay.monthComponents.month && aDay.yearComponents.year == bDay.yearComponents.year);
}

-(void)buttonPressed {
    Day *newDay = [[Day alloc] initWithDate:[NSDate date]];
    Day *zeroDay = [self.calendar.days objectAtIndex:0];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:self.calendar.days];
    if ([self sameDay:newDay andDay:zeroDay]) {
        //zeroDay.dayType = 2;
    } else {
        [mutableArray insertObject:newDay atIndex:0];
    }
    self.calendar.days = (NSArray *)mutableArray;
    self.donutView.percentage = [self getPercentageOfOfficeDays];
    [Calendar saveCalendarToArchive:self.calendar];
    [self.tableView reloadData];
    
}

-(CGFloat)getPercentageOfOfficeDays {
    int i = 0;
    NSInteger officeDays = 0;
    NSInteger wfhDays = 0;
    NSInteger days = self.calendar.days.count;
    for (i = 0; i < days; i++) {
        Day *day = self.calendar.days[i];
        if (day.dayType == 0) {
            officeDays += 1;
            NSLog(@"was office day");
        }
        if (day.dayType == 1) {
            wfhDays += 1;
            NSLog(@"was wfh day");
        }
    }
    NSLog(@"%ld - %ld / %ld (office/wfh", (long) days, (long) officeDays, (long) wfhDays);
    CGFloat percent = (CGFloat) officeDays / ((CGFloat) officeDays + (CGFloat) wfhDays);
    NSLog(@"new percent: %f", percent);
    return (CGFloat) percent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"self.calendar.days count %ld", (long) [self.calendar.days count]);
    return [self.calendar.days count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dayCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"dayCell"];
    }
    Day *day = [self.calendar.days objectAtIndex:indexPath.row];
    if (day.dayType == 0) {
        cell.textLabel.text = @"Day was office day";
        cell.backgroundColor = self.donutView.fillColor;
    }
    if (day.dayType == 1) {
        cell.textLabel.text = @"Was not office day";
        cell.backgroundColor = self.donutView.unfillColor;
    }
    if (day.dayType == 2) {
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        cell.textLabel.text = @"N/A";
    }
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:day.date];
    NSLog(@"cell.textLabel %@", cell.textLabel.text);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableView *cell = [tableView cellForRowAtIndexPath:indexPath];
    Day *day = [self.calendar.days objectAtIndex:indexPath.row];
    day.dayType++;
    day.dayType %= 3;
    NSLog(@"%d dayType", day.dayType);
    [Calendar saveCalendarToArchive:self.calendar];
    self.donutView.percentage = [self getPercentageOfOfficeDays];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
    
}

@end
