//
//  EFSafeArray.swift
//  EFSafeArray
//
//  Created by EyreFree on 2017/7/28.
//
//  Copyright (c) 2017 EyreFree <eyrefree@eyrefree.org>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

// ~
postfix operator ~
public postfix func ~ (value: Int?) -> EFSafeInt? {
    return EFSafeInt(value: value)
}
public postfix func ~ (value: Range<Int>?) -> EFSafeRange? {
    return EFSafeRange(value: value)
}
public postfix func ~ (value: CountableClosedRange<Int>?) -> EFSafeRange? {
    guard let value = value else {
        return nil
    }
    return EFSafeRange(value: Range<Int>(value))
}

// Struct
public struct EFSafeInt {
    var index: Int
    init?(value: Int?) {
        guard let value = value else {
            return nil
        }
        self.index = value
    }
}

public struct EFSafeRange {
    var range: Range<Int>
    init?(value: Range<Int>?) {
        guard let value = value else {
            return nil
        }
        self.range = value
    }
}

// Core
public extension Array {
    public subscript(index: EFSafeInt?) -> Element? {
        get {
            if let index = index?.index {
                return (self.startIndex..<self.endIndex).contains(index) ? self[index] : nil
            }
            return nil
        }
        set {
            if let index = index?.index, let newValue = newValue {
                if (self.startIndex..<self.endIndex).contains(index) {
                    self[index] = newValue
                }
            }
        }
    }
    
    public subscript(bounds: EFSafeRange?) -> ArraySlice<Element>? {
        get {
            if let range = bounds?.range {
                return self[range.clamped(to: self.startIndex ..< self.endIndex)]
            }
            return nil
        }
        set {
            if let range = bounds?.range, let newValue = newValue {
                self[range.clamped(to: self.startIndex ..< self.endIndex)] = newValue
            }
        }
    }
}
