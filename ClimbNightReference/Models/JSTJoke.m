//
//  JSTJoke.m
//  ClimbNightReference
//
//  Created by Jackson Tubbs on 10/10/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

#import "JSTJoke.h"

// We keys for good deisng practices so if the api changes we change the key only in one place
static NSString * const jokeKey = @"joke";
static NSString * const categoriesKey = @"categories";

@implementation JSTJoke
    // Initializer
- (JSTJoke *)initWithJoke:(NSString *)joke categories:(NSArray<NSString *> *)categories
{
    self = [super init];
    if (self)
    {
        _joke = joke;
        _categories = categories;
    }
    return self;
}

@end

@implementation JSTJoke (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *joke = dictionary[jokeKey];
    NSArray *categories = dictionary[categoriesKey];
    
    return [self initWithJoke:joke categories:categories];
}

@end
