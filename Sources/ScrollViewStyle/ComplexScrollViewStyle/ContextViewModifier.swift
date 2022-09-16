//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI

struct ContextViewModifier: ViewModifier {
    @State var context: Context?
    @State var anchors = [ReaderAnchor]()
    func body(content: Content) -> some View {
        content
            .environment(\.prefrenceContext, context)
            .onPreferenceChange(OffsetPreferenceKey.self) { value in
                var valuey = value
                valuey?.anchors = anchors
                context = valuey
            }.onPreferenceChange(ReaderPreferenceKey.self) { value in
                guard let anchor = value else {return}
                guard let index = anchors.firstIndex(of: anchor) else {
                    anchors.append(anchor)
                    return
                }
                anchors[index] = anchor
            }
    }
}

public extension View {
    @ViewBuilder func scrollContainer() -> some View {
        self
            .modifier(ContextViewModifier())
    }
}
