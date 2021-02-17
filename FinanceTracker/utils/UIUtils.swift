//
//  UIUtils.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 01/02/2021.
//

import UIKit

class UIUtils {
    // set background image for UIView
    public static func setBackgroundImage(pView:UIView) {
        let image = #imageLiteral(resourceName: "bgColor").resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        pView.backgroundColor = UIColor(patternImage: image)
    }
    // set background image for UIView ( used for login )
    public static func setLoginBackgroundImage(pView:UIView) {
        let image = #imageLiteral(resourceName: "chart").resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        pView.backgroundColor = UIColor(patternImage: image)
        
    }
    // get a nice formatted string of a Date instance
    public static func getFormattedDateString(for date: Date, dateStyle: DateFormatter.Style) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        return dateFormatter.string(from: date)
    }
    // get a nice formatted decimal string for a Int64 instance
    public static func getFormattedNumberString(for num: Int64?) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let str = numberFormatter.string(from: NSNumber(value: num ?? 0)) else {return "0"}
        return str
    }

    
}
