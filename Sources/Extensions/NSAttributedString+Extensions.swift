/*
 MIT License

 Copyright (c) 2017-2018 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation

extension NSAttributedString {

    func height(considering width: CGFloat) -> CGFloat {

        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)

        // Workaround for iOS 13 bug:
        let adjustedRect: CGRect
        if #available(iOS 13, *) {
            let fullRange = NSRange(0..<length)
            var isPartiallyAttributed = false
            enumerateAttributes(in: fullRange) { value, range, stop in
                if !NSEqualRanges(fullRange, range) {
                    isPartiallyAttributed = true
                    stop.pointee = true
                }
            }
            var options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
            if isPartiallyAttributed {
                options.formUnion(NSStringDrawingOptions.usesDeviceMetrics)
            }
            adjustedRect = boundingRect(with: constraintBox,
                                        options: options,
                                        context: nil)
        } else {
            adjustedRect = boundingRect(with: constraintBox,
                                        options: [.usesLineFragmentOrigin, .usesFontLeading],
                                        context: nil)
        }

        return adjustedRect.height

    }

    func width(considering height: CGFloat) -> CGFloat {

        let constraintBox = CGSize(width: .greatestFiniteMagnitude, height: height)
        let rect = self.boundingRect(with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return rect.width
        
    }
}
