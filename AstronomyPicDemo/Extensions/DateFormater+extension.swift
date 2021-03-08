//
//  DateFormater+extension.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/6.
//

import Foundation

enum DateFormat: String{
//    Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
//    09/12/2018                        --> MM/dd/yyyy
//    09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
//    Sep 12, 2:11 PM                   --> MMM d, h:mm a
//    September 2018                    --> MMMM yyyy
//    Sep 12, 2018                      --> MMM d, yyyy
//    Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
//    2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
//    12.09.18                          --> dd.MM.yy
//    10:41:02.112                      --> HH:mm:ss.SSS
//    2006-12-31                        --> yyyy-MM-dd
    case slashDate = "yyyy/MM/dd"
    case Date = "yyyy-MM-dd"
    case DateTime = "yyyy-MM-dd HH:mm:ss"
    case RecordTime = "yyyy/MM.dd HH:mm:ss"
    case Month = "yyyy MMM.d"
}
extension String{
    func formatterDateString(currentFormat: DateFormat, to format: DateFormat) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = currentFormat.rawValue
        let date =  dateformatter.date(from: self)!
        dateformatter.dateFormat = format.rawValue
        let dateStr = dateformatter.string(from: date)
        return dateStr
    }
}
