# NSUserActivity based state restoration issues

## iOSAppOnMac state restoration bug with UIApplicationSupportsMultipleScenes set to false

When running an iOS app on an M1 macOS device (isiOSAppOnMac)  state restoration fails, if UIApplicationSupportsMultipleScenes is set to false in the Info.plist. 

With UIApplicationSupportsMultipleScenes set to true it works. 

After running once with UIApplicationSupportsMultipleScenes enabled and then disabling it state restoration keeps working. Until the scene is destroyed by clicking the red close button instead of quitting the app directly. Then it stops working until enabling UIApplicationSupportsMultipleScenes again.

Steps:

1. Get our sample project or the [official state restoration project](https://developer.apple.com/documentation/uikit/uiviewcontroller/restoring_your_app_s_state) by Apple
2. Make sure UIApplicationSupportsMultipleScenes in Info.plist is true 
3. Build and run as iOSAppOnMac.
4. For the Apple project open a product and the edit form to create state. In our project there's only a key value pair being saved for restoration. So this step is skipped for our project.
5. Quit the app by the Menu Bar, CMD Q, or right clicking on the dock.
6. Wait a few seconds for the app to terminate and persist the state
7. Build and run again. Check if the navigation hierarchy is restored for the Apple project. For our project check the console logs for the restored key value pair.
8. Try the same again with UIApplicationSupportsMultipleScenes set to false.
9. Close the scene with the red close button and try again with UIApplicationSupportsMultipleScenes being false.

Enable these launch arguments for detailed logs:

-UIStateRestorationDebugLogging YES
-UIStateRestorationDebugLogging YES

The logs show the different code paths.

Expected behavior:

State restoration works independently of the value of UIApplicationSupportsMultipleScenes.

## UISceneDelegate.scene(_:didUpdate:) never gets called

The function `optional func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity)` never gets called.

Steps:

1. Get our sample project and run anywhere.
2. Or download the [official state restoration project](https://developer.apple.com/documentation/uikit/uiviewcontroller/restoring_your_app_s_state) by Apple and implement `optional func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity)` and run anywhere.

Expected behavior from official documentation:

> Use this method to add any final data to the specified user activity object. UIKit calls this method on your app's main thread after calling your stateRestorationActivity(for:) method and after giving other parts of your app an opportunity to update the activity object returned by that method.

## Using different state restoration APIs to set NSUserActivity userInfo state cause not persisted / restored state

One can use the following API's to change the NSUserActivity userInfo state.

SceneDelegate: Set state in stateRestorationActivity()
ViewController: Set state in viewDidAppear by accessing the activity of the scene

Two other ways are setting the userActivity property of the UIViewController e.g. in viewDidAppear and then implementing `func updateUserActivityState(_ activity: NSUserActivity)`

Responder: Use the activity provided as function parameter.
Alternative responder: Use the scene's user activity during execution of `updateUserActivityState(_ activity:)`.

These methods all work individually. But mixed use of the scene delegate or view controller based approaches with any or both of the responder approaches fails.

Steps:

1. Get the sample project
2. Change the restoration flags to test different API combinations
3. Run e.g. on an iPhone device or simulator
4. Enter the home screen, quit the app and launch it again
5. Check the console output

Expected behavior:

State added to `NSUserActivity.userInfo` is persisted and restored.
