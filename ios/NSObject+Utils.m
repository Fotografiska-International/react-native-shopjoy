//
//  NSObject+Utils.m
//  RNReactNativeShopjoy
//
//  Created by Rameez Hussain on 2017-09-21.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "NSObject+Utils.h"
#import <objc/runtime.h>

@implementation NSObject (Utils)

- (id) getAsDictionary {
    NSMutableDictionary *finalDict = [NSMutableDictionary new];
    NSArray *properties = [self allPropertyNames];
    for (NSString *property in properties) {
        [finalDict setValue:[self getValueForSelector:property] forKey:property];
    }
    return finalDict;
}

- (id) getValueForSelector: (NSString *) selector {
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
        NSLog(@"Error getting value for selector. %@.", selector);
        return [NSNull null];
    } @finally {
    }
}

- (NSArray *)allPropertyNames
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}

@end
