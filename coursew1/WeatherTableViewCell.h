//
//  WeatherTableViewCell.h
//  coursew1
//
//  Created by nathan on 6/24/17.
//  Copyright © 2017 nathan. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *weatherTableViewCellID = @"weatherCell";

@interface WeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityTempDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@end
