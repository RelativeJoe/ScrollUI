//
//  ScrollViewStyle.swift
//  ScrollUI
//
//  Created by Joe Maghzal on 29/07/2023.
//

import SwiftUI

/// Requirements for defining as tyle for a ``ScrollView``.
@MainActor public protocol ScrollViewStyle {
    /// The associated type for the coordinator,
    /// which must conform to ``UIScrollViewDelegate`` and ``ObservableObject``.
    associatedtype Coordinator: UIScrollViewDelegate & ObservableObject
    
    /// The coordinator instance responsible for handling scroll events.
    var coordinator: Self.Coordinator { get }
    
    /// Updates the given ``UIScrollView``.
    ///
    /// - Parameter uiScrollView: The ``UIScrollView`` to update.
    func update(_ uiScrollView: UIScrollView)
}

extension ScrollViewStyle {
    /// Updates the given ``UIScrollView``.
    ///
    /// - Parameter uiScrollView: The ``UIScrollView`` to update.
    public func update(_ uiScrollView: UIScrollView) { }
}
