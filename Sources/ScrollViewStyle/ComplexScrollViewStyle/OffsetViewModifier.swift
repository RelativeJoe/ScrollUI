//
//  File.swift
//  
//
//  Created by Joe Maghzal on 9/11/22.
//

import SwiftUI
import STools

internal struct OffsetViewModifier: ViewModifier {
    private let offsets: [OffsetType]
    private let oldHeight: CGFloat?
    private let oldWidth: CGFloat?
    private let alignment: Alignment?
    @State private var newHeight: CGFloat?
    @State private var newWidth: CGFloat?
    @State private var padding: (Edge.Set, CGFloat) = (.top, 0)
    @Environment(\.prefrenceContext) private var context
    internal init(offsets: [OffsetType], oldHeight: CGFloat?, oldWidth: CGFloat?, alignment: Alignment?) {
        self.offsets = offsets
        self.oldHeight = oldHeight
        self.oldWidth = oldWidth
        self.alignment = alignment
        self._newHeight = State(wrappedValue: oldHeight)
        self._newWidth = State(wrappedValue: oldWidth)
    }
    internal func body(content: Content) -> some View {
        content
            .onChange(of: context) { value in
                guard let context = value else {
                    return
                }
                offsets.forEach { offset in
                    switch offset {
                        case .padding(let edge, let maxValue, let speed, let vertical):
                            padding.0 = edge
                            let newPadding = context.offset.getValue(vertical) * (speed ?? 100)/100
                            if let maxValue {
                                guard newPadding < maxValue else {return}
                            }
                            padding.1 = newPadding
                        case .heightResize(let height, let speed, let minOffset, let minHeight, let vertical):
                            guard let oldHeight else {return}
                            let value = context.offset.getValue(vertical)
                            if let minHeight {
                                guard newHeight ?? 0 > minHeight else {return}
                            }
                            if let minOffset {
                                guard context.offset.getValue(vertical) > minOffset else {return}
                            }
                            let negativeToAssign = oldHeight - value * (speed ?? 100)/100
                            let positiveToAssign = oldHeight + value * (speed ?? 100)/100
                            if negativeToAssign > height  {
                                newHeight = negativeToAssign
                            }else if positiveToAssign < height {
                                newHeight = positiveToAssign
                            }
                        case .widthResize(let width, let speed, let minOffset, let minWidth, let vertical):
                            guard let oldWidth else {return}
                            let value = context.offset.getValue(vertical)
                            if let minWidth {
                                guard newWidth ?? 0 > minWidth else {return}
                            }
                            if let minOffset {
                                guard value > minOffset else {return}
                            }
                            let negativeToAssign = oldWidth - value * (speed ?? 100)/100
                            let positiveToAssign = oldWidth + value * (speed ?? 100)/100
                            if negativeToAssign > width  {
                                newWidth = negativeToAssign
                            }else if positiveToAssign < width {
                                newWidth = positiveToAssign
                            }
                    }
                }
            }.stateModifier(oldHeight != nil) { view in
                view
                    .frame(width: newWidth, height: newHeight, alignment: alignment ?? .center)
            }.padding(padding.0, padding.1)
    }
}

extension CGPoint {
    func getValue(_ vertical: Bool) -> CGFloat {
        if vertical {
            return y
        }
        return x
    }
}

