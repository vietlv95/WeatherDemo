//
//  ArrayExtensions.swift
//  BabyPhoto
//
//  Created by Thanh Vu on 6/24/20.
//  Copyright © 2020 Solar. All rights reserved.
//

import Foundation
extension Array {
    subscript (safe index: Int) -> Element? {
        get {
            return (0 <= index && index < count) ? self[index] : nil
        }
        
        set (value) {
            if value == nil {
                return
            }

            if !(count > index) {
                return
            }

            self[index] = value!
        }
    }
}

extension Array where Element:Equatable {
    @discardableResult
    mutating func removeObject(_ object: Element) -> Bool {
        guard let index = self.firstIndex(where: { (element) -> Bool in
            return object == element
        }) else { return false }

        self.remove(at: index)
        return true
    }
    
    mutating func popFirst() -> Element? {
        if let first = self.first {
            self.removeObject(first)
            return first
        }
        
        return nil
    }
}
