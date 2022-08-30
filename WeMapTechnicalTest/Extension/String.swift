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
        guard let data = self.data(using: .utf8),
              let attributesString = try? NSAttributedString(data: data,
                                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8.rawValue ],
                                                             documentAttributes: nil),
              !attributesString.string.isEmpty
        else {
            return nil
        }
        
        return attributesString.string
    }
}
