
#import "RNReactNativeShopjoy.h"
#import "ShopJoyHeaders.h"

NSString *const kShopJoyCampaignTriggered = @"shopJoyCampaignTriggered";
NSString *const kShopJoyReportsOutdatedCampaign = @"shopJoyReportsOutdatedCampaign";

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
              };
}

- (NSArray<NSString *> *)supportedEvents {
    return @[kShopJoyCampaignTriggered, kShopJoyReportsOutdatedCampaign];
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

#pragma mark - Private methods.

- (void)handleNotification:(NSNotification *)notification {
    [self sendEventWithName:notification.name body:notification.userInfo];
}

#pragma mark - Delegate methods.

- (void)shopJoyCampaignTriggered:(ShopJoyCampaign *)campaign {
    NSLog(@"ShopJoy campaign triggered");
    [self postNotificationName: kShopJoyCampaignTriggered withPayload: @{@"data" : @"test: campaign triggered"}];
}

- (void)shopJoyReportsOutdatedCampaign:(NSString *)campaignID {
    NSLog(@"ShopJoy reports outdated campaign");
    [self postNotificationName: kShopJoyReportsOutdatedCampaign withPayload: @{@"message" : @"Reporting outdated campaign", @"data": campaignID}];
}

- (void)postNotificationName:(NSString *)name withPayload:(NSDictionary *)payload {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:self
                                                      userInfo:payload];
}


@end

