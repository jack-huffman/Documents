//
//  Document.swift
//  Documents
//
//  Created by Jack Huffman on 1/31/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import Foundation

class Document {
    var title: String
    var body: String
    var dateModified: Date
    
    init(title: String, body: String, dateModified: Date) {
        self.title = title
        self.body = body
        self.dateModified = dateModified
    }
}
