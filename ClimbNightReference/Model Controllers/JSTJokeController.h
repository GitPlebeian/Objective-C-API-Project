//
//  JSTJokeController.h
//  ClimbNightReference
//
//  Created by Jackson Tubbs on 10/10/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSTJoke.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSTJokeController : NSObject

+ (instancetype)sharedInstance;
+ (void)fetchJokesWithFirstName:(NSString *)firstName lastName:(NSString *)lastName numberOfJokes:(NSInteger)numberOfJokes completion:(void (^)(NSArray<JSTJoke *> * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
