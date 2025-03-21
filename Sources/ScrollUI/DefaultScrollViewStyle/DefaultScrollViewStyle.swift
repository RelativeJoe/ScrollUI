//
//  DefaultScrollViewStyle.swift
//  ScrollUI
//
//  Created by Joe Maghzal on 29/07/2023.
//

import SwiftUI

/// The default scroll view style that provides a coordinator for managing
/// scroll-related state and updates.
///
/// ```swift
/// ScrollView {
///     // Scrollable content
/// }
/// .scrollViewStyle(.default)
/// ```
public struct DefaultScrollViewStyle: ScrollViewStyle {
    /// The coordinator responsible for managing scroll-related state.
    public let coordinator = Coordinator()
    
    /// Creates a new ``DefaultScrollViewStyle``.
    public init() { }
    
    /// Updates the underlying ``UIScrollView`` properties when necessary.
    ///
    /// - Parameter uiScrollView: The ``UIScrollView`` instance being updated.
    public func update(_ uiScrollView: UIScrollView) {
        coordinator.context.geometry.contentSize = uiScrollView.contentSize
    }
}

extension ScrollViewStyle where Self == DefaultScrollViewStyle {
    /// The default scroll view style that provides a coordinator for managing
    /// scroll-related state and updates.
    ///
    /// ```swift
    /// ScrollView {
    ///     // Scrollable content
    /// }
    /// .scrollViewStyle(.default)
    /// ```
    public static var `default`: DefaultScrollViewStyle {
        return DefaultScrollViewStyle()
    }
}
