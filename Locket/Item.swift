//
//  Item.swift
//  Locket
//
//  Created by 劉旭庭 on 2024/10/17.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
