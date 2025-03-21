//
//  ScrollState.swift
//  ScrollUI
//
//  Created by Joe Maghzal on 21/03/2025.
//

import Foundation

/// A type that describes the state of a scroll gesture of a
/// scrollable view like a scroll view.
///
/// A scroll gesture can be in one of four phases:
///     - idle: No active scroll is occurring.
///     - interacting: An active scroll being driven by the user
///       is occurring.
///     - decelerating: The user has stopped driving a scroll
///       and the scroll view is decelerating to its final
///       target.
///     - animating: The system is animating to a final target
///       as a result of a programmatic animated scroll.
///
/// ScrollUI provides you a value of this type when using the
/// ``View/onScrollStateChange(_:)`` modifier.
@frozen public enum ScrollState: Equatable, Hashable, Sendable {
    /// The animating phase where the scroll view is animating towards a final target.
    case animating
    
    /// The decelerating phase where the user use has stopped
    /// interacting with the scroll view and the scroll view
    /// is decelerating towards its final target.
    case decelerating
    
    /// The idle phase where no kind of scrolling is occurring.
    case idle
    
    /// The interacting phase where the user is interacting
    /// with the scroll view.
    case interacting
    
    /// Whether the scroll view is actively scrolling.
    ///
    /// This convenience is equivalent to `phase != .idle`.
    public var isScrolling: Bool {
        return self != .idle
    }
}
