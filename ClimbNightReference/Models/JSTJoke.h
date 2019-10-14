//
//  JSTJoke.h
//  ClimbNightReference
//
//  Created by Jackson Tubbs on 10/10/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSTJoke : NSObject

@property (nonatomic, copy, readonly) NSString *joke;
@property (nonatomic, copy, readonly) NSArray<NSString *> *categories;

- (JSTJoke *)initWithJoke:(NSString *)joke
                            // <NSString *> Defines that array contains String
               categories:(NSArray<NSString *> *)categories;

@end
                // Name for Extension
@interface  JSTJoke (JSONConvertable)

    // Convenience initializer                light weight generics v : Key is a string, Value is of type any using
- (instancetype) initWithDictionary: (NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END

