//
//  ContentView.swift
//  Annotated Example
//
//  Created by Jérôme Alves on 08/11/2020.
//

import SwiftUI
import Annotated

enum AddressAnnotations: Hashable {
    case city, postalCode, highlighted
}

struct ContentView: View {
    
    let string: Annotated<AddressAnnotations> = {
        var string: Annotated<AddressAnnotations> = """
        1 Infinite Loop
        \("Cupertino", .city), CA \(95014, .postalCode)
        """
        
        string.addAnnotation(.highlighted, at: 0..<1)
        string.addAnnotation(.highlighted, forOccurencesOf: "in", options: .caseInsensitive)
        
        return string
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("UIKit.UILabel + NSAttributedString").font(.caption)
            UIKitLabel(attributedText: attributedText)
                .padding()
                .border(Color.red)
            Spacer()
            Text("SwiftUI.Text").font(.caption)
            text
                .padding()
                .border(Color.red)
            Spacer()
        }
        .padding()
    }
    
    var attributedText: NSAttributedString {
        string.makeAttributedString { annotation in
            switch annotation {
            case nil:          return [.font: UIFont.systemFont(ofSize: 24)]
            case .city:        return [.font: UIFont.boldSystemFont(ofSize: 24)]
            case .postalCode:  return [.underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)]
            case .highlighted: return [.foregroundColor: UIColor.systemRed]
            }
        }
    }

    var text: Text {
        string.makeText { annotation in
            switch annotation {
            case nil:          return { $0.font(.system(size: 24)) }
            case .city:        return { $0.bold() }
            case .postalCode:  return { $0.underline() }
            case .highlighted: return { $0.foregroundColor(.red) }
            }
        }
    }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
