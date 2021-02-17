//
//  Currency.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 08/02/2021.
//

import Foundation



// a local reference for all the currencies available
class Currencies {
    static let shared:[Currency] = [.EUR,.USD,.CAD,.HKD,.ISK,.PHP,.DKK,.HUF,.CZK,.AUD,.RON,.SEK,.IDR,.INR,.BRL,.RUB,.HRK,.JPY,.THB,.CHF,.SGD,.PLN,.BGN,.TRY,.CNY,.NOK,.NZD,.ZAR,.MXN,.ILS,.GBP,.KRW,.MYR]
}
// currency object
struct CurrencyObj {
    var name:String
    var value:String
}
// all currency kinds
enum Currency {
    case EUR
    case CAD
    case HKD
    case ISK
    case PHP
    case DKK
    case HUF
    case CZK
    case AUD
    case RON
    case SEK
    case IDR
    case INR
    case BRL
    case RUB
    case HRK
    case JPY
    case THB
    case CHF
    case SGD
    case PLN
    case BGN
    case TRY
    case CNY
    case NOK
    case NZD
    case ZAR
    case USD
    case MXN
    case ILS
    case GBP
    case KRW
    case MYR
    
    // returns the currency name string
    var name:String {
        switch self  {
        case .CAD:
            return "CAD"
        case .HKD:
            return "HKD"
        case .ISK:
            return "ISK"
        case .PHP:
            return "PHP"
        case .DKK:
            return "DKK"
        case .HUF:
            return "HUF"
        case .CZK:
            return "CZK"
        case .AUD:
            return "AUD"
        case .RON:
            return "RON"
        case .EUR:
            return "EUR"
        case .SEK:
            return "SEK"
        case .IDR:
            return "IDR"
        case .INR:
            return "INR"
        case .BRL:
            return "BRL"
        case .RUB:
            return "RUB"
        case .HRK:
            return "HRK"
        case .JPY:
            return "JPY"
        case .THB:
            return "THB"
        case .CHF:
            return "CHF"
        case .SGD:
            return "SGD"
        case .PLN:
            return "PLN"
        case .BGN:
            return "BGN"
        case .TRY:
            return "TRY"
        case .CNY:
            return "CNY"
        case .NOK:
            return "NOK"
        case .NZD:
            return "NZD"
        case .ZAR:
            return "ZAR"
        case .USD:
            return "USD"
        case .MXN:
            return "MXN"
        case .ILS:
            return "ILS"
        case .GBP:
            return "GBP"
        case .KRW:
            return "KRW"
        case .MYR:
            return "MYR"
        }
    }
    
    // returns the currency symbol string
    var symbol:String {
        switch self  {
        case .CAD:
            return "$"
        case .HKD:
            return "$"
        case .ISK:
            return "kr"
        case .PHP:
            return "₱"
        case .DKK:
            return "kr"
        case .HUF:
            return "Ft"
        case .CZK:
            return "Kč"
        case .AUD:
            return "$"
        case .EUR:
            return "€"
        case .RON:
            return "lei"
        case .SEK:
            return "kr"
        case .IDR:
            return "Rp"
        case .INR:
            return "INR"
        case .BRL:
            return "R$"
        case .RUB:
            return "₽"
        case .HRK:
            return "kn"
        case .JPY:
            return "¥"
        case .THB:
            return "฿"
        case .CHF:
            return "CHF"
        case .SGD:
            return "$"
        case .PLN:
            return "zł"
        case .BGN:
            return "лв"
        case .TRY:
            return "TRY"
        case .CNY:
            return "¥"
        case .NOK:
            return "kr"
        case .NZD:
            return "$"
        case .ZAR:
            return "R"
        case .USD:
            return "$"
        case .MXN:
            return "$"
        case .ILS:
            return "₪"
        case .GBP:
            return "£"
        case .KRW:
            return "₩"
        case .MYR:
            return "RM"
        }
    }
    
}
