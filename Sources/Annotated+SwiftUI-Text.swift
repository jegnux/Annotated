//
//  Annotated+SwiftUI-Text.swift
//  Annotated
//
//  Created by Jérôme Alves on 09/11/2020.
//  Copyright © 2020 Annotated. All rights reserved.
//

#if canImport(SwiftUI)
import Foundation
import SwiftUI

extension Annotated {
    
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public func makeText(_ factory: (T?) -> (Text) -> Text) -> Text {
        var text = Text("")
        for (range, annotations) in flattenedAnnotations {
            var subtext = factory(nil)(Text(rawValue[range]))
            for annotation in annotations {
                subtext = factory(annotation)(subtext)
            }
            text = text + subtext
        }
        return text
    }

    private var flattenedAnnotations: [(Range<String.Index>, [T])] {
                
        var stack: [String.Index: [T]] = [:]
        
        for (range, annotation) in rawAnnotations {
            var start = range.lowerBound
            repeat {
                stack[start, default:[]].append(annotation)
                start = rawValue.index(after: start)
            } while start < range.upperBound
        }
                
        var result: [(Range<String.Index>, [T])] = []
        
        var start = rawValue.startIndex
        for i in rawValue.indices where i != start {
            if stack[i] == stack[start] {
                continue
            } else {
                result.append((start..<i, stack[start] ?? []))
                start = i
            }
        }
        
        if start != rawValue.endIndex {
            result.append((start..<rawValue.endIndex, stack[start] ?? []))
        }

        return result
    }

}
#endif
