//
//  OWClient.m
//  coursew1
//
//  Created by nathan on 6/24/17.
//  Copyright © 2017 nathan. All rights reserved.
//

#import "OWClient.h"

@implementation OWClient

// (OWClient *) == instancetype
// Singleton
+ (instancetype)client {
    static OWClient *client;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        client = [[OWClient alloc]init];
    });
    return client;
}

- (void) getWeatherDataWithCityName: (NSString *) cityName withCompleton:(void (^)(OWCityData * data)) completion {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{ @"appid": @"c754429b335fe77b879411d16bdfdfe4", @"q": cityName };
    
    
    [ manager GET:@"http://api.openweathermap.org/data/2.5/weather"
        parameters:(params)
          progress:nil
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               NSLog(@"%@", responseObject);
               OWCityData *data = [[OWCityData alloc] initWithDictionary:responseObject];
               if (completion) {
                   completion(data);
               }
                
    }
           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"%@", error);
    }];
}

- (void) getWeatherDataWithBBOXInfo: (NSString *) bbox withCompleton:(void (^)(NSArray <OWCityData *> * datas)) completion {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{ @"appid": @"c754429b335fe77b879411d16bdfdfe4", @"bbox": bbox };
    
    
    [ manager GET:@"http://api.openweathermap.org/data/2.5/box/city"
       parameters:(params)
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@", responseObject);
              NSArray * weatherDatas = responseObject[@"list"];
              
              // Empty NSMUtablable Array lk @[]
              // or @[] mutableCopy
              NSMutableArray *datas = [NSMutableArray array];
              
              for (NSDictionary *dic in weatherDatas) {
                  OWCityData *data = [[OWCityData alloc] initWithDictionary:dic];
                  [datas addObject:data];
                  if (completion) {
                      completion(datas);
                  }
              }
              
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"%@", error);
          }];

}


@end

@implementation OWCityData
- (instancetype)initWithDictionary:(NSDictionary *) dic
{
    self = [super init];
    if (self) {
        self.cityName = dic[@"name"];
        self.main = [[OWMainData alloc] initWithDictionary:dic[@"main"]];
        NSArray *weathers = dic[@"weather"];
        self.weather = [[OWWeatherData alloc] initWithDictionary:weathers[0]];
    }
    
    return self;
}
@end

@implementation OWMainData
- (instancetype)initWithDictionary:(NSDictionary *) dic
{
    self = [super init];
    if (self) {
        self.temp = dic[@"temp"];
    }
    return self;
}
@end

@implementation OWWeatherData
- (instancetype)initWithDictionary:(NSDictionary *) dic
{
    self = [super init];
    if (self) {
        self.main = dic[@"main"];
        self.icon = dic[@"icon"];
    }
    return self;
    
}

- (NSURL *) getWeatherIconURL {
    NSString * urlString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", self.icon];
    NSURL * url = [[NSURL alloc] initWithString:urlString];
    return url;
}


@end

