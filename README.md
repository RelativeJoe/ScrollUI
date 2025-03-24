# ScrollUI

[![GitHub Release](https://img.shields.io/github/release/relativejoe/ScrollUI.svg?include_prereleases)](https://github.com/buildexperience/ScrollUI/releases)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FRelativeJoe%2FScrollUI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/RelativeJoe/ScrollUI)
[![Swift Versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FRelativeJoe%2FScrollUI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/RelativeJoe/ScrollUI)
[![License](https://img.shields.io/github/license/relativejoe/ScrollUI)](https://github.com/relativejoe/ScrollUI/blob/main/LICENSE)

`ScrollUI` is a Swift package that provides a powerful way to observe and respond to scroll state changes in SwiftUI. It enables developers to track scrolling behavior and geometry updates efficiently.

## Features

- Observe scroll state changes (e.g., `idle`, `interacting`, `decelerating`, `animating`).
- Respond to scroll geometry updates (e.g., content offset changes).
- Provides a modular and reusable way to enhance scroll behavior.

## Installation

### Swift Package Manager

To integrate `ScrollUI` into your project, add it as a dependency using Swift Package Manager:

1. Open Xcode and go to **File > Add Packages...**
2. Enter the repository URL: `https://github.com/relativejoe/ScrollUI.git`
3. Choose the latest version and add the package.

## Usage

### Observing Scroll State Changes

You can track the state of a `ScrollView` using the `onScrollStateChange` modifier:

```swift
import ScrollUI

struct ContentView: View {
    @State private var isScrolling = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { index in
                    Text("Item \(index)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .onScrollStateChange { _, newState, _ in
            isScrolling = newState.isScrolling
        }.scrollViewStyle(.default)
    }
}
```

### Observing Scroll Geometry Changes

To track changes in `ScrollGeometry`, use `onScrollGeometryChange`:

```swift
ScrollView {
    VStack(spacing: 20) {
        ForEach(0..<50) { index in
            Text("Item \(index)")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
        }
    }
    .padding()
}
.onScrollGeometryChange(of: { $0.contentOffset.y > 100 }) { wasBeyond, isBeyond in
    print("Scrolled beyond 100: \(isBeyond)")
}.scrollViewStyle(.default)
```

## Scroll States

`ScrollUI` provides the following scroll states:

- `.idle`: The scroll view is not moving.
- `.interacting`: The user is actively scrolling.
- `.decelerating`: The scroll view is slowing down after user interaction.
- `.animating`: The scroll view is in an animated transition.


## Documentation

The [documentation](https://swiftpackageindex.com/RelativeJoe/ScrollUI/master/documentation/scrollui) is provided by [swiftpackageindex](https://swiftpackageindex.com).


## Dependencies

ScrollUI relies on other packages for specific functionalities:

- [siteline/swiftui-introspect](https://github.com/siteline/swiftui-introspect)


## Contributions

Contributions are welcome! If you’d like to improve this package, feel free to open an issue or submit a pull request.


## Contact

For questions or support, reach out via GitHub issues.

