//
//  Annotated.swift
//  Annotated
//
//  Created by Jérôme Alves on 08/11/2020.
//  Copyright © 2020 Annotated. All rights reserved.
//

import Foundation

@dynamicMemberLookup
public struct Annotated<T: Hashable> {
    
    private(set) public var rawValue: String
    private(set) public var rawAnnotations: [(Range<String.Index>, T)] = []
    
    public subscript<T>(dynamicMember keyPath: KeyPath<String, T>) -> T {
        rawValue[keyPath: keyPath]
    }
    
    public mutating func addAnnotation(_ annotation: T, at range: Range<Int>) {
        let range =  rawValue.index(rawValue.startIndex, offsetBy: range.lowerBound) ..< rawValue.index(rawValue.startIndex, offsetBy: range.upperBound)
        rawAnnotations.append((range, annotation))
    }

    public mutating func addAnnotation(_ annotation: T, at range: Range<String.Index>) {
        rawAnnotations.append((range, annotation))
    }
    
    public mutating func addAnnotation<S: StringProtocol>(_ annotation: T, forOccurencesOf substring: S, options: String.CompareOptions = []) {
        var start = rawValue.startIndex
        while let range = rawValue[start...].range(of: substring, options: options.subtracting(.backwards)) {
            start = range.upperBound
            addAnnotation(annotation, at: range)
        }
    }
}

extension Annotated: ExpressibleByStringInterpolation {

    public init(stringLiteral value: String) {
        rawValue = value
    }
    
    public init(stringInterpolation: StringInterpolation) {
        rawValue = stringInterpolation.rawValue
        rawAnnotations = stringInterpolation.rawAnnotations
    }

}

extension Annotated: CustomStringConvertible {
    public var description: String {
        let annotationsDescription = annotations
            .map { "  \($0)," }
            .joined(separator: "\n")

        return """
        Annotated(
        rawValue: \"""
        \(rawValue.split(separator: "\n").map { "  " + $0 }.joined(separator: "\n"))
        \""",
        annotations: [
        \(annotationsDescription)
        ])
        """
    }
}
