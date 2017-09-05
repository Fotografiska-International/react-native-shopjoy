//
//  ShopJoyHeaders.h
//  ShopJoySDK
//
//  Copyright (c) 2014 ShopJoy. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

/*! @abstract ShopJoyLogLevel */
typedef NS_ENUM(int, ShopJoyLogLevel) {
    /*! ShopJoy will not log at all */
    ShopJoyLogLevelNone,
    /*! ShopJoy will log errors */
    ShopJoyLogLevelErrors,
    /*! ShopJoy will log everything */
    ShopJoyLogLevelVerbose
};

/*! @abstract ShopJoyContentType */
typedef NS_ENUM(int, ShopJoyContentType) {
    /*! unknown content type */
    ShopJoyContentTypeUnknown,
    /*! raw HTML content */
    ShopJoyContentTypeHTML,
    /*! no content, campaign is meant to be for notifications only */
    ShopJoyContentTypePush,
    /*! text content */
    ShopJoyContentTypeText,
    /*! the content is an URL */
    ShopJoyContentTypeURL,
    /*! the content is a Facebook ID */
    ShopJoyContentTypeFacebook,
    /*! the content is an Instagram ID */
    ShopJoyContentTypeInstagram,
    /*! the content is a Twitter ID */
    ShopJoyContentTypeTwitter,
    /*! the content is a DirectSmile URL */
    ShopJoyContentTypeDirectSmile
};

/*! @abstract ShopJoyCampaign.*/
@interface ShopJoyCampaign : NSObject <NSCoding>
/*! @abstract The ID(s) of the iBeacon(s) that belong to the campaign. This id has the format of UUID-major-minor. */
@property NSArray *beaconIDs;
/*! @abstract The revision of the campaign. Will change when the campaign is changed in the CMS. */
@property NSInteger revision;
/*! @abstract The current ID of the campaign. This ID never changes for the same campaign.  */
@property NSString *campaignID;
/*! @abstract The original ID of the campaign. This ID never changes. */
/*! @abstract A boolean representing whether the campaign is active or not. 1 = active. */
@property Boolean active;
/*! @abstract A boolean representing whether the campaign has been read or not. 1 = read. */
@property Boolean read;
/*! @abstract The maximum proximity to trigger the campaign. Corresponds to CLProximity. 1 is closest. */
@property CLProximity maximumProximity;
/*! @abstract When the campaign is last downloaded */
@property NSDate *lastDownload;
/*! @abstract When the campaign is last triggered. */
@property NSDate *lastTrigger;
/*! @abstract The start date of the campaign. */
@property NSDate *startDate;
/*! @abstract The end date of the campaign. Always check this property to prevent presenting expired campaigns! */
@property NSDate *endDate;
/*! @abstract waitingForTrigger is true when the campaign is changed in the CMS, and will trigger again when possible. */
@property Boolean waitingForTrigger;
/*! @abstract The last update of the campaign in the CMS. */
@property NSDate *lastUpdated;
/*! @abstract The timeslots in which a campaign is valid. If empty, the campaign is valid the whole day. Always check this property to prevent presenting a campaign outside of (one of) it's timeslot(s)! */
@property NSArray *timeslots;
/*! @abstract The title of the campaign. */
@property NSString *title;
/*! @abstract The notification text of the campaign. Exactly the same as summary, but with a fix for displaying %-signs in UILocalNotification alertBody */
@property NSString *notificationText;
/*! @abstract The summary text of the campaign. Exactly the same as notificationText, but WITHOUT a fix for displaying %-signs in UILocalNotification alertBody. This string is exactly the same as the string set in the CMS. */
@property NSString *summary;
/*! @abstract The trigger delay (in seconds) of the campaign. When expired, the campaign can trigger again. */
@property NSInteger triggerDelay;
/*! @abstract The ShopJoyContentType of the campaign*/
@property ShopJoyContentType shopJoyContentType;
/*! @abstract The content data. HTML or URL. */
@property NSString *contentData;
@end

