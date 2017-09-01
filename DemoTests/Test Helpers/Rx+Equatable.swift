// Copyright (c) 2016 Krunoslav Zaher
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// These are a bunch of equatable helpers that are not part of the RxSwift repo (unfortunately)
// so that we can easily compare recorded events. I've copied these somewhere back
// in time... Most of them is from RxSwift repo, else is from RxSwiftCommunity, so all credits go to kzaher. Didn't have time to revisit what is needed and what is not so might be outdated
// somewhere.

import Nimble
import RxSwift
import RxTest

public func equal<T: Equatable>(_ expectedValue: [Recorded<Event<[T]>>]) -> Predicate<[Recorded<Event<[T]>>]> {
    return Predicate { expression in
        let test: Bool

        if let actualValue = try expression.evaluate() {
            test = expectedValue == actualValue
        } else {
            test = false
        }

        return PredicateResult(bool: test, message: ExpectationMessage.expectedActualValueTo("<\(expectedValue)>"))
    }
}

public func equal<T: Equatable>(_ expectedValue: [Recorded<Event<T>>]) -> Predicate<[Recorded<Event<T>>]> {
    return Predicate { expression in
        let test: Bool

        if let actualValue = try expression.evaluate() {
            test = expectedValue == actualValue
        } else {
            test = false
        }

        return PredicateResult(bool: test, message: ExpectationMessage.expectedActualValueTo("<\(expectedValue)>"))
    }
}

/// Compares two events. They are equal if they are both the same member of `Event` enumeration.
///
/// In case `Error` events are being compared, they are equal in case their `NSError` representations are equal (domain and code)
/// and their string representations are equal.
public func ==<Element: Equatable>(lhs: Event<Element>, rhs: Event<Element>) -> Bool {
    switch (lhs, rhs) {
    case (.completed, .completed): return true
    case (.error(let e1), .error(let e2)):
        #if os(Linux)
            return  "\(e1)" == "\(e2)"
        #else
            let error1 = e1 as NSError
            let error2 = e2 as NSError

            return error1.domain == error2.domain
                && error1.code == error2.code
                && "\(e1)" == "\(e2)"
        #endif
    case (.next(let v1), .next(let v2)): return v1 == v2
    default: return false
    }
}

/// Compares two events. They are equal if they are both the same member of `Event` enumeration.
///
/// In case `Error` events are being compared, they are equal in case their `NSError` representations are equal (domain and code)
/// and their string representations are equal.
public func ==<Element: Equatable>(lhs: Event<[Element]>, rhs: Event<[Element]>) -> Bool {
    switch (lhs, rhs) {
    case (.completed, .completed): return true
    case (.error(let e1), .error(let e2)):
        #if os(Linux)
            return  "\(e1)" == "\(e2)"
        #else
            let error1 = e1 as NSError
            let error2 = e2 as NSError

            return error1.domain == error2.domain
                && error1.code == error2.code
                && "\(e1)" == "\(e2)"
        #endif
    case (.next(let v1), .next(let v2)): return v1 == v2
    default: return false
    }
}

/// Compares two events with optional elements. They are equal if they are both the same member of `Event` enumeration.
///
/// In case `Error` events are being compared, they are equal in case their `NSError` representations are equal (domain and code)
/// and their string representations are equal.
public func ==<Element: Equatable>(lhs: Event<Element?>, rhs: Event<Element?>) -> Bool {
    switch (lhs, rhs) {
    case (.completed, .completed): return true
    case (.error(let e1), .error(let e2)):
        #if os(Linux)
            return  "\(e1)" == "\(e2)"
        #else
            let error1 = e1 as NSError
            let error2 = e2 as NSError

            return error1.domain == error2.domain
                && error1.code == error2.code
                && "\(e1)" == "\(e2)"
        #endif
    case (.next(let v1), .next(let v2)): return v1 == v2
    default: return false
    }
}

public func ==<T: Equatable>(lhs: Recorded<Event<T>>, rhs: Recorded<Event<T>>) -> Bool {
    return lhs.time == rhs.time && lhs.value == rhs.value
}

public func ==<T: Equatable>(lhs: Recorded<Event<[T]>>, rhs: Recorded<Event<[T]>>) -> Bool {
    return lhs.time == rhs.time && lhs.value == rhs.value
}

public func ==<T: Equatable>(lhs: Recorded<Event<T?>>, rhs: Recorded<Event<T?>>) -> Bool {
    return lhs.time == rhs.time && lhs.value == rhs.value
}

public func ==<T: Equatable>(lhs: [Recorded<Event<T>>], rhs: [Recorded<Event<T>>]) -> Bool{
    guard lhs.count == rhs.count else { return false }

    var i1 = lhs.makeIterator()
    var i2 = rhs.makeIterator()
    var isEqual = true
    while let e1 = i1.next(), let e2 = i2.next(), isEqual {
        isEqual = e1 == e2
    }

    return isEqual
}

public func ==<T: Equatable>(lhs: [Recorded<Event<[T]>>], rhs: [Recorded<Event<[T]>>]) -> Bool{
    guard lhs.count == rhs.count else { return false }

    var i1 = lhs.makeIterator()
    var i2 = rhs.makeIterator()
    var isEqual = true
    while let e1 = i1.next(), let e2 = i2.next(), isEqual {
        isEqual = e1 == e2
    }

    return isEqual
}

