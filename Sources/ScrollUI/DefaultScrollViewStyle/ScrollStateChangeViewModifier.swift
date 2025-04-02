//
//  ScrollStateChangeViewModifier.swift
//  ScrollUI
//
//  Created by Joe Maghzal on 21/03/2025.
//

import SwiftUI

/// A view modifier that observes and responds to changes in the scroll state of a scroll view.
@usableFromInline
internal struct ScrollStateChangeViewModifier: ViewModifier {
    /// The coordinator responsible for managing the scroll view state.
    @EnvironmentObject private var coordinator: DefaultScrollViewStyle.Coordinator
    
    /// The action to execute when the scroll state changes.
    /// - Parameters:
    ///   - oldState: The previous scroll state.
    ///   - newState: The new scroll state.
    ///   - context: The context associated with the scroll state change.
    private var action: (
        _ oldState: ScrollState,
        _ newState: ScrollState,
        _ context: ScrollContext
    ) -> Void
    
    /// Creates a ``ScrollStateChangeViewModifier`` with an action to be executed when the scroll state changes.
    ///
    /// - Parameter action: A closure that takes the old state, new state, and context as parameters.
    @usableFromInline internal init(
        action: @escaping (
            _ oldState: ScrollState,
            _ newState: ScrollState,
            _ context: ScrollContext
        ) -> Void
    ) {
        self.action = action
    }
    
    /// Modifies the view by adding listeners for changes in the scroll state.
    @usableFromInline internal func body(content: Content) -> some View {
        content
            .onChange(of: coordinator.state) { [oldValue = coordinator.state] newValue in
                action(oldValue, newValue, coordinator.context)
            }.onAppear {
                let value = coordinator.state
                action(value, value, coordinator.context)
            }
    }
}

extension View {
    /// Adds an action to perform when the scroll state of the scroll
    /// view in the hierarchy changes.
    ///
    /// Use this modifier to be informed of changes to a scroll view's
    /// state. A scroll view may be in a variety of different states like
    /// interacting or decelerating. See ``ScrollState`` for more information
    /// on the states of a scroll view.
    ///
    /// When the state of a scroll view changes, the system invokes the action
    /// you provide. In the following example, a selection binding is updated
    /// when the scroll view transitions to the ``ScrollState/decelerating``
    /// or ``ScrollState/idle`` phase.
    ///
    ///     @Binding var selection: SelectionValue?
    ///
    ///     ScrollView {
    ///         // ...
    ///     }.onScrollStateChange { _, newState in
    ///         if newState == .decelerating || newState == .idle {
    ///             selection = updateSelection()
    ///         }
    ///     }.scrollViewStyle(.default)
    ///
    /// The system can also provide you with the geometry of the scroll view
    /// at the time of the state change. You can use the geometry to
    /// understand where the scroll view has come or gone between the
    /// state changes and update dependent state on that information.
    /// In the following example, whether toolbar content is hidden is
    /// determined based on the direction of the last user initiated
    /// scroll.
    ///
    ///     @Binding var hidesToolbarContent: Bool
    ///     @State private var lastOffset: CGFloat = 0.0
    ///
    ///     ScrollView {
    ///         // ...
    ///     }.onScrollStateChange { oldState, newState, context in
    ///         if newState == .interacting {
    ///             lastOffset = context.geometry.contentOffset.y
    ///         }
    ///         if oldState == .interacting, newState != .animating,
    ///             context.geometry.contentOffset.y - lastOffset < 0.0
    ///         {
    ///             hidesToolbarContent = true
    ///         } else {
    ///             hidesToolbarContent = false
    ///         }
    ///     }.scrollViewStyle(.default)
    ///
    /// - Parameters:
    ///   - action: A closure to run when the scroll state changes.
    ///   - oldPhase: The old scroll state.
    ///   - newPhase: The new scroll state.
    ///   - geometry: The scroll geometry at the time of the scroll
    ///     state change.
    ///
    /// - Note: You must apply the default ``ScrollViewStyle``
    /// after this modifier using ``scrollViewStyle(_:)``.
    @inlinable public func onScrollStateChange(
        _ action: @escaping (
            _ oldState: ScrollState,
            _ newState: ScrollState,
            _ context: ScrollContext
        ) -> Void
    ) -> some View {
        modifier(ScrollStateChangeViewModifier(action: action))
    }
}
