//
//  ScrollViewStyleModifider.swift
//  ScrollUI
//
//  Created by Joe Maghzal on 29/07/2023.
//

import SwiftUI
import SwiftUIIntrospect

/// A view modifier that applies a ``ScrollViewStyle`` to a ``ScrollView``.
@usableFromInline
internal struct ScrollViewStyleModifider<Style: ScrollViewStyle>: ViewModifier {
    /// The scroll view style to be applied.
    private let style: Style
    
    /// Creates a  ``ScrollViewStyleModifider`` with the specified ``ScrollViewStyle``.
    ///
    /// - Parameter style: The scroll view style to apply.
    @usableFromInline internal init(style: Style) {
        self.style = style
    }
    
    /// Modifies the view by applying the scroll view style.
    @usableFromInline internal func body(content: Content) -> some View {
        content
            .introspect(
                .scrollView,
                on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)
            ) { scrollView in
                Task { @MainActor in
                    style.update(scrollView)
                    scrollView.delegate = style.coordinator
                }
            }.environmentObject(style.coordinator)
    }
}

extension View {
    /// Applies a ``ScrollViewStyle`` to a ``ScrollView``.
    ///
    /// - Parameter style: The scroll view style to apply.
    ///
    /// - Returns: A modified view with the specified scroll view style.
    @inlinable public func scrollViewStyle(
        _ style: some ScrollViewStyle
    ) -> some View {
        modifier(ScrollViewStyleModifider(style: style))
    }
}
