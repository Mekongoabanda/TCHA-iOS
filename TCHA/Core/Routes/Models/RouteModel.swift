//
//  RouteModel.swift
//  TCHA
//
//  Created by Yannick Edouard MEKONGO ABANDA on 30/04/2023.
//

import Foundation

class RouteModel {
    var userId: String
    var status: String
    var arrivalName: String
    var departureName: String
    var price: Double
    var nbKilo: Double
    var priceByKilo: Double
    var arrivalDate: Date
    var departureDate: Date
    var travelTime: Double
    var views : Int64
    
    init(userId: String, status: String, arrivalName: String, departureName: String, price: Double, nbKilo: Double, priceByKilo: Double, arrivalDate: Date, departureDate: Date, travelTime: Double, views : Int64) {
        self.userId = userId
        self.status = status
        self.arrivalName = arrivalName
        self.departureName = departureName
        self.price = price
        self.nbKilo = nbKilo
        self.priceByKilo = priceByKilo
        self.arrivalDate = arrivalDate
        self.departureDate = departureDate
        self.travelTime = travelTime
        self.views = views
    }
    
    convenience init() {
        self.init(userId: "", status: "", arrivalName: "", departureName: "", price: 0.0, nbKilo: 0.0, priceByKilo: 0.0, arrivalDate: Date(), departureDate: Date(), travelTime: 0.0, views: 0)
    }
    
    
}

