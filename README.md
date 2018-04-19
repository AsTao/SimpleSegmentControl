# SimpleSegmentControl


# Usage

<img src='https://github.com/AsTao/SimpleSegmentControl/blob/master/ScreenCapture.png' width=375 />

```objc
    segmentControl.segments = ["one","two","three"]
    segmentControl.reloadSegments()
    segmentControl.indexChangedHandler = {   [weak self] index in
        print(index)
    }
```




## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SimpleSegmentControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleSegmentControl'
```

## Author

tobias, 236048180@qq.com

## License

SimpleSegmentControl is available under the MIT license. See the LICENSE file for more info.
