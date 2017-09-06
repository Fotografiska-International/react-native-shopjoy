
import { NativeModules } from 'react-native';

const { RNReactNativeShopjoy } = NativeModules;

type ShopJoyInitOptions = {
  apiKey: string,
  userIdentifier: ?string
}

const shopJoy = {
  initShopJoy: (options: ShopJoyInitOptions = {}) => {
    return RNReactNativeShopjoy.initShopJoy(options);
  },
}

export default shopJoy;
