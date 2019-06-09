//
//  DateHelper.swift
//  TheMovieDbClient
//
//  Created by Leo Salmaso on 02/06/2019.
//  Copyright © 2019 Leo Salmaso. All rights reserved.
//

import Foundation

class DateHelper {
    public static let sharedInstance: DateHelper = {
        return DateHelper()
    }()
    
    private static let defaultFormat = "yyyy-mm-dd"
    
    private lazy var dateFormatter: DateFormatter = {
        return DateFormatter()
    }()
    
    private init() {}
    
    func dateFromString(_ stringDate: String, withFormat format: String = DateHelper.defaultFormat) -> Date? {
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: stringDate)
    }
    
    func componentFromDate(_ date: Date, component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: date)
    }
}
