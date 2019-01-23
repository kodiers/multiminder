//
//  ReminderGroup.swift
//  multiminder
//
//  Created by Viktor Yamchinov on 23/01/2019.
//  Copyright © 2019 Viktor Yamchinov. All rights reserved.
//

import Foundation

struct ReminderGroup: Codable {
    var name: String
    var items: [Reminder]
}
