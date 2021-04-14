//
//  SceneDelegate.swift
//  SampleRestore
//
//  Created by Kai Oelfke on 14.04.21.
//

import UIKit

enum TestFlags {
    case sceneDelegate
    case userActivityDelegate
    case responder
    case viewController
    case alternativeResponder
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    static let enabledFlags: Set<TestFlags> = [.viewController, .sceneDelegate, .userActivityDelegate]

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // Restore or create new one
        scene.userActivity = session.stateRestorationActivity ?? NSUserActivity(activityType: "restoration")
        if SceneDelegate.enabledFlags.contains(.userActivityDelegate) {
            scene.userActivity?.delegate = self
        }
        if let userInfo = session.stateRestorationActivity?.userInfo {
            print("Has scene value: \(userInfo["SceneKey"] != nil)")
            print("Has delegate value: \(userInfo["DelegateKey"] != nil)")
            print("Has responder value: \(userInfo["ResponderKey"] != nil)")
            print("Has view ctrl value: \(userInfo["ViewControllerKey"] != nil)")
            print("Has alt responder value: \(userInfo["AltResponderKey"] != nil)")
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        print("stateRestorationActivity for scene called")
        if SceneDelegate.enabledFlags.contains(.sceneDelegate) {
            scene.userActivity?.addUserInfoEntries(from: ["SceneKey": "SceneValue"])
        }
        return scene.userActivity
    }

    func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        print("scene did update user activity")
        fatalError("never gets called?")
    }
}

extension SceneDelegate: NSUserActivityDelegate {
    func userActivityWillSave(_ userActivity: NSUserActivity) {
        print("NSUserActivityDelegate called")
        if SceneDelegate.enabledFlags.contains(.userActivityDelegate) {
            userActivity.addUserInfoEntries(from: ["DelegateKey": "DelegateValue"])
        }
    }
}
