//
//  BaseModel.swift
//  Nasa
//
//  Created by Coşkun Güngör on 4.05.2022.
//

import Foundation
public struct BaseModel:Codable{
    let photos:[PhotoObject]?
}

public struct PhotoObject:Codable{
    let id:Int?
    let sol:Int?
    let camera:CameraObject?
    let img_src:String?
    let earth_date:String?
    let rover:RoverObject?
}

public struct RoverObject:Codable{
    let id:Int?
    let name:String?
    let landing_date:String?
    let launch_date:String?
    let status:String?
}

public struct CameraObject:Codable{
    let id:Int?
    let name:String?
    let rover_id:Int?
    let full_name:String?
}
