# SweetUI 🍯

__SwiftUI-like declarative UIKit based framework.__

SwiftUI is great but still lacks some useful features of UIKit and doesn't support older versions of iOS. This framework will allow you to use UIKit in a declarative way, pretty similar to the SwiftUI, but with support of iOS 10+ and well-known behavior of the system.

## Usage

```swift
// JUMPING BUTTON EXAMPLE

import SweetUI

class ViewController: UIViewController {
    
    private(set) var button: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup view
        view.ui.add {
          	// Add title
            UILabel(text: "Jumping button", alignment: .center, color: .red).ui
                .font(.systemFont(ofSize: 32, weight: .semibold))
                .center(.init(x: view.center.x, y: view.center.y - 60))
                .size(.init(width: CGRect.screen.width, height: 32))
          
          	// Add button
            UIButton(title: "Tap me!") { [weak self] in
                print("The button was tapped.")
                let position0 = self?.button?.center ?? .zero
                let position1 = CGPoint(x: position0.x, y: position0.y - 32)
                self?.button?.ui
                    .animate(.sequence,								// Perform one by one
                             .move(center: position1, // Jump up
                                   duration: 0.1),
                             .move(center: position0, // Fall down
                                   duration: 0.1))
            }.ui
                .link(to: &button) // Store UIButton in self.button
                .title(color: .blue)
                .center(view.center)
                .size(.init(width: 100, height: 32))
        }
    }
    
}
```

_(Working on new features and documentation)_

#### Initialization

__SwiftUI__ provides custom convenience initializers for your views.

#### ViewProxy

__SweetUI__ provides some proxies for interaction with your view's properties. You can access these DSLs via `SomeView`__.ui__ property, which returns a ViewProxy or it's successor's instance.

#### LayoutProxy

__SweetUI__ provides some proxies for interaction with your view's properties. You can access these DSLs via `SomeView`__.layout__ or `SomeViewProxy`__.layout__ property, which returns a LayoutProxy or it's successor's instance.

## Requirements

- ⌨️    XCode12+
- 📱    iOS 10.0+

## Installation

SUILayout is available through SwiftPM

```swift
.package(url: "https://github.com/maximkrouk/SweetUI.git", from: "1.0.0-beta.3.6")
```

```swift
.product(name: "SweetUI", package: "SweetUI")
```

## License

SweetUI is available under the MIT license. See the LICENSE file for more info.

## To-do

- Conditional building ✅
- Add DSL's for every UIView subclass.
- Add convenience methods for user interaction, such as `tapAction(_ execute: () -> Void)` ✅
- Complete Xcode documentation.
- Provide more examples.
- Add API for shadows. ✅
- Add more animation templates. ✅
- Add layout engine. ✅
- Make some API improvements.
- Provide DSLs for UIViewControllers.
- Mix sequential and parallel animations.

------

*Feel free to contribute or [communicate](https://twitter.com/mxcat_). SweetUI is open to your ideas.* 🌝
