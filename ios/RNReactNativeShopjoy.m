
#import "RNReactNativeShopjoy.h"
#import "ShopJoyHeaders.h"
#import "NSObject+Utils.h"

NSString *const kShopJoyCampaignTriggered = @"shopJoyCampaignTriggered";
NSString *const kShopJoyReportsOutdatedCampaign = @"shopJoyReportsOutdatedCampaign";
NSString *const kShopJoyQuestCompleted = @"shopJoyQuestCompleted";
NSString *const kShopJoyQuestPartlyCompleted = @"shopJoyQuestPartlyCompleted";
NSString *const kShopJoyReportsBluetoothState = @"shopJoyReportsBluetoothState";
NSString *const kShopJoyReportsBackgroundMode = @"shopJoyReportsBackgroundMode";


@interface RNReactNativeShopjoy()

@property(nonatomic, retain) ShopJoyManager *shopJoyManager;

@end

@implementation RNReactNativeShopjoy

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

- (NSDictionary<NSString *, NSString *> *)constantsToExport {
    return @{ @"SHOP_JOY_CAMPAIGN_TRIGGERED": kShopJoyCampaignTriggered,
              @"SHOP_JOY_REPORTS_OUTDATED_CAMPAIGN": kShopJoyReportsOutdatedCampaign,
              @"SHOP_JOY_QUEST_COMPLETED": kShopJoyQuestCompleted,
              @"SHOP_JOY_QUEST_PARTLY_COMPLETED": kShopJoyQuestPartlyCompleted,
              @"SHOP_JOY_REPORTS_BLUETOOTH_STATE": kShopJoyReportsBluetoothState,
              @"SHOP_JOY_REPORTS_BACKGROUND_MODE": kShopJoyReportsBackgroundMode,
              };
}

- (NSArray<NSString *> *)supportedEvents {
    return @[
             kShopJoyCampaignTriggered,
             kShopJoyReportsOutdatedCampaign,
             kShopJoyQuestCompleted,
             kShopJoyQuestPartlyCompleted,
             kShopJoyReportsBluetoothState,
             kShopJoyReportsBackgroundMode
             ];
}

- (void)startObserving
{
    for (NSString *event in [self supportedEvents]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:event
                                                   object:nil];
    }
}

- (void)stopObserving
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public methods.

RCT_EXPORT_METHOD(initShopJoy: (NSString *) apiKey userIdentifier: (NSString *) userIdentifier)
{
    self.shopJoyManager = [[ShopJoyManager alloc] initWithAPIKey:apiKey logLevel:ShopJoyLogLevelVerbose userIdentifier:userIdentifier idfa:nil delegate:self];
}

RCT_EXPORT_METHOD(setUserIdentifier: (NSString *) userIdentifier)
{
    [self.shopJoyManager setUserIdentifier:userIdentifier];
}

RCT_EXPORT_METHOD(version: (RCTResponseSenderBlock) callback)
{
    NSString *version = [self.shopJoyManager version];
     callback(@[version]);
}

RCT_EXPORT_METHOD(startMonitoring)
{
    [self.shopJoyManager startMonitoring];
}

RCT_EXPORT_METHOD(stopMonitoring)
{
    [self.shopJoyManager stopMonitoring];
}

RCT_EXPORT_METHOD(emptyMemory)
{
    [self.shopJoyManager emptyMemory];
}

RCT_EXPORT_METHOD(setLogLevel: (NSInteger) logLevel)
{
    [self.shopJoyManager setLogLevel:(ShopJoyLogLevel)logLevel];
}

RCT_EXPORT_METHOD(sendLogReportToShopJoyTeamWithMessage: (NSString *) logReport)
{
    [self.shopJoyManager sendLogReportToShopJoyTeamWithMessage:logReport];
}

RCT_EXPORT_METHOD(returnQuestMemory: (RCTResponseSenderBlock) callback)
{
    NSArray *questMemory = [self.shopJoyManager returnQuestMemory];
    NSMutableArray *serializedQuests = [NSMutableArray new];
    for (ShopJoyCampaign *quest in questMemory) {
        [serializedQuests addObject:[quest getAsDictionary]];
    }
    callback(@[serializedQuests]);
}

