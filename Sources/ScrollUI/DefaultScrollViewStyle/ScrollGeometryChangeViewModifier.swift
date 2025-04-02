//
//  ScrollGeometryChangeViewModifier.swift
//  ScrollUI
//
//  Created by Joe Maghzal on 21/03/2025.
//

import SwiftUI

/// A view modifier that observes changes in scroll geometry and triggers an action
/// when a transformed value derived from the geometry changes.
@usableFromInline
internal struct ScrollGeometryChangeViewModifier<T: Equatable>: ViewModifier {
    /// The coordinator responsible for managing the scroll view geometry.
    @EnvironmentObject private var coordinator: DefaultScrollViewStyle.Coordinator
    
    /// The transform applied to the scroll geometry.
    private var transform: (ScrollGeometry) -> T
    
    /// The action to execute when the scroll geometry changes.
    private var action: (_ oldValue: T, _ newValue: T) -> Void
    
    /// The transformed value derived from the scroll geometry.
    private var transformed: T {
        return transform(coordinator.context.geometry)
    }
    
    /// Creates a ``ScrollGeometryChangeViewModifier`` with a transformation and an action.
    /// 
    /// - Parameters:
    ///   - transform: A closure that converts a ``ScrollGeometry`` to another data type.
    ///   - action: A closure that is triggered when the transformed value changes.
    @usableFromInline internal init(
        transform: @escaping (ScrollGeometry) -> T,
        action: @escaping (_ oldValue: T, _ newValue: T) -> Void
    ) {
        self.transform = transform
        self.action = action
    }
    
    /// The body of the view modifier, observing changes in the transformed value.
    @usableFromInline internal func body(content: Content) -> some View {
        content
            .onChange(of: transformed) { [oldValue = transformed] newValue in
                action(oldValue, newValue)
            }.onAppear {
                let value = transformed
                action(value, value)
            }
    }
}

extension View {
    /// Adds an action to be performed when a value, created from a
    /// scroll geometry, changes.
    ///
    /// The geometry of a scroll view changes frequently while scrolling.
    /// You should avoid updating large parts of your app whenever
    /// the scroll geometry changes. To aid in this, you provide two
    /// closures to this modifier:
    ///   * transform: This converts a value of ``ScrollGeometry`` to a
    ///     your own data type.
    ///   * action: This provides the data type you created in `of`
    ///     and is called whenever the data type changes.
    ///
    /// For example, you can use this modifier to know when the user scrolls
    /// a scroll view beyond a certain point. In the following example,
    /// the data type you convert to is a ``Bool`` and the action is called
    /// whenever the ``Bool`` changes.
    ///
    ///     @Binding var isBeyondPoint: Bool
    ///
    ///     ScrollView {
    ///         // ...
    ///     }.onScrollGeometryChange(
    ///         of: {$0.contentOffset.y > 100}
    ///     ) {  wasBeyondPoint, isBeyondPoint in
    ///         self.isBeyondPoint = isBeyondPoint
    ///     }.scrollViewStyle(.default)
    ///
    /// - Parameters:
    ///   - transform: A closure that transforms a ``ScrollGeometry``
    ///     to your type.
    ///   - action: A closure to run when the transformed data changes.
    ///   - oldValue: The old value that failed the comparison check.
    ///   - newValue: The new value that failed the comparison check.
    ///
    /// - Note: You must apply the default ``ScrollViewStyle``
    /// after this modifier using ``scrollViewStyle(_:)``.
    @inlinable public func onScrollGeometryChange<T: Equatable>(
        of transform: @escaping (ScrollGeometry) -> T,
        action: @escaping (_ oldValue: T, _ newValue: T) -> Void
    ) -> some View {
        modifier(
            ScrollGeometryChangeViewModifier(
                transform: transform,
                action: action
            )
        )
    }
}
