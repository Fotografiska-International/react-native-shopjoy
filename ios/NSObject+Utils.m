//
//  NSObject+Utils.m
//  RNReactNativeShopjoy
//
//  Created by Rameez Hussain on 2017-09-21.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "NSObject+Utils.h"

@implementation NSObject (Utils)

- (id) getValueForSelector: (NSString *) selector withType: (id) type {
    @try {
        if ([self respondsToSelector:NSSelectorFromString(selector)]) {
            id value = [self valueForKey:selector];
            if ([value isKindOfClass:[NSDate class]]) {
                return @([((NSDate*) value) timeIntervalSince1970]);
            }
            return value;
        } else {
            return [NSNull null];
        }
    } @catch (NSException *exception) {
        NSLog(@"Error getting value for selector. %@. Type: %@", selector, type);
        return [NSNull null];
    } @finally {
    }
}

@end
