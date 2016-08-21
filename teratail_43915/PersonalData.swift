//
//  PersonalData.swift
//  teratail_43915
//
//  Created by Kentarou on 2016/08/10.
//  Copyright © 2016年 Kentarou. All rights reserved.
//

import Foundation

class PersonalData {
    var name   : String!
    var age    : Int!
    var address: String!
    var id     : Int = 0
    
    func setDataFromArray(dataArray: Array<String>) {
        
        for (index, value) in dataArray.enumerate() {
            switch index {
            case 0: name    = value
            case 1: age     = Int(value)
            case 2: address = value
            default: break
            }
        }
    }
}