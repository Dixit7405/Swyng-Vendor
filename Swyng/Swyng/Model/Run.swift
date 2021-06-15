//
//  Run.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 13, 2021

import Foundation

struct Run : Codable {

        let aboutOrganizer : String?
        let aboutRun : String?
        let asPerSchedule : Bool?
        let bidCollection : String?
        let category : [Int]?
        let createdAt : String?
        let creativeFontColor : String?
        let dates : [String]?
        let eventStartTime : String?
        let frequentlyAsked : String?
        let galleryImage : String?
        let headerImage : String?
        let id : Int?
        let isOnlineRegistration : Bool?
        let organizer : String?
        let people1 : [Int]?
        let pleaseNote : String?
        let registerBeforeFromStartTime : String?
        let reportingTime : String?
        let routeMap : String?
        let runName : String?
        let runInformation : String?
        let sports : [Int]?
        let termsAndCondition : String?
        let thumbnailImage : String?
        let updatedAt : String?
        let venue : Int?
        let venueAddress : String?
        let venueCity : Int?
        let venueGoogleMap : String?

        enum CodingKeys: String, CodingKey {
                case aboutOrganizer = "aboutOrganizer"
                case aboutRun = "aboutRun"
                case asPerSchedule = "as_per_schedule"
                case bidCollection = "bidCollection"
                case category = "category"
                case createdAt = "createdAt"
                case creativeFontColor = "creativeFontColor"
                case dates = "dates"
                case eventStartTime = "event_start_time"
                case frequentlyAsked = "frequentlyAsked"
                case galleryImage = "galleryImage"
                case headerImage = "headerImage"
                case id = "id"
                case isOnlineRegistration = "is_online_registration"
                case organizer = "organizer"
                case people1 = "people1"
                case pleaseNote = "pleaseNote"
                case registerBeforeFromStartTime = "register_before_from_start_time"
                case reportingTime = "reporting_time"
                case routeMap = "routeMap"
                case runName = "run_name"
                case runInformation = "runInformation"
                case sports = "sports"
                case termsAndCondition = "termsAndCondition"
                case thumbnailImage = "thumbnailImage"
                case updatedAt = "updatedAt"
                case venue = "venue"
                case venueAddress = "venue_address"
                case venueCity = "venue_city"
                case venueGoogleMap = "venue_google_map"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                aboutOrganizer = try values.decodeIfPresent(String.self, forKey: .aboutOrganizer)
                aboutRun = try values.decodeIfPresent(String.self, forKey: .aboutRun)
                asPerSchedule = try values.decodeIfPresent(Bool.self, forKey: .asPerSchedule)
                bidCollection = try values.decodeIfPresent(String.self, forKey: .bidCollection)
                category = try values.decodeIfPresent([Int].self, forKey: .category)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                creativeFontColor = try values.decodeIfPresent(String.self, forKey: .creativeFontColor)
                dates = try values.decodeIfPresent([String].self, forKey: .dates)
                eventStartTime = try values.decodeIfPresent(String.self, forKey: .eventStartTime)
                frequentlyAsked = try values.decodeIfPresent(String.self, forKey: .frequentlyAsked)
                galleryImage = try values.decodeIfPresent(String.self, forKey: .galleryImage)
                headerImage = try values.decodeIfPresent(String.self, forKey: .headerImage)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isOnlineRegistration = try values.decodeIfPresent(Bool.self, forKey: .isOnlineRegistration)
                organizer = try values.decodeIfPresent(String.self, forKey: .organizer)
                people1 = try values.decodeIfPresent([Int].self, forKey: .people1)
                pleaseNote = try values.decodeIfPresent(String.self, forKey: .pleaseNote)
                registerBeforeFromStartTime = try values.decodeIfPresent(String.self, forKey: .registerBeforeFromStartTime)
                reportingTime = try values.decodeIfPresent(String.self, forKey: .reportingTime)
                routeMap = try values.decodeIfPresent(String.self, forKey: .routeMap)
                runName = try values.decodeIfPresent(String.self, forKey: .runName)
                runInformation = try values.decodeIfPresent(String.self, forKey: .runInformation)
                sports = try values.decodeIfPresent([Int].self, forKey: .sports)
                termsAndCondition = try values.decodeIfPresent(String.self, forKey: .termsAndCondition)
                thumbnailImage = try values.decodeIfPresent(String.self, forKey: .thumbnailImage)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                venue = try values.decodeIfPresent(Int.self, forKey: .venue)
                venueAddress = try values.decodeIfPresent(String.self, forKey: .venueAddress)
                venueCity = try values.decodeIfPresent(Int.self, forKey: .venueCity)
                venueGoogleMap = try values.decodeIfPresent(String.self, forKey: .venueGoogleMap)
        }

}
