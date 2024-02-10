//
//  File.swift
//  Puzzle-iOS
//
//  Created by 신지원 on 2/9/24.
//

import UIKit

enum PuzzleBottomSheetType {
    case high, low
    
    var height: Double {
        switch self {
        case .high:
            return UIScreen.main.bounds.height * 0.86
        case .low:
            return 0
        }
    }
}
