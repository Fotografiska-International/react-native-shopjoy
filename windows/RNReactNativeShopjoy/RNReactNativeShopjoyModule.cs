using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Com.Reactlibrary.RNReactNativeShopjoy
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNReactNativeShopjoyModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNReactNativeShopjoyModule"/>.
        /// </summary>
        internal RNReactNativeShopjoyModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNReactNativeShopjoy";
            }
        }
    }
}
