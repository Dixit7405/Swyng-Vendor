//
//  Profile.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 16, 2021

import Foundation

struct Profile : Codable{
    
    let bloodGroup : String?
    let cityId : Int?
    let city : Int?
    let createdAt : String?
    let dateOfBirth : String?
    let email : String?
    let emergencyContactName : String?
    let emergencyContactNumber : String?
    let fname : String?
    let gender : String?
    let isDeleted : Bool?
    let isUsedOTP : Bool?
    let lname : String?
    let mobileNo : String?
    let oTP : String?
    let password : String?
    let role : String?
    let status : String?
    let tShirtSize : String?
    let uniqueCode : String?
    let updatedAt : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case bloodGroup = "bloodGroup"
        case cityId = "cityId"
        case createdAt = "createdAt"
        case dateOfBirth = "dateOfBirth"
        case email = "email"
        case emergencyContactName = "emergencyContactName"
        case emergencyContactNumber = "emergencyContactNumber"
        case fname = "fname"
        case gender = "gender"
        case isDeleted = "isDeleted"
        case isUsedOTP = "isUsedOTP"
        case lname = "lname"
        case mobileNo = "mobileNo"
        case oTP = "OTP"
        case password = "password"
        case role = "role"
        case status = "status"
        case tShirtSize = "tShirtSize"
        case uniqueCode = "uniqueCode"
        case updatedAt = "updatedAt"
        case userId = "userId"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bloodGroup = try values.decodeIfPresent(String.self, forKey: .bloodGroup)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        emergencyContactName = try values.decodeIfPresent(String.self, forKey: .emergencyContactName)
        emergencyContactNumber = try values.decodeIfPresent(String.self, forKey: .emergencyContactNumber)
        fname = try values.decodeIfPresent(String.self, forKey: .fname)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        isDeleted = try values.decodeIfPresent(Bool.self, forKey: .isDeleted)
        isUsedOTP = try values.decodeIfPresent(Bool.self, forKey: .isUsedOTP)
        lname = try values.decodeIfPresent(String.self, forKey: .lname)
        mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
        oTP = try values.decodeIfPresent(String.self, forKey: .oTP)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        tShirtSize = try values.decodeIfPresent(String.self, forKey: .tShirtSize)
        uniqueCode = try values.decodeIfPresent(String.self, forKey: .uniqueCode)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        city = try values.decodeIfPresent(Int.self, forKey: .city)
    }
    
    
}