RCT_EXPORT_METHOD(returnCampaignMemory: (RCTResponseSenderBlock) callback)
{
    NSArray *campaignMemory = [self.shopJoyManager returnCampaignMemory];
    NSMutableArray *serializedCampaigns = [NSMutableArray new];
    for (ShopJoyCampaign *campaign in campaignMemory) {
        [serializedCampaigns addObject:[campaign getAsDictionary]];
    }
    callback(@[serializedCampaigns]);
}

RCT_EXPORT_METHOD(removeCampaignFromMemory: (NSString *) campaignId)
{
    @try {
        ShopJoyCampaign *campaignToRemove = [self.shopJoyManager campaignWithId:campaignId];
        [self.shopJoyManager removeCampaignFromMemory:campaignToRemove];
    } @catch (NSException *exception) {
        NSLog(@"Error removing campaign: %@", exception.description);
    } @finally {
    }
}

RCT_EXPORT_METHOD(removeQuestFromMemory: (NSString *) questId)
{
    @try {
        ShopJoyQuest *questToRemove = [self.shopJoyManager questWithId:questId];
        [self.shopJoyManager removeQuestFromMemory:questToRemove];
    } @catch (NSException *exception) {
        NSLog(@"Error removing quest: %@", exception.description);
    } @finally {
    }
}

RCT_EXPORT_METHOD(campaignWithId: (NSString *) campaignId callback: (RCTResponseSenderBlock) callback)
{
    @try {
        ShopJoyCampaign *campaign = [self.shopJoyManager campaignWithId:campaignId];
        callback(@[[campaign getAsDictionary]]);
    } @catch (NSException *exception) {
        NSLog(@"Error getting campaign with ID (%@): %@", campaignId, exception.description);
    } @finally {
    }
}

RCT_EXPORT_METHOD(questWithId: (NSString *) questId callback: (RCTResponseSenderBlock) callback)
{
    @try {
        ShopJoyQuest *quest = [self.shopJoyManager questWithId:questId];
        callback(@[[quest getAsDictionary]]);
    } @catch (NSException *exception) {
        NSLog(@"Error getting quest with ID (%@): %@", questId, exception.description);
    } @finally {
    }
}

RCT_EXPORT_METHOD(reloadRemoteConfiguration)
{
    [self.shopJoyManager reloadRemoteConfiguration];
}

RCT_EXPORT_METHOD(openedQuest: (NSString *) questId)
{
    @try {
        ShopJoyQuest *quest = [self.shopJoyManager questWithId:questId];
        [self.shopJoyManager openedQuest:quest];
    } @catch (NSException *exception) {
        NSLog(@"Error setting quest as opened: %@", exception.description);
    } @finally {
    }
}

RCT_EXPORT_METHOD(openedCampaign: (NSString *) campaignId)
{
    @try {
        ShopJoyCampaign *campaign = [self.shopJoyManager campaignWithId:campaignId];
        [self.shopJoyManager openedCampaign:campaign];
    } @catch (NSException *exception) {
        NSLog(@"Error setting campaign as opened: %@", exception.description);
    } @finally {
    }
}

#pragma mark - Private methods.

- (void)handleNotification:(NSNotification *)notification {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self sendEventWithName:notification.name body:notification.userInfo];
}

#pragma mark - Delegate methods.

- (void)shopJoyCampaignTriggered:(ShopJoyCampaign *)campaign {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyCampaignTriggered withPayload: @{@"data" : [campaign getAsDictionary]}];
}

- (void)shopJoyReportsOutdatedCampaign:(NSString *)campaignID {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyReportsOutdatedCampaign withPayload: @{@"message" : @"Reporting outdated campaign", @"data": campaignID}];
}

- (void)shopJoyQuestCompleted:(ShopJoyQuest *)quest {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyQuestCompleted withPayload: @{@"message" : @"Quest completed", @"data": [quest getAsDictionary]}];
}

- (void)shopJoyQuestPartlyCompleted:(ShopJoyQuest *)quest {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyQuestPartlyCompleted withPayload: @{@"message" : @"Quest partly completed", @"data": [quest getAsDictionary]}];
}

- (void)shopJoyReportsBluetoothState:(Boolean)ready {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyReportsBluetoothState withPayload: @{@"message" : @"Reports bluetooth state", @"data": @(ready)}];
}

- (void)shopJoyReportsBackgroundMode:(Boolean)enabled {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyReportsBackgroundMode withPayload: @{@"message" : @"Reports background mode", @"data": @(enabled)}];
}

- (void)postNotificationName:(NSString *)name withPayload:(NSDictionary *)payload {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:self
                                                      userInfo:payload];
}


@end

