//
//  Extensions.swift
//  ScreenMazer
//
//  Created by Alex Beals on 8/12/18.
//  Copyright © 2018 Beals, Alex. All rights reserved.
//

import Foundation

extension String {
    func random() -> String {
        let rand = Int.random(in: 0 ..< count)
        let start = index(startIndex, offsetBy: rand)
        let end = index(start, offsetBy: 1)
        return String(self[start..<end])
    }
}
