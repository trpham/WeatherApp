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
@property (nonatomic) NSArray *datas;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.datas = @[];
    
    self.tableView.dataSource = self;
    // Hanlde Event, will return listeners (delegates)
    self.tableView.delegate = self;
    
//    [[OWClient client] getWeatherDataWithCityName:@"London" withCompleton:^(OWCityData *data) {
//        self.datas = @[data];
//        [self.tableView reloadData];
//    }];
//    
//    12,32,15,37,10
    
    [[OWClient client] getWeatherDataWithBBOXInfo:@"12,32,15,37,10" withCompleton: ^(NSArray <OWCityData *> *datas) {
        self.datas = datas;
        [self.tableView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWeatherTableViewCell];
    WeatherTableViewCell *customCell = (WeatherTableViewCell *) cell;
    
    OWCityData * data = self.datas[indexPath.row];
    
    customCell.cityNameLabel.text = data.cityName;
    customCell.cityTempLabel.text = [NSString stringWithFormat:@"%@*C", data.main.temp];
    [customCell.weatherIcon setImageWithURL:[data.weather getWeatherIconURL]];
    
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"row %ld", indexPath.row);
}

@end
