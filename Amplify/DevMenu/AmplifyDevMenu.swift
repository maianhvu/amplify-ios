//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UIKit
import SwiftUI

/// Presents a developer menu using the provided `DevMenuPresentationContextProvider`
/// upon notification from a `TriggerRecognizer`. Default recognizer is a `LongPressGestureRecognizer`
@available(iOS 13.0.0, *)
public final class AmplifyDevMenu: DevMenuBehavior, TriggerDelegate {

    private let devMenuPresentationContextProvider: DevMenuPresentationContextProvider
    var triggerRecognizer: TriggerRecognizer?

    init(devMenuPresentationContextProvider contextProvider: DevMenuPresentationContextProvider) {
        self.devMenuPresentationContextProvider = WeakDevMenuPresentationContextProvider(provider: contextProvider)
        self.triggerRecognizer = LongPressGestureRecognizer(
            uiWindow: devMenuPresentationContextProvider.devMenuPresentationContext())
        triggerRecognizer?.updateTriggerDelegate(delegate: self)
    }

    public func onTrigger(triggerRecognizer: TriggerRecognizer) {
        showMenu()
    }

    public func showMenu() {
        guard let rootViewController =
            devMenuPresentationContextProvider.devMenuPresentationContext().rootViewController else {
                Amplify.Logging.warn(DevMenuStringConstants.logTag +
                    "RootViewController of the UIWindow is nil")
                return
        }
        let viewController = UIHostingController(rootView: DevMenuList(contextProvider: devMenuPresentationContextProvider))
        rootViewController.present(viewController, animated: true)
    }
}
