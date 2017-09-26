
package com.fotografiska;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ObjectAlreadyConsumedException;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

import se.injou.shopjoy.sdk.HistoryEntry;
import se.injou.shopjoy.sdk.Quest;
import se.injou.shopjoy.sdk.ShopJoyCallbacks;
import se.injou.shopjoy.sdk.ShopJoySDK;

public class RNReactNativeShopjoyModule extends ReactContextBaseJavaModule {

    private static String TAG = "RNShopJoyModule";
    private static ReactApplicationContext reactContext;
    private ShopJoySDK shopJoySDK;
    private static String SHOP_JOY_CAMPAIGN_TRIGGERED = "SHOP_JOY_CAMPAIGN_TRIGGERED";
    private static String SHOP_JOY_QUEST_TRIGGERED = "SHOP_JOY_QUEST_TRIGGERED";
    private static String SHOP_JOY_ENTERED_BEACON_AREA = "SHOP_JOY_ENTERED_BEACON_AREA";

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

    @javax.annotation.Nullable
    @Override
    public Map<String, Object> getConstants() {
        Map<String, Object> map = new HashMap<>();
        map.put(SHOP_JOY_CAMPAIGN_TRIGGERED, SHOP_JOY_CAMPAIGN_TRIGGERED);
        map.put(SHOP_JOY_QUEST_TRIGGERED, SHOP_JOY_QUEST_TRIGGERED);
        map.put(SHOP_JOY_ENTERED_BEACON_AREA, SHOP_JOY_ENTERED_BEACON_AREA);
        return map;
    }

    private static void sendEvent(String eventName, @Nullable HashMap params) {
        reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

    public static class RNReactNativeShopjoyCallbacks extends ShopJoyCallbacks {
        @Override
        public void onCampaignTriggered(Context context, HistoryEntry entry)
        {
            Log.d(TAG, "Campaign triggered");
            ObjectMapper mapper = new ObjectMapper();
            try {
                HashMap map = mapper.convertValue(entry, HashMap.class);
//                Bundle bundle = new Bundle();
//                bundle.putSerializable("data", map);
//                WritableMap writableMap = Arguments.fromBundle(bundle);
                sendEvent(SHOP_JOY_CAMPAIGN_TRIGGERED, map);
            } catch (Exception e) {
                e.printStackTrace();
            }
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