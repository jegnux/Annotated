//
//  Annotated+Annotation.swift
//  Annotated
//
//  Created by Jérôme Alves on 08/11/2020.
//  Copyright © 2020 Annotated. All rights reserved.
//

import Foundation

extension Annotated {
    public struct Annotation: CustomStringConvertible {
        public init(substring: Substring, range: Range<String.Index>, annotation: T?) {
            self.substring = substring
            self.range = range
            self.annotation = annotation
        }
        
        public let substring: Substring
        public let range: Range<String.Index>
        public let annotation: T?
        
        private var base: String {
            substring.base
        }
        
        private var intRange: Range<Int> {
            base.distance(from: base.startIndex, to: range.lowerBound) ..< base.distance(from: base.startIndex, to: range.upperBound)
        }
        
        public var description: String {
            "\(intRange) → \"\(substring)\" → \(annotation.map(String.init(describing:)) ?? "nil")"
        }
    }
    
    public var annotations: AnySequence<Annotation> {
        AnySequence(
            rawAnnotations.lazy.map { range, annotation in
                Annotation(substring: rawValue[range], range: range, annotation: annotation)
            }
        )
    }
}
