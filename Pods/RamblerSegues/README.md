### Overview

[![Version](https://img.shields.io/cocoapods/v/RamblerSegues.svg?style=flat)](http://cocoapods.org/pods/RamblerSegues)
[![License](https://img.shields.io/cocoapods/l/RamblerSegues.svg?style=flat)](http://cocoapods.org/pods/RamblerSegues)
[![Platform](https://img.shields.io/cocoapods/p/RamblerSegues.svg?style=flat)](http://cocoapods.org/pods/RamblerSegues)

**RamblerSegues** is a collection of custom *UIStoryboardSegue* subclasses useful in different everyday situations.

![Segues](http://i.imgur.com/9Ta9XPk.jpg)

### Key features

- **EmbedSegue** - present child `UIViewController`s as easy as it should be.
- **CrossStoryboardSegue** - if you're afraid of linked `UIStoryboard`s - this segue is your perfect choice.

### Usage

#### EmbedSegue

1. Add a `UIView` on your parent `UIViewController` - this view will suit as a container for a child module. Connect it to `IBOutlet` with name `embedSegueContainer`.
2. Add a segue with class `RamblerEmbedSegue` from parent `UIViewController` to child `UIViewController`. Set its identifier to `EmbedSegueExample`.

  ![UIStoryboard](https://i.imgur.com/MEb5Q4Y.png)

3. Implement a method `- (UIView*)viewForEmbedIdentifier:(NSString*)embedIdentifier` in parent `UIViewController` and return `embedSegueContainer` in it:

  ```objc
  - (UIView*)viewForEmbedIdentifier:(NSString*)embedIdentifier {
    if ([embedIdentifier isEqualToString:@"EmbedSegueExample"]) {
        return self.embedSegueContainer;
    }
    return nil;
  }
  ```
4. Enjoy - now you can manage child view controller transitions just like any other - even from `Router` using [ViperMcFlurry](https://github.com/rambler-ios/ViperMcFlurry).

#### CrossStoryboardSegue

1. Add a new empty `UIViewController` on the first storyboard. Set its class to `RamblerPlaceholderViewController` and restoration identifier to `SecondViewController@AnotherStoryboard`.

  ![Placeholder UIViewController](https://i.imgur.com/xIhn5Oj.png)
2. Add a segue with class `CrossStoryboardSegueExample` and identifier `CrossStoryboardSegueExample` from parent `UIViewController` to this placeholder.
3. Add your target view controller to second storyboard - `AnotherStoryboard`. Set its Storyboard ID to `SecondViewController`.
4. Enjoy once again - you can use this segue just as usual one, but instead it will open `UIViewController` from another storyboard:

  ```objc
  [self performSegueWithIdentifier:@"CrossStoryboardSegueExample" sender:self];
  ```

You can test both segues in the example project - clone the repo, and run `pod install` from the Example directory first.

### Installation

RamblerSegues is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "RamblerSegues"
```

### License

RamblerSegues is available under the MIT license. See the LICENSE file for more info.

### Author

Andrey Zarembo-Godzyatskiy, andrey.zarembo@gmail.com
