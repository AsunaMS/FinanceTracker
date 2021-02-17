//
//  CurrencyDataSource.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 08/02/2021.
//

import Foundation


class CurrencyDataSource {
    static var shared:[String: Double] = [:]
    static func loadCurrencies(base:String,errorMessage: @escaping (String?) -> Void) {
        var components = URLComponents()
        // url components
        components.scheme = "https"
        components.host = "api.exchangeratesapi.io"
        components.path = "/latest"
        // url query items
        let queryItemBase = URLQueryItem(name: "base", value: base)
        components.queryItems = [queryItemBase]
        // access currency rates and get a dictionary of [name:value] against base
        guard let url = components.url else {
            errorMessage("[loadCurrencies] Could not load url")
            return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                errorMessage("[loadCurrencies] Could not data from dataTask: \(error.localizedDescription)")
                return
            }
            if let data = data {
                guard  let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    errorMessage("[loadCurrencies] Could not load JSON from given data")
                    return}
                if let dictionary = jsonWithObjectRoot as? [String: Any] {
                    if let nestedDictionary = dictionary["rates"] as? [String: Double] {
                        CurrencyDataSource.shared = nestedDictionary
                    }
                }
            }
        }.resume()
    }
    
    
    // change the base currency of the application
    static func changeBaseCurrency(newCurrency: Currency,errorMessage: @escaping (String?) -> Void) {
        var components = URLComponents()
        // url components
        components.scheme = "https"
        components.host = "api.exchangeratesapi.io"
        components.path = "/latest"
        // url query items
        let queryItemBase = URLQueryItem(name: "base", value: newCurrency.name)
        components.queryItems = [queryItemBase]
        guard let url = components.url else {
            errorMessage("[changeBaseCurrency] Could not load url")
            return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                errorMessage("[changeBaseCurrency] Could not data from dataTask: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                return}
            guard let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data, options: []) else {
                errorMessage("[changeBaseCurrency] Could not load JSON from given data")
                return
            }
            if let dictionary = jsonWithObjectRoot as? [String: Any] {
                if let nestedDictionary = dictionary["rates"] as? [String: Double] {
                    CurrencyDataSource.shared = nestedDictionary
                    var newCurrencyValues:[Double] = []
                    for value in nestedDictionary.values {
                        newCurrencyValues.append(value)
                    }
                    
                    errorMessage(nil)
                }
            }
        }.resume()
    }
}

