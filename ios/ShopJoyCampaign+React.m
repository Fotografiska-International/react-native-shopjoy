//
//  ShopJoyCampaign+React.m
//  RNReactNativeShopjoy
//
//  Created by Rameez Hussain on 2017-09-21.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "ShopJoyCampaign+React.h"
#import "NSObject+Utils.h"

#define kBeaconIDs @"beaconIDs"
#define kRevision @"revision"
#define kCampaignID @"campaignID"
#define kBaseCampaignID @"baseCampaignID"
#define kActive @"active"
#define kRead @"read"
#define kTriggerRange @"triggerRange"
#define kLastDownload @"lastDownload"
#define kLastTrigger @"lastTrigger"
#define kStartDate @"startDate"
#define kEndDate @"endDate"
#define kWaitingForTrigger @"waitingForTrigger"
#define kLastUpdated @"lastUpdated"
#define kTimeslots @"timeslots"
#define kTitle @"title"
#define kNotificationText @"notificationText"
#define kSummary @"summary"
#define kTriggerDelay @"triggerDelay"
#define kShopJoyContentType @"shopJoyContentType"
#define kContentData @"contentData"
#define kMaximumProximity @"maximumProximity"

@implementation ShopJoyCampaign (React)

- (id) getJson {
    @try {
        return @{
                 kBeaconIDs: [self getValueForSelector:kBeaconIDs withType: [NSArray class]],
                 kRevision: [self getValueForSelector:kRevision withType: [NSNumber class]],
                 kCampaignID: [self getValueForSelector:kCampaignID withType: [NSString class]],
                 kActive: [self getValueForSelector:kActive withType: [NSNumber class]],
                 kRead: [self getValueForSelector:kRead withType: [NSNumber class]],
                 kMaximumProximity: [self getValueForSelector:kMaximumProximity withType: [NSNumber class]],
                 kLastDownload: [self getValueForSelector:kLastDownload withType: [NSDate class]],
                 kLastTrigger: [self getValueForSelector:kLastTrigger withType: [NSDate class]],
                 kStartDate: [self getValueForSelector:kStartDate withType: [NSDate class]],
                 kEndDate: [self getValueForSelector:kEndDate withType: [NSDate class]],
                 kWaitingForTrigger: [self getValueForSelector:kWaitingForTrigger withType: [NSNumber class]],
                 kLastUpdated: [self getValueForSelector:kLastUpdated withType: [NSDate class]],
                 kTimeslots: [self getValueForSelector:kTimeslots withType: [NSArray class]],
                 kTitle: [self getValueForSelector:kTitle withType: [NSString class]],
                 kNotificationText: [self getValueForSelector:kNotificationText withType: [NSString class]],
                 kSummary: [self getValueForSelector:kSummary withType: [NSString class]],
                 kTriggerDelay: [self getValueForSelector:kTriggerDelay withType: [NSNumber class]],
                 kShopJoyContentType: [self getValueForSelector:kShopJoyContentType withType: [NSNumber class]],
                 kContentData: [self getValueForSelector:kContentData withType: [NSString class]],
                 };
    } @catch (NSException *exception) {
        NSLog(@"Error getting JSON. %@", exception.description);
        return @{};
    } @finally {
    }
}

@end
