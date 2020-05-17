//
//  FetchColor.swift
//  Hexbot
//
//  Created by Atheer on 2019-06-13.
//  Copyright © 2019 Atheer. All rights reserved.
//

import Foundation

struct Colors: Codable {
    var colors: [Color]
}

struct Color: Codable {
    var value: String
}

