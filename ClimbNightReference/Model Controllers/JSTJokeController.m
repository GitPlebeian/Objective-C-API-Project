//
//  JSTJokeController.m
//  ClimbNightReference
//
//  Created by Jackson Tubbs on 10/10/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

#import "JSTJokeController.h"

static NSString * const baseURLString = @"http://api.icndb.com";
static NSString * const jokeRouteString = @"jokes";
static NSString * const randomJokesRouteString = @"random";
static NSString * const limitToCategoriesString = @"[nerdy, explicit]";

static NSString * const firstNameKey = @"firstName";
static NSString * const lastNameKey = @"lastName";
static NSString * const limitCatagoriesKey = @"limitTo";

@implementation JSTJokeController

+ (instancetype)sharedInstance
{
    static JSTJokeCntroller *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[JSTJokeController alloc] init];
    });
    return sharedInstance;
}

+ (void)fetchJokesWithFirstName:(NSString *)firstName lastName:(NSString *)lastName numberOfJokes:(NSInteger)numberOfJokes completion:(void (^)(NSArray<JSTJoke *> * _Nullable))completion
{
    // Step 1: Build URL
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *jokesURL = [baseURL URLByAppendingPathComponent:jokeRouteString];
    NSURL *randomJokesURL = [jokesURL URLByAppendingPathComponent:randomJokesRouteString];
    NSURL *numberOfJokesURL = [randomJokesURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%li", (long)numberOfJokes]];
    
    NSURLQueryItem *firstNameQuery = [[NSURLQueryItem alloc] initWithName:firstNameKey value:firstName];
    NSURLQueryItem *lastNameQuery = [[NSURLQueryItem alloc] initWithName:lastNameKey value:lastName];
    NSURLQueryItem *limitToQuery = [[NSURLQueryItem alloc] initWithName:limitCatagoriesKey value:@"[nerdy,explicit]"];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:numberOfJokesURL resolvingAgainstBaseURL:true];
    components.queryItems = @[firstNameQuery, lastNameQuery, limitToQuery];
    
    NSURL *finalURL = components.URL;
    
    NSLog(@"Final URL: %@", finalURL.absoluteString);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil)
        {
            NSLog(@"Long Error: %@\nShort Error: %@", error.description, error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (response != nil)
        {
            NSLog(@"%@", response);
        }
        
        if (data != nil)
        {
            NSDictionary *jokesDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error][@"value"];
            
            if (jokesDictionary == nil) {
                NSLog(@"Error parsing JSON data: %@", error);
                completion(nil);
                return;
            }
            
            NSMutableArray *jokesArray = [[NSMutableArray alloc] init];
            for (NSDictionary *jokeDictionary in jokesDictionary)
            {
                JSTJoke *joke = [[JSTJoke alloc] initWithDictionary:jokeDictionary];
                [jokesArray addObject:joke];
            }
            
            NSLog(@"Dicitonary: %@", jokesDictionary);
            completion(jokesArray);
        }
    }] resume];
}

@end
