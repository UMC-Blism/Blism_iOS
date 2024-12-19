//
//  DoorDesignModel.swift
//  Blism
//
//  Created by 이재혁 on 12/19/24.
//

import UIKit

struct DoorDesignModel {
    let image: UIImage
    let tag: Int
}

extension DoorDesignModel {
    static func doorDesigns() -> [DoorDesignModel] {
        return [
            DoorDesignModel(image: .doorA1, tag: 1),
            DoorDesignModel(image: .doorB1, tag: 2),
            DoorDesignModel(image: .doorC1, tag: 3),
            DoorDesignModel(image: .doorD1, tag: 4)
        ]
    }
    
    static func doorAColors() -> [DoorDesignModel] {
        return [
            DoorDesignModel(image: .doorA1, tag: 1),
            DoorDesignModel(image: .doorA2, tag: 2),
            DoorDesignModel(image: .doorA3, tag: 3),
            DoorDesignModel(image: .doorA4, tag: 4)
        ]
    }
    
    static func doorBColors() -> [DoorDesignModel] {
        return [
            DoorDesignModel(image: .doorB1, tag: 1),
            DoorDesignModel(image: .doorB2, tag: 2),
            DoorDesignModel(image: .doorB3, tag: 3),
            DoorDesignModel(image: .doorB4, tag: 4)
        ]
    }
    
    static func doorCColors() -> [DoorDesignModel] {
        return [
            DoorDesignModel(image: .doorC1, tag: 1),
            DoorDesignModel(image: .doorC2, tag: 2),
            DoorDesignModel(image: .doorC3, tag: 3),
            DoorDesignModel(image: .doorC4, tag: 4)
        ]
    }
    
    static func doorDColors() -> [DoorDesignModel] {
        return [
            DoorDesignModel(image: .doorD1, tag: 1),
            DoorDesignModel(image: .doorD2, tag: 2),
            DoorDesignModel(image: .doorD3, tag: 3),
            DoorDesignModel(image: .doorD4, tag: 4)
        ]
    }
}
