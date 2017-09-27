
import { NativeModules, NativeEventEmitter, Platform } from 'react-native';

const { RNReactNativeShopjoy } = NativeModules;

type ShopJoyInitOptions = {
  apiKey: string,
  userIdentifier: ?string
}

type ShopJoyCallbacks = {
  shopJoyCampaignTrigged: Function,
  shopJoyReportsOutdatedCampaign: Function,
  shopJoyQuestTrigged: ?Function,
  shopJoyEnteredBeaconArea: ?Function,
  shopJoyQuestCompleted: ?Function,
  shopJoyQuestPartlyCompleted: ?Function,
  shopJoyReportsBluetoothState: ?Function,
  shopJoyReportsBackgroundMode: ?Function,
}

const ShopJoyLogLevel = {
  none: 0,
  errors: 1,
  verbose: 2,
}

const startListeningToCallbacks = (callbacks: ShopJoyCallbacks = {}) => {
  let eventEmitter = new NativeEventEmitter(RNReactNativeShopjoy);
  eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_CAMPAIGN_TRIGGERED, callbacks.shopJoyCampaignTrigged,
    reminder => console.log(reminder.name),
  );

  if (Platform.OS === 'android') {
    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_QUEST_TRIGGERED, callbacks.shopJoyQuestTrigged,
      reminder => console.log(reminder.name),
    );

    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_ENTERED_BEACON_AREA, callbacks.shopJoyEnteredBeaconArea,
      reminder => console.log(reminder.name),
    );
  } else {
    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_REPORTS_OUTDATED_CAMPAIGN, callbacks.shopJoyReportsOutdatedCampaign,
      reminder => console.log(reminder.name),
    );

    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_QUEST_COMPLETED, callbacks.shopJoyQuestCompleted,
      reminder => console.log(reminder.name),
    );

    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_QUEST_PARTLY_COMPLETED, callbacks.shopJoyQuestPartlyCompleted,
      reminder => console.log(reminder.name),
    );

    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_REPORTS_BLUETOOTH_STATE, callbacks.shopJoyReportsBluetoothState,
      reminder => console.log(reminder.name),
    );

    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_REPORTS_BACKGROUND_MODE, callbacks.shopJoyReportsBackgroundMode,
      reminder => console.log(reminder.name),
    );
  }
};

const setLogLevel = (logLevel) => {
  if (logLevel > 2 || logLevel < 0) {
    throw "ShopJoyLogLevel should be between 0 and 2";
  } else {
    RNReactNativeShopjoy.setLogLevel(logLevel);
  }
}

const shopJoy = {
  initShopJoy: (options: ShopJoyInitOptions = {}) => {RNReactNativeShopjoy.initShopJoy(options.apiKey, options.userIdentifier);},
  startListeningToCallbacks,
  startMonitoring: () => {RNReactNativeShopjoy.startMonitoring();},
  stopMonitoring: () => {RNReactNativeShopjoy.stopMonitoring();},
  emptyMemory: () => {RNReactNativeShopjoy.emptyMemory();},
  clearHistoryNew: () => {RNReactNativeShopjoy.clearHistoryNew();},
  reloadRemoteConfiguration: () => {RNReactNativeShopjoy.reloadRemoteConfiguration();},
  openedQuest: (questId) => {RNReactNativeShopjoy.openedQuest(questId);},
  openedCampaign: (campaignId) => {RNReactNativeShopjoy.openedCampaign(campaignId);},
  // iOS only.
  returnCampaignMemory: (callback) => {RNReactNativeShopjoy.returnCampaignMemory(callback);},
  setUserIdentifier: (userIdentifier) => {RNReactNativeShopjoy.setUserIdentifier(userIdentifier);},
  version: (callback) => {RNReactNativeShopjoy.version(callback);},
  sendLogReportToShopJoyTeamWithMessage: (logReport) => {RNReactNativeShopjoy.sendLogReportToShopJoyTeamWithMessage(logReport);},
  returnQuestMemory: (callback) => {RNReactNativeShopjoy.returnQuestMemory(callback);},
  removeQuestFromMemory: (questId) => {RNReactNativeShopjoy.removeQuestFromMemory(questId);},
  removeCampaignFromMemory: (campaignId) => {RNReactNativeShopjoy.removeCampaignFromMemory(campaignId);},
  campaignWithId: (campaignId, callback) => {RNReactNativeShopjoy.campaignWithId(campaignId, callback);},
  questWithId: (questId, callback) => {RNReactNativeShopjoy.questWithId(questId, callback);},
  setLogLevel
}

export {
  shopJoy,
  ShopJoyLogLevel
};
