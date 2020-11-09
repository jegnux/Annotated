//
//  Annotated+StringInterpolation.swift
//  Annotated
//
//  Created by Jérôme Alves on 08/11/2020.
//  Copyright © 2020 Annotated. All rights reserved.
//

import Foundation

extension Annotated {
    public struct StringInterpolation {
        internal var rawValue: String = ""
        internal var rawAnnotations: [(Range<String.Index>, T)] = []
    }
}

extension Annotated.StringInterpolation: StringInterpolationProtocol {
    public init(literalCapacity: Int, interpolationCount: Int) {
        rawValue.reserveCapacity(literalCapacity)
    }

    public mutating func appendLiteral(_ literal: String) {
        rawValue.append(literal)
    }

    public mutating func appendInterpolation(_ interpolation: Annotated<T>, _ annotation: T) {
        let start = rawValue.endIndex
        let offset = rawValue.distance(from: rawValue.startIndex, to: rawValue.endIndex)
        rawValue.append(interpolation.rawValue)
        rawAnnotations.append(contentsOf: interpolation.rawAnnotations.map { range, annotation in
            let lowerBound = rawValue.index(range.lowerBound, offsetBy: offset)
            let upperBound = rawValue.index(range.upperBound, offsetBy: offset)
            return (lowerBound..<upperBound, annotation)
        })
        rawAnnotations.append((start..<rawValue.endIndex, annotation))
    }

    public mutating func appendInterpolation(_ interpolation: Any, _ annotation: T) {
        let start = rawValue.endIndex
        rawValue.append(String(describing: interpolation))
        rawAnnotations.append((start..<rawValue.endIndex, annotation))
    }
}
