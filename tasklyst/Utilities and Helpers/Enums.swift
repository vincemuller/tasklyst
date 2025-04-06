//
//  Enums.swift
//  tasklyst
//
//  Created by Vince Muller on 4/3/25.
//

import SwiftUI


enum StatusSort: Identifiable, CaseIterable {
    case all, incomplete, completed
    var id: Self { self }
    var label: String {
        switch self {
        case .all:
            return "All Items"
        case .incomplete:
            return "Incomplete Items"
        case .completed:
            return "Completed Items"
        }
    }
}