/*! @abstract ShopJoyQuest. */
@interface ShopJoyQuest : NSObject <NSCoding>
/*! @abstract The ID of the quest. */
@property NSString *questID;
/*! @abstract A boolean representing whether the quest is active or not. 1 = active. */
@property Boolean active;
/*! @abstract A boolean representing whether the campaign has been read or not. 1 = read. */
@property Boolean read;
/*! @abstract When the quest is last downloaded */
@property NSDate *lastDownload;
/*! @abstract When the quest is last triggered. */
@property NSDate *lastTrigger;
/*! @abstract The start date of the quest. */
@property NSDate *startDate;
/*! @abstract The end date of the quest. Always check this property to prevent presenting expired quests! */
@property NSDate *endDate;
/*! @abstract The title of the quest. */
@property NSString *title;
/*! @abstract waitingForTrigger is true when the quest is changed in the CMS, and will trigger again when possible. */
@property Boolean waitingForTrigger;
/*! @abstract The last update of the quest in the CMS. */
@property NSDate *lastUpdated;
/*! @abstract The notification text of the quest. Exactly the same as summary, but with a fix for displaying %-signs in UILocalNotification alertBody */
@property NSString *notificationText;
/*! @abstract The summary text of the quest. Exactly the same as notificationText, but WITHOUT a fix for displaying %-signs in UILocalNotification alertBody. This string is exactly the same as the string set in the CMS. */
@property NSString *summary;
/*! @abstract The campaigns that are linked to this quest. */
@property NSArray *campaignIDs;
/*! @abstract The ShopJoyContentType of the campaign*/
@property ShopJoyContentType shopJoyContentType;
/*! @abstract The content data. */
@property NSString *contentData;
@end

/*! @abstract ShopJoyManagerDelegate. Belongs to the ShopJoyManager object. */
@protocol ShopJoyManagerDelegate
/*!
 @abstract Will be called when a campaign is triggered.
 @return void
 @param campaign The ShopJoyCampaign object corresponding to the campaign that has been triggered
 */
- (void)shopJoyCampaignTriggered:(ShopJoyCampaign *)campaign;
/*!
 @abstract Will be called when an outdated campaign is opened by the user.
 @return void
 @param campaign The outdated ShopJoyCampaign
 */
- (void)shopJoyReportsOutdatedCampaign:(ShopJoyCampaign *)campaign;
@optional
/*!
 @abstract This method will be called when a quest is completed.
 @param quest The completed quest
 @return void
 */
- (void)shopJoyQuestCompleted:(ShopJoyQuest *)quest;
/*!
 @abstract This method will be called when a quest is partly, completed, so when a campaign beloning to a quest is fired.
 @param quest The completed quest
 @return void
 */
- (void)shopJoyQuestPartlyCompleted:(ShopJoyQuest *)quest;
/*!
 @abstract Will be called when the device's Bluetooth state has changed. This method can be used to present or hide a warning message.
 @return void
 @param ready A boolean representing the device's Bluetooth state.
 */
- (void)shopJoyReportsBluetoothState:(Boolean)ready;
/*!
 @abstract Will report the device's background mode. This method can be used to present or hide a warning message.
 @return void
 @param enabled A boolean representing the device's background mode state.
 */
- (void)shopJoyReportsBackgroundMode:(Boolean)enabled;
@end

/*!
 @abstract Initialize ShopJoyManager and set/implement it's delegate to start receiving ShopJoy campaign notifications.
 @return void
 */
@interface ShopJoyManager : NSObject

/*!
 @abstract Returns the shared instance of ShopJoyManager
 @return ShopJoyManager
 */
+ (ShopJoyManager *)sharedInstance;
/*!
 @abstract Initialize a ShopJoyManager object. Provide a valid API key, enable/disable logging (XCode console logs about what is going on "under the hood" of the ShopJoyManager) and, optionally, set a user identifier. This is a unique key to identify individual users in ShopJoy's analytics. If not provided, a random UUID will be used and stored on the user's device. This UUID will be lost on device change.
 @return id
 @param key A ShopJoy API key.
 @param logLevel A ShopJoyLogLevel representing the level of detail ShopJoy should log.
 @param identifier Any string that is unique for the user. If not provided, the SDK will create, store and use a random UUID. When a ShopJoy user logs in later on, this ID is overwritten.
 @param idfa The IDFA of the installation.
 @param delegate Set the delegate for ShopJoy methods here.
 */
