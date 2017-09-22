
package com.fotografiska;

import android.content.Context;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import se.injou.shopjoy.sdk.HistoryEntry;
import se.injou.shopjoy.sdk.Quest;
import se.injou.shopjoy.sdk.ShopJoyCallbacks;
import se.injou.shopjoy.sdk.ShopJoySDK;

public class RNReactNativeShopjoyModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private ShopJoySDK shopJoySDK;

    public RNReactNativeShopjoyModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        this.shopJoySDK = new ShopJoySDK();
        registerShopJoy();
    }

    private void registerShopJoy() {
        try {
            shopJoySDK.register(reactContext, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void initShopJoy(String apiKey, String userIdentifier) {
        try {
            shopJoySDK.setShopJoySettings(reactContext, apiKey, true, userIdentifier, null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void startMonitoring() {
        try {
            shopJoySDK.startMonitoring();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void stopMonitoring() {
        try {
            shopJoySDK.stopMonitoring();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getName() {
        return "RNReactNativeShopjoy";
    }

    public class RNReactNativeShopjoyCallbacks extends ShopJoyCallbacks {
        @Override
        public void onCampaignTriggered(Context context, HistoryEntry entry)
        {
        }
        @Override
        public void onQuestTriggered(Context context, Quest quest) {
        }
        @Override
        public void postServiceStartup(Context context) {
        }
        @Override
        public void enteredBeaconArea(Context context, String beaconID) {
        }
    }
}