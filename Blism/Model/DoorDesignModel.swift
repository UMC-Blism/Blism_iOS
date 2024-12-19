//
//  DoorDesignModel.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

struct DoorDesignModel {
    let image: UIImage
}

extension DoorDesignModel {
    static func doorDesigns() -> [DoorDesignModel] {
        return [
            DoorDesignModel(image: .doorA1),
            DoorDesignModel(image: .doorB1),
            DoorDesignModel(image: .doorC1),
            DoorDesignModel(image: .doorD1)
        ]
    }
}
