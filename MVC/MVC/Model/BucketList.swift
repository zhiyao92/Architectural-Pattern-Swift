//
//  BucketList.swift
//  MVC
//
//  Created by Kelvin Tan on 03/06/2021.
//

import Foundation

struct BucketList: Equatable {
    let name: String
    let date: Date
    var completed: Bool = false
    var givenUp: Bool = false
}
