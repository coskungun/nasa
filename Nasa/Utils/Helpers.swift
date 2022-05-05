//
//  Helpers.swift
//  Nasa
//
//  Created by Coşkun Güngör on 5.05.2022.
//

import Foundation
import UIKit

class Helpers: NSObject {
    public static func getFormattedDate(stringDate: String , defaultFormat:String,convertFormat:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = defaultFormat
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = convertFormat
        
        let date: Date? = dateFormatterGet.date(from: stringDate)
        return dateFormatterPrint.string(from: date!);
    }
    
    public static func returnStringdate(returndateFormat:String) -> String
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = returndateFormat
        
        let date:Date = .init()
        return dateFormatterPrint.string(from: date)
    }
    
    

    
    
}

