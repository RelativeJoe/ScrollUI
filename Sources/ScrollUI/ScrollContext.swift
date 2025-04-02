//
//  ScrollContext.swift
//  ScrollUI
//
//  Created by Joe Maghzal on 21/03/2025.
//

import Foundation

/// A type that provides you with more content when the phase of a scroll view changes.
public struct ScrollContext: Equatable, Hashable, Sendable {
    /// The geometry of the scroll view at the time of the scroll phase change.
    public var geometry = ScrollGeometry()
    
    /// The velocity of the scroll view at the time of the scroll phase change.
    public var velocity: CGVector?
}

/// A type that defines the geometry of a scroll view.
public struct ScrollGeometry: Equatable, Hashable, Sendable {
    /// The content offset of the scroll view.
    public var contentOffset = CGPoint.zero
    
    /// The size of the content of the scroll view.
    public var contentSize = CGSize.zero
}
