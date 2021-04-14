//
//  ViewController.swift
//  SampleRestore
//
//  Created by Kai Oelfke on 14.04.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if SceneDelegate.enabledFlags.contains(.responder) || SceneDelegate.enabledFlags.contains(.alternativeResponder) {
            self.userActivity = self.view.window?.windowScene?.userActivity
        }
        if SceneDelegate.enabledFlags.contains(.viewController) {
            self.view.window?.windowScene?.userActivity?.addUserInfoEntries(from: ["ViewControllerKey": "ViewControllerValue"])
        }
        print("ViewDidAppear called")
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        super.updateUserActivityState(activity)
        if SceneDelegate.enabledFlags.contains(.responder) {
            activity.addUserInfoEntries(from: ["ResponderKey": "ResponderValue"])
        }
        if SceneDelegate.enabledFlags.contains(.alternativeResponder) {
            self.view.window?.windowScene?.userActivity?.addUserInfoEntries(from: ["AltResponderKey": "ResponderValue"])
        }
        print("Responder called")
    }

}

