
#import "RNReactNativeShopjoy.h"
#import "ShopJoyHeaders.h"

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

RCT_EXPORT_METHOD(startMonitoring)
{
    [self.shopJoyManager startMonitoring];
}

RCT_EXPORT_METHOD(stopMonitoring)
{
    [self.shopJoyManager stopMonitoring];
}

#pragma mark - Private methods.

- (void)handleNotification:(NSNotification *)notification {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self sendEventWithName:notification.name body:notification.userInfo];
}

#pragma mark - Delegate methods.

- (void)shopJoyCampaignTriggered:(ShopJoyCampaign *)campaign {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyCampaignTriggered withPayload: @{@"data" : @"test: campaign triggered"}];
}

- (void)shopJoyReportsOutdatedCampaign:(NSString *)campaignID {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyReportsOutdatedCampaign withPayload: @{@"message" : @"Reporting outdated campaign", @"data": campaignID}];
}

- (void)shopJoyQuestCompleted:(ShopJoyQuest *)quest {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyQuestCompleted withPayload: @{@"message" : @"Quest completed", @"data": quest}];
}

- (void)shopJoyQuestPartlyCompleted:(ShopJoyQuest *)quest {
    NSLog(@"%s %s", __PRETTY_FUNCTION__, __FUNCTION__);
    [self postNotificationName: kShopJoyQuestPartlyCompleted withPayload: @{@"message" : @"Quest partly completed", @"data": quest}];
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

