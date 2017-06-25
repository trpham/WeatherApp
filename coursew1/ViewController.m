//
//  ViewController.m
//  coursew1
//
//  Created by nathan on 6/24/17.
//  Copyright © 2017 nathan. All rights reserved.
//

#import "ViewController.h"
#import "WeatherTableViewCell.h"
#import "OWClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>



@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *data;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.data = @[];
    
    self.tableView.dataSource = self;
    // Hanlde Event, will return listeners (delegates)
    self.tableView.delegate = self;
    
//    [[OWClient client] getWeatherDataWithCityName:@"London" withCompleton:^(OWCityData *data) {
//        self.datas = @[data];
//        [self.tableView reloadData];
//    }];
//    
    
    [[OWClient client] getWeatherDataWithBBOXInfo:@"12,32,15,37,10" withCompleton: ^(NSArray <OWCityData *> *data) {
        self.data = data;
        [self.tableView reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"row %ld", indexPath.row);
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:weatherTableViewCellID];
    WeatherTableViewCell *weatherCell = (WeatherTableViewCell *) cell;
    
    OWCityData *data = self.data[indexPath.row];
    
    weatherCell.cityNameLabel.text = data.cityName;
    weatherCell.cityTempLabel.text = [NSString stringWithFormat:@"%@*C", data.main.temp];
    weatherCell.cityTempDescriptionLabel.text = [NSString stringWithFormat:@"%@", data.weather.main];
    [weatherCell.weatherIcon setImageWithURL:[data.weather getWeatherIconURL]];
    
    return weatherCell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
