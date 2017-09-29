
# react-native-shopjoy

## Getting started

`$ npm install react-native-shopjoy --save`

### Mostly automatic installation

`$ react-native link react-native-shopjoy`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-shopjoy` and add `RNReactNativeShopjoy.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNReactNativeShopjoy.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNReactNativeShopjoyPackage;` to the imports at the top of the file
  - Add `new RNReactNativeShopjoyPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-shopjoy'
  	project(':react-native-shopjoy').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-shopjoy/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-shopjoy')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNReactNativeShopjoy.sln` in `node_modules/react-native-shopjoy/windows/RNReactNativeShopjoy.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Com.Reactlibrary.RNReactNativeShopjoy;` to the usings at the top of the file
  - Add `new RNReactNativeShopjoyPackage()` to the `List<IReactPackage>` returned by the `Packages` method


#### Essential steps to perform after linking.

##### iOS

1. Link libraries `CoreBluetooth`, `CoreLocation` and `libsqlite.3.0.tbd` in your target’s Build Phases tab.
2. Required since iOS 8: Add the `NSLocationAlwaysUsageDescription​` key to your app’s `Info.plist`. Add a string with the description you want to show to your users when the app asks their permission for location updates. This string will also be shown when the user is asked to re­confirm his/her consent a few days after installation.

##### Android

1. Add the following to the top-level `build.gradle`:

```
allprojects {
    ...
    repositories {
        ...
        flatDir {
            dirs project(':react-native-shopjoy').file('aars')
        }
    }
}
```

2. Add this to your app’s `AndroidManifest.xml` file.

```
<application>
    ...
    <service 
        android:name="se.injou.shopjoy.sdk.BeaconScannerService" 
        android:enabled="true" > 
    </service> 
    <service
        android:name="se.injou.shopjoy.sdk.BackJobHandler" 
        android:exported="false" 
        android:permission="android.permission.BIND_JOB_SERVICE"> 
    </service> 
    <receiver
        android:name="com.fotografiska.RNReactNativeShopjoyModule$RNReactNativeShopjoyCallbacks"
        android:exported="false"> 
        <intent-filter> 
            <action android:name=”<your.package.name>.SHOPJOY_CALLBACKS"/> 
        </intent-filter> 
    </receiver>
</application>
```

3. Add this to the app's `build.gradle`.

```
android {
    ...
    packagingOptions { 
        exclude 'META-INF/*' 
    }
}
```

## Usage
```javascript
import RNReactNativeShopjoy from 'react-native-shopjoy';

// TODO: What to do with the module?
RNReactNativeShopjoy;
```
  