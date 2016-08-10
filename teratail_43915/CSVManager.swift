//
//  CSVManager.swift
//  teratail_43915
//
//  Created by Kentarou on 2016/08/10.
//  Copyright © 2016年 Kentarou. All rights reserved.
//

import Foundation

class CSVManager {

    /// Bundle personal.csv 読み込み → PersonalData配列
    class func readBundleCSVData() -> Array<PersonalData>? {
        
        var resultArray: [PersonalData] = []
        
        if let csvPath = NSBundle.mainBundle().pathForResource("personal", ofType: "csv") {
            
            do {
                let csvString = try String(contentsOfFile: csvPath, encoding: NSUTF8StringEncoding)
                csvString.enumerateLines { (line, stop) -> () in
                    
                    let personalData = PersonalData()
                    personalData.setDataFromArray(line.componentsSeparatedByString(","))
                    resultArray.append(personalData)
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        }
        return resultArray
    }
}