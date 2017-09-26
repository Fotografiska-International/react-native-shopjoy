
package com.fotografiska;

import android.content.Context;
import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import se.injou.shopjoy.sdk.HistoryEntry;
import se.injou.shopjoy.sdk.Quest;
import se.injou.shopjoy.sdk.ShopJoyCallbacks;
import se.injou.shopjoy.sdk.ShopJoySDK;

public class RNReactNativeShopjoyModule extends ReactContextBaseJavaModule {

    private static String TAG = "RNShopJoyModule";
    private ReactApplicationContext reactContext;
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

            shopJoySDK.setCallback(new ShopJoySDK.TriggeredCampaignCallback() {
                @Override
                public void triggeredCampaign(HistoryEntry historyEntry, int i) {
                    Log.d(TAG, "Triggered campaign: "+historyEntry.toString()+", number: "+i);
                }
            });
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

    @ReactMethod
    public void emptyMemory() {
        try {
            shopJoySDK.clearAllCache();
            shopJoySDK.clearAllHistory();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void reloadRemoteConfiguration() {
        try {
            shopJoySDK.updateConfigFile(reactContext);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getName() {
        return "RNReactNativeShopjoy";
    }

    public static class RNReactNativeShopjoyCallbacks extends ShopJoyCallbacks {
        @Override
        public void onCampaignTriggered(Context context, HistoryEntry entry)
        {
            Log.d(TAG, "Campaign triggered");
        }
        @Override
        public void onQuestTriggered(Context context, Quest quest) {
            Log.d(TAG, "Quest triggered");
        }
        @Override
        public void postServiceStartup(Context context) {
            Log.d(TAG, "Post service startup");
        }
        @Override
        public void enteredBeaconArea(Context context, String beaconID) {
            Log.d(TAG, "Entered beacon area: " + beaconID);
        }
    }
}