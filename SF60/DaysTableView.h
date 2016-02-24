//
//  DaysTableView.h
//  SF60
//
//  Created by Estevan Hernandez on 2/22/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaysTableView : UITableView <UITableViewDataSource>
@property (strong, nonatomic) NSArray *days;
@property (strong, nonatomic) IBOutlet UIButton *addDayButton;

@end
