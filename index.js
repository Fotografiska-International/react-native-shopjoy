
import { NativeModules, NativeEventEmitter } from 'react-native';

const { RNReactNativeShopjoy } = NativeModules;

type ShopJoyInitOptions = {
  apiKey: string,
  userIdentifier: ?string
}

type ShopJoyCallbacks = {
  shopJoyCampaignTrigged: Function,
  shopJoyReportsOutdatedCampaign: Function,
}

const shopJoy = {
  initShopJoy: (options: ShopJoyInitOptions = {}) => {
    RNReactNativeShopjoy.initShopJoy(options.apiKey, options.userIdentifier);
  },
  startListening: (callbacks: ShopJoyCallbacks = {}) => {
    let eventEmitter = new NativeEventEmitter(RNReactNativeShopjoy);
    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_CAMPAIGN_TRIGGERED, callbacks.shopJoyCampaignTrigged,
      reminder => console.log(reminder.name),
    );

    eventEmitter.addListener(RNReactNativeShopjoy.SHOP_JOY_REPORTS_OUTDATED_CAMPAIGN, callbacks.shopJoyReportsOutdatedCampaign,
      reminder => console.log(reminder.name),
    );
  }
}

export default shopJoy;
