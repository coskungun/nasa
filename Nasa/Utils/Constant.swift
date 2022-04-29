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
    
    static let API_URL = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key="
    static let API_KEY = "I6iucdH7uPgqNeQLiGPXuqdMgqtA3OQU0bSSiNav"
    static let API_PAGINATION = "&page=1"
    static let REQUEST_TIMEOUT:TimeInterval = 30;
    
}

let headersCallPost :HTTPHeaders = [
    "content-type": "application/json",
    "X-RapidAPI-Host": "bravenewcoin.p.rapidapi.com",
    "X-RapidAPI-Key": "c09c21c537mshca0c4cd2d683d6fp1fea84jsn24fae9f84f9b"
]
let headersCallGet :HTTPHeaders = [
    "X-RapidAPI-Host": "bravenewcoin.p.rapidapi.com",
    "X-RapidAPI-Key": "c09c21c537mshca0c4cd2d683d6fp1fea84jsn24fae9f84f9b"
]
let parametersCall = [
    "audience": "https://api.bravenewcoin.com",
    "client_id": "oCdQoZoI96ERE9HY3sQ7JmbACfBf55RY",
    "grant_type": "client_credentials"
]
