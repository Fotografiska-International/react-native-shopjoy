//
//  ShopJoyCampaign+React.m
//  RNReactNativeShopjoy
//
//  Created by Rameez Hussain on 2017-09-21.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "ShopJoyCampaign+React.h"

@implementation ShopJoyCampaign (React)

- (id) getJson {
    return @{
             @"beaconIDs": self.beaconIDs,
             @"revision": @(self.revision),
             @"campaignID": self.campaignID,
             @"active": @(self.active),
             @"read": @(self.read),
             @"maximumProximity": @(self.maximumProximity),
             @"lastDownload": self.lastDownload,
             @"lastTrigger": self.lastTrigger,
             @"startDate": self.startDate,
             @"endDate": self.endDate,
             @"waitingForTrigger": @(self.waitingForTrigger),
             @"lastUpdated": self.lastUpdated,
             @"timeslots": self.timeslots,
             @"title": self.title,
             @"notificationText": self.notificationText,
             @"summary": self.summary,
             @"triggerDelay": @(self.triggerDelay),
             @"shopJoyContentType": @(self.shopJoyContentType),
             @"contentData": self.contentData,
             };
}

@end
