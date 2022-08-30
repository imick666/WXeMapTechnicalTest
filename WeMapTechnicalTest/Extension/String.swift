//
//  String.swift
//  WeMapTechnicalTest
//
//  Created by Mickael Ruzel on 30/08/2022.
//

import Foundation
import UIKit

extension String {
    var fromHtml: String? {
        let breaked = self.replacingOccurrences(of: "\n", with: "</br>")
        guard let data = breaked.data(using: .unicode, allowLossyConversion: true),
              let attributesString = try? NSAttributedString(data: data,
                                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8.rawValue],
                                                             documentAttributes: nil),
              !attributesString.string.isEmpty
        else {
            return nil
        }
        
        return attributesString.string
    }
}
