//
//  String+.swift
//  Annotated
//
//  Created by Jérôme Alves on 09/11/2020.
//  Copyright © 2020 Annotated. All rights reserved.
//

import Foundation

extension String {
    internal func intRange(for range: Range<String.Index>) -> Range<Int> {
        distance(from: startIndex, to: range.lowerBound) ..< distance(from: startIndex, to: range.upperBound)
    }
}
