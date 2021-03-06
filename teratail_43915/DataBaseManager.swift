//
//  DataBaseManager.swift
//  teratail_43915
//
//  Created by Kentarou on 2016/08/10.
//  Copyright © 2016年 Kentarou. All rights reserved.
//

import Foundation


class DataBaseManager {
    
    static let sharedInstance: DataBaseManager = {
        let instance = DataBaseManager()
        return instance
    }()
    
    var db: FMDatabase!
    
    init() {
        db = FMDatabase(path: dataBasePath())
    }
    
    // Database Path
    func dataBasePath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as NSString
        let _path = path.stringByAppendingPathComponent("Personal.db")
        return _path
    }
    

    // Create Personal Table
    func createPersonalDataBase() {
        let sql = "CREATE TABLE IF NOT EXISTS Personal (id integer PRIMARY KEY AUTOINCREMENT, Name TEXT, Age INTEGER, Address TEXT);"
        
        // Open DataBase
        db.open()
        
        if db.executeUpdate(sql, withArgumentsInArray: nil) {
            print("Table Create Success")
        }
        
        // Close DataBase
        db.close()
    }
    
    // Insert Personal Data
    func insertPersonalData(data: PersonalData) {
        let sql = "INSERT INTO Personal (Name, Age, Address) VALUES (?, ?, ?);"
        
        db.open()
        db.executeUpdate(sql, withArgumentsInArray: [data.name, Int(data.age), data.address])
        db.close()
    }
    
    func updatePersonalData(newData: PersonalData, updateData: PersonalData) {
       
        let sql = "UPDATE Personal SET Name='\(newData.name)', age=\(newData.age), address='\(newData.address)' where Name='\(updateData.name)' AND Age=\(updateData.age)"
        
        db.open()
        db.executeUpdate(sql, withArgumentsInArray: nil)
        db.close()
    }
    
    
    // Select Personal Data
    func selectPersonalAllData() -> Array<PersonalData> {
        
        let sql = "SELECT * FROM Personal ORDER BY Name;"
        db.open()
        
        let results = db.executeQuery(sql, withArgumentsInArray: nil)
        
        var resultArray: Array<PersonalData> = []
        
        while results.next() {
            let personal = PersonalData()
            personal.id      = Int(results.intForColumn("id"))
            personal.name    = results.stringForColumn("name")
            personal.age     = Int(results.intForColumn("age"))
            personal.address = results.stringForColumn("address")
            resultArray.append(personal)
        }
        db.close()
        
        return resultArray
    }
    
    // Delete Personal AllData
    func deleteAllPersonalData() {
        let sql = "delete from Personal;"
        
        db.open()
        db.executeUpdate(sql, withArgumentsInArray: nil)
        db.close()
    }
    
    
    func resetAutoIncrement() {
        let sql = "delete from sqlite_sequence where name = 'Personal'"
        
        db.open()
        db.executeUpdate(sql, withArgumentsInArray: nil)
        db.close()
    }
}