- (id)initWithAPIKey:(NSString *)key logLevel:(ShopJoyLogLevel)logLevel userIdentifier:(NSString *)identifier idfa:(NSString *)idfa delegate:(id)delegate;
/*!
 @abstract Use this method to change the userID.
 @param identifier A NSString as user identifier.
 @return void.
 */
- (void)setUserIdentifier:(NSString *)identifier;
/*!
 @abstract Use this method to change the level of logging.
 @param logLevel A ShopJoyLogLevel representing the level of detail ShopJoy should log.
 @return void.
 */
- (void)setLogLevel:(ShopJoyLogLevel)logLevel;
/*!
 @abstract Starts the monitoring for ShopJoy campaigns. If necessary, this method will invoke a Location Services permission request
 @return void
 */
- (void)startMonitoring;
/*!
 @abstract Stops the monitoring for ShopJoy campaigns.
 @return void
 */
- (void)stopMonitoring;
/*!
 @abstract Call to empty ShopJoyManager's campaign and quest memory. After calling this method all found beacons/campaigns will be considered "new".
 @return void
 */
- (void)emptyMemory;
/*!
 @abstract Call to remove a specific campaign from ShopJoyManager's memory.
 @param campaign The ShopJoyCampaign object that should be removed from memory
 @return void
 */
- (void)removeCampaignFromMemory:(ShopJoyCampaign *)campaign;
/*!
 @abstract Call to mark a specific campaign in ShopJoyManager's memory as read, and at the same time check it's validity. If a campaign is invalid, the shopJoyReportsOutdatedCampaign: method will be called. This method will log an analytics event to the CMS.
 @param campaign The ShopJoyCampaign object that should be marked as read
 @return void
 */
- (void)openedCampaign:(ShopJoyCampaign *)campaign;
/*!
 @abstract Returns an array with all ShopJoyCampaign objects that have been encountered. The emptyCampaignMemory method will empty this memory. Always check the "active" properties before presenting it to a user.
 @return NSArray.
 */
- (NSArray *)returnCampaignMemory;
/*!
 @abstract This method returns a ShopJoyCampaign object corresponding to the supplied BaseCampaignID. Returns nil if no corresponding campaign is found.
 @param campaignID The BaseCampaignID
 @return ShopJoyCampaign.
 */
- (ShopJoyCampaign *)campaignWithId:(NSString *)campaignID;

// QUESTS
/*!
 @abstract Call to remove a specific quest from ShopJoyManager's memory.
 @param quest The ShopJoyQuest object that should be removed from memory
 @return void
 */
- (void)removeQuestFromMemory:(ShopJoyQuest *)quest;
/*!
 @abstract Call to mark a specific quest in ShopJoyManager's memory as read. This method will log an analytics event to the CMS.
 @param quest The ShopJoyQuest object that should be marked as read
 @return void
 */
- (void)openedQuest:(ShopJoyQuest *)quest;
/*!
 @abstract Returns an array with all ShopJoyQuest objects that have been encountered. The emptyCampaignMemory method will empty this memory. Always check the "active" properties before presenting it to a user.
 @return NSArray.
 */
- (NSArray *)returnQuestMemory;
/*!
 @abstract This method returns a ShopJoyQuest object corresponding to the supplied quest ID. Returns nil if no corresponding quest is found.
 @param questID The quest ID
 @return ShopJoyQuest.
 */
- (ShopJoyQuest *)questWithId:(NSString *)questID;
/*!
 @abstract Returns the current version of the SDK
 @return NSString.
 */
- (NSString *)version;
/*!
 @abstract Send the current session's log to ShopJoy's dev team.
 @param message A message: what should be checked in particular?
 */
- (void)sendLogReportToShopJoyTeamWithMessage:(NSString *)message;
/*!
 @abstract Reload the remote configuration.
 */
- (void)reloadRemoteConfiguration;

/*!
 @abstract ShopJoyManagerDelegate
 */
@property (weak, nonatomic) id<ShopJoyManagerDelegate> delegate;
@end