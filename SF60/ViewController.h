//
//  ViewController.h
//  SF60
//
//  Created by Estevan Hernandez on 2/22/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"
#import "Calendar.h"
#import "MCPercentageDoughnutView.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) Calendar *calendar;
@property (strong, nonatomic) IBOutlet UIButton *addDayButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet MCPercentageDoughnutView *donutView;

@end

