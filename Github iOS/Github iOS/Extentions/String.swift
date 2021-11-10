//
//  Date.swift
//  Github iOS
//
//  Created by Numan Ayhan on 3.11.2021.
//

import Foundation
import UIKit

extension String {
    
    func toUTC() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: self) else { return Date() }
        return date
    }
    func convertDateString(date: String, format:String ) -> String {
        var finalTime = "00:00"
        let isoDate = date
        let dateFormatters = DateFormatter()
        dateFormatters.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatters.date(from: isoDate) {
             
            let dateFormattere = DateFormatter()
            dateFormattere.dateFormat = format
            let Date12 = dateFormattere.string(from: date)
            finalTime = Date12
        }
        
        return finalTime
    }
}
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
   }
    
}
