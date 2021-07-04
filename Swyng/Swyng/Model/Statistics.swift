//
//  Statistics.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 28, 2021

import Foundation

struct Statistics : Codable {

        let category : [Category]?
        let completedRegistration : Int?
        let totalAmount : Int?
        let totalRegistration : Int?

        enum CodingKeys: String, CodingKey {
                case category = "Category"
                case completedRegistration = "CompletedRegistration"
                case totalAmount = "TotalAmount"
                case totalRegistration = "TotalRegistration"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                category = try values.decodeIfPresent([Category].self, forKey: .category)
                completedRegistration = try values.decodeIfPresent(Int.self, forKey: .completedRegistration)
                totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
                totalRegistration = try values.decodeIfPresent(Int.self, forKey: .totalRegistration)
        }

}

struct Category : Codable {

        let categoryId : Int?
        let categoryName : String?
        let registeredTickets : Int?
        let totalAmount : Int?
        let totalTickets : Int?
    let amount : String?
    let name : String?

        enum CodingKeys: String, CodingKey {
                case categoryId = "CategoryId"
                case categoryName = "CategoryName"
                case registeredTickets = "RegisteredTickets"
                case totalAmount = "TotalAmount"
                case totalTickets = "TotalTickets"
            case amount = "amount"
            case name = "name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
                categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
                registeredTickets = try values.decodeIfPresent(Int.self, forKey: .registeredTickets)
                totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
                totalTickets = try values.decodeIfPresent(Int.self, forKey: .totalTickets)
            amount = try values.decodeIfPresent(String.self, forKey: .amount)
            name = try values.decodeIfPresent(String.self, forKey: .name)
        }

}
