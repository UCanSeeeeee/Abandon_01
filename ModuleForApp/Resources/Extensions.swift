//
//  Extensions.swift
//  ModuleForApp
//
//  Created by 王杰 on 2022/8/24.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
