//
//  DefaultScrollViewStyleCoordinator.swift
//  ScrollUI
//
//  Created by Joe Maghzal on 31/12/2023.
//

import SwiftUI

extension DefaultScrollViewStyle {
    /// A coordinator class that manages the state and context of a scroll view.
    ///
    /// The ``Coordinator`` serves as the bridge between the scroll view and the
    /// ``DefaultScrollViewStyle``, observing and updating the scroll state
    /// as user interactions occur.
    @MainActor public final class Coordinator: NSObject, ObservableObject {
        /// The current state of the scroll view.
        @Published internal var state = ScrollState.idle
        
        /// The context that holds scroll-related information.
        @Published internal var context = ScrollContext()
        
        /// Creates a new ``Coordinator``.
        public override init() { }
    }
}

// MARK: - UIScrollViewDelegate
extension DefaultScrollViewStyle.Coordinator: UIScrollViewDelegate {
    /// Called when the scroll view's content offset changes.
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        context.geometry.contentOffset = scrollView.contentOffset
    }
    
    /// Called when the scroll view finishes animating to a new position.
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        state = .animating
    }
    
    /// Called when the user stops interacting with the scroll view and it begins decelerating.
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        state = .decelerating
    }
    
    /// Called when the scroll view finishes decelerating and comes to a stop.
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        state = .idle
    }
    
    /// Called when the user stops dragging the scroll view.
    ///
    /// If the scroll view is not going to decelerate, it transitions to the idle state.
    public func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        guard !decelerate else {return}
        state = .idle
    }
    
    /// Called when the user starts dragging the scroll view.
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        state = .interacting
    }
}
