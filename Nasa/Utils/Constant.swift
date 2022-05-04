//
//  Constant.swift
//  BraveNewCoin
//
//  Created by Coşkun Güngör on 28.04.2022.
//

import Foundation
import Alamofire
struct Constant
{
    
    static let API_ROVER_TYPE_CURIOSITY = "curiosity"
    static let API_ROVER_TYPE_OPPERTUNITY = "opportunity"
    static let API_ROVER_TYPE_SPIRIT = "spirit"
    static let API_URL = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
    static let API_VISIBLE_TYPE = "/photos?sol=1000&api_key="
    static let API_KEY = "I6iucdH7uPgqNeQLiGPXuqdMgqtA3OQU0bSSiNav"
    static let API_PAGINATION = "&page=1"
    static let REQUEST_TIMEOUT:TimeInterval = 30;
    static var arrData:[PhotoObject]?
    static var arrFilterCuriosity = ["ALL","FHAZ","RHAZ","MAST","CHEMCAM","MAHLI","MARDI","NAVCAM"]
    static var arrFilterOpportunity = ["ALL","FHAZ","RHAZ","NAVCAM","PANCAM","MINITES"]
    static var arrFilterSpirit = ["ALL","FHAZ","RHAZ","NAVCAM","PANCAM","MINITES"]
    
    
    enum FilterOutput: Equatable {
        case curiosity
        case opportunity
        case spirit
    }
}
