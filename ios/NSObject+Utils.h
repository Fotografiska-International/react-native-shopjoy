//
//  NSObject+Utils.h
//  RNReactNativeShopjoy
//
//  Created by Rameez Hussain on 2017-09-21.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Utils)
- (id) getValueForSelector: (NSString *) selector withType: (id) type;
@end
