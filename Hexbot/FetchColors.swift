//
//  FetchColors.swift
//  Hexbot
//
//  Created by Atheer on 2020-05-14.
//  Copyright © 2020 Atheer. All rights reserved.
//

import Foundation

class FetchColors {
    var colors = [Color]()
    
    func parse(json: Data) {
           let decoder = JSONDecoder()
           
           if let jsonColors = try? decoder.decode(Colors.self, from: json) {
               colors = jsonColors.colors
            }
       }

    @objc func fetchJson(count: Int) {
           let urlString = "https://api.noopschallenge.com/hexbot?count=\(count)"
           
           if let url = URL(string: urlString) {
               if let data = try? Data(contentsOf: url) {
                   parse(json: data)
               }
           }
        }
}

   
