
import { NativeModules, NativeEventEmitter } from 'react-native';

const { RNReactNativeShopjoy } = NativeModules;

type ShopJoyInitOptions = {
  apiKey: string,
  userIdentifier: ?string
}

type ShopJoyCallbacks = {
  shopJoyCampaignTrigged: Function,
  shopJoyReportsOutdatedCampaign: Function,
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

const shopJoy = {
  initShopJoy: (options: ShopJoyInitOptions = {}) => {
    RNReactNativeShopjoy.initShopJoy(options.apiKey, options.userIdentifier);
  },
  startListeningToCallbacks: (callbacks: ShopJoyCallbacks = {}) => {
    let eventEmitter = new NativeEventEmitter(RNReactNativeShopjoy);
    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_CAMPAIGN_TRIGGERED, callbacks.shopJoyCampaignTrigged,
      reminder => console.log(reminder.name),
    );

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
  },
  startMonitoring: () => {RNReactNativeShopjoy.startMonitoring();},
  stopMonitoring: () => {RNReactNativeShopjoy.stopMonitoring();},
  emptyMemory: () => {RNReactNativeShopjoy.emptyMemory();},
  setUserIdentifier: (userIdentifier) => {RNReactNativeShopjoy.setUserIdentifier(userIdentifier);},
  version: (callback) => {RNReactNativeShopjoy.version(callback);},
  setLogLevel: (logLevel) => {
    if (logLevel > 2 || logLevel < 0) {
      throw "ShopJoyLogLevel should be between 0 and 2";
    } else {
      RNReactNativeShopjoy.setLogLevel(logLevel);
    }
  }
}

export {
  shopJoy,
  ShopJoyLogLevel
};
