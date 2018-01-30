
package com.fotografiska.shopjoy;

import android.content.Context;
import android.support.annotation.Nullable;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import se.injou.shopjoy.sdk.HistoryEntry;
import se.injou.shopjoy.sdk.HistoryLoader;
import se.injou.shopjoy.sdk.Quest;
import se.injou.shopjoy.sdk.ShopJoyCallbacks;
import se.injou.shopjoy.sdk.ShopJoySDK;

public class RNReactNativeShopjoyModule extends ReactContextBaseJavaModule {

    private static String TAG = "RNShopJoyModule";
    private static ReactApplicationContext reactContext;
    private static Context context;
    private ShopJoySDK shopJoySDK;
    private static String SHOP_JOY_CAMPAIGN_TRIGGERED = "SHOP_JOY_CAMPAIGN_TRIGGERED";
    private static String SHOP_JOY_QUEST_TRIGGERED = "SHOP_JOY_QUEST_TRIGGERED";
    private static String SHOP_JOY_ENTERED_BEACON_AREA = "SHOP_JOY_ENTERED_BEACON_AREA";
    //    private static String SHOP_JOY_RETURNED_CAMPAIGN_MEMORY = "SHOP_JOY_RETURNED_CAMPAIGN_MEMORY";
    public RNReactNativeShopjoyModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        this.shopJoySDK = new ShopJoySDK();
//        registerShopJoy();
    }

    @ReactMethod
    private void registerShopJoy() {
        try {
            ShopJoySDK.register(reactContext, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    private void unregisterShopJoy() {
        try {
            ShopJoySDK.unregister(reactContext);
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

    @ReactMethod
    public void clearHistoryNew() {
        try {
            shopJoySDK.clearHistoryNew();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @ReactMethod
    public void openedCampaign(String campaignId) {
        try {
            HistoryEntry historyEntry = getHistoryItem(campaignId);
            historyEntry.markAsRead(reactContext);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static HistoryEntry getHistoryItem(String campaignId) {
        try {
            HistoryLoader historyLoader = new HistoryLoader(reactContext);
            ArrayList<HistoryEntry> historyEntries = historyLoader.loadInBackground();
            for (HistoryEntry entry : historyEntries) {
                if (entry.id.equals(campaignId)) {
                    return entry;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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
//        map.put(SHOP_JOY_RETURNED_CAMPAIGN_MEMORY, SHOP_JOY_RETURNED_CAMPAIGN_MEMORY); // Todo: Implement in the future.
        return map;
    }

    private static void sendEvent(String eventName, @Nullable WritableMap params) {
        try {
            reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                    .emit(eventName, params);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static WritableMap getWritableMap(Object object) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            HashMap map = mapper.convertValue(object, HashMap.class);
            WritableMap data = Arguments.createMap();
            for (Object key : map.keySet()) {
                Object value = map.get(key);
                switch (value.getClass().getName()) {
                    case "java.lang.Boolean":
                        data.putBoolean((String) key, (Boolean) value);
                        break;
                    case "java.lang.Integer":
                        data.putInt((String) key, (Integer) value);
                        break;
                    case "java.lang.Double":
                        data.putDouble((String) key, (Double) value);
                        break;
                    case "java.lang.String":
                        data.putString((String) key, (String) value);
                        break;
                }
            }
            WritableMap dataMap = Arguments.createMap();
            dataMap.putMap("data", data);
            return dataMap;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static class RNReactNativeShopjoyCallbacks extends ShopJoyCallbacks {
        @Override
        public void onCampaignTriggered(Context context, HistoryEntry entry)
        {
            sendEvent(SHOP_JOY_CAMPAIGN_TRIGGERED, getWritableMap(entry));
        }
        @Override
        public void onQuestTriggered(Context context, Quest quest) {
            sendEvent(SHOP_JOY_QUEST_TRIGGERED, getWritableMap(quest));
        }
        @Override
        public void postServiceStartup(Context context) {
            Log.d(TAG, "Post service startup");
        }
        @Override
        public void enteredBeaconArea(Context context, String beaconID) {
            WritableMap data = Arguments.createMap();
            data.putString("data", beaconID);
            sendEvent(SHOP_JOY_ENTERED_BEACON_AREA, data);
        }
    }
}
