//
//  UIKitLabel.swift
//  Annotated Example
//
//  Created by Jérôme Alves on 09/11/2020.
//

import Foundation
import UIKit
import SwiftUI

struct UIKitLabel: UIViewRepresentable {
    
    var attributedText: NSAttributedString
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }
    
    func updateUIView(_ label: UILabel, context: Context) {
        label.attributedText = attributedText
    }
}
