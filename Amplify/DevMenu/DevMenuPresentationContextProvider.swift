//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UIKit

/// A protocol which provides a UI context over which views can be presented
@available(iOS 13.0, *)
public protocol DevMenuPresentationContextProvider: AnyObject {
    func devMenuPresentationContext() -> UIWindow
    func openURLExternally(_ url: URL)
    func dismissKeyboard()
}

@available(iOS 13.0, *)
class WeakDevMenuPresentationContextProvider: DevMenuPresentationContextProvider {
    private weak var provider: DevMenuPresentationContextProvider?
    
    init(provider: DevMenuPresentationContextProvider) {
        self.provider = provider
    }
    
    func devMenuPresentationContext() -> UIWindow {
        guard let presentationContext = provider?.devMenuPresentationContext() else {
            fatalError("The original presentation context provider has been deallocated")
        }
        return presentationContext
    }
    
    func openURLExternally(_ url: URL) {
        provider?.openURLExternally(url)
    }
    
    func dismissKeyboard() {
        provider?.dismissKeyboard()
    }
}

@available(iOS 13.0, *)
class PreviewDevMenuPresentationContextProvider: DevMenuPresentationContextProvider {
    func devMenuPresentationContext() -> UIWindow { fatalError("Unsupported operation") }
    func openURLExternally(_ url: URL) {}
    func dismissKeyboard() {}
}
