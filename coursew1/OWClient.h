//
//  OWClient.h
//  coursew1
//
//  Created by nathan on 6/24/17.
//  Copyright © 2017 nathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

// data.main.temp
@interface  OWMainData : NSObject

@property (nonatomic) NSString *temp;
- (instancetype) initWithDictionary:(NSDictionary *) dic;

@end

// data.weather.icon
@interface  OWWeatherData : NSObject

@property (nonatomic) NSString *main;
//@property (nonatomic) NSString *description;
@property (nonatomic) NSString *icon;

- (instancetype) initWithDictionary:(NSDictionary *) dic;
- (NSURL *) getWeatherIconURL;

@end

// Main
// Weather
// data.name
@interface  OWCityData : NSObject

@property (nonatomic) NSString *cityName;
@property (nonatomic) OWMainData *main;
@property (nonatomic) OWWeatherData *weather;
- (instancetype) initWithDictionary:(NSDictionary *) dic;

@end


@interface OWClient : NSObject

+ (instancetype)client;
// Given a block completion
//- (void) getWeatherDataWithCityName: (NSString *) cityName withCompleton:(void (^)(OWCityData * data)) completion;
- (void) getWeatherDataWithBBOXInfo: (NSString *) bbox withCompleton:(void (^)(NSArray <OWCityData *> *data)) completion;

@end
