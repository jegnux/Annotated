//
//  Annotated+NSAttributedString.swift
//  Annotated
//
//  Created by Jérôme Alves on 08/11/2020.
//  Copyright © 2020 Annotated. All rights reserved.
//

import Foundation

extension Annotated {
    public func makeAttributedString(_ map: (T?) -> [NSAttributedString.Key: Any]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: rawValue)
        let mapping = Dictionary(uniqueKeysWithValues: Set([nil] + rawAnnotations.map(\.1)).compactMap { ($0, map($0)) })
        
        if let attributes = mapping[nil] {
            let range = NSRange(rawValue.startIndex..<rawValue.endIndex, in: rawValue)
            attributedString.addAttributes(attributes, range: range)
        }
        
        for (range, annotation) in rawAnnotations {
            guard let attributes = mapping[annotation] else { continue }
            attributedString.addAttributes(attributes, range: NSRange(range, in: rawValue))
        }
        
        return attributedString.copy() as! NSAttributedString
    }
}
