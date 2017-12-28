//
//  DataBurialPointModel.swift
//  DataBurialPoint_Swift
//
//  Created by Darsky on 2017/12/23.
//  Copyright © 2017年 Darsky. All rights reserved.
//

import Foundation

class DataBurialPointModel: NSObject,NSCoding
{
    func encode(with aCoder: NSCoder) {
        var count: UInt32 = 0
        let ivars:UnsafeMutablePointer<Ivar> = class_copyIvarList(self.classForCoder, &count)!
        for i in 0..<count
        {
            let ivar = ivars[Int(i)]
            let ivarName = String(cString: ivar_getName(ivar)!)
            let value = self.value(forKey: ivarName)
            aCoder.encode(value, forKey: ivarName)
        }
        
        free(ivars)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init()
        var count: UInt32 = 0
        let ivars:UnsafeMutablePointer<Ivar> = class_copyIvarList(self.classForCoder, &count)!
        for i in 0..<count
        {
            let ivar = ivars[Int(i)]
            let ivarName = String(cString: ivar_getName(ivar)!)
            let value = aDecoder.decodeObject(forKey: ivarName)
            self.setValue(value, forKey: ivarName)
        }
        
        free(ivars)
        
    }
    
    var name:String = ""
    var page:String = ""
    var startTime:String = ""
    var endTime:String = ""
    var duration:String = ""


    override init()
    {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd HH:mm:ss SSS"
        self.startTime = formatter.string(from: Date())
    }
    
    func recordEndTime() -> ()
    {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd HH:mm:ss SSS"
        let startDate:Date? = formatter.date(from:self.startTime)
        if startDate != nil
        {
            let endDate:Date = Date()
            self.endTime = formatter.string(from: endDate)
            let duration:Double = endDate.timeIntervalSince(startDate!)*1000
            self.duration = "\(duration)"
            DataBurialPointManager.shareManager.insetDataWithModel(model:self)

        }

    }
}
