//
//  Movie.swift
//  SuitMovieMvvm
//
//  Created by Bayu Paoh on 31/10/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Movie: Object {
    
    @objc dynamic var id : Int64 = 0
    @objc dynamic var vote_count : Int = 0
    @objc dynamic var video: Bool = false
    @objc dynamic var vote_average: Double = 0
    @objc dynamic var title: String?
    @objc dynamic var popularity:Double = 0
    @objc dynamic var poster_path:String?
    @objc dynamic var original_language:String?
    @objc dynamic var adult: Bool = false
    @objc dynamic var original_title:String?
    @objc dynamic var backdrop_path:String?
    @objc dynamic var overview:String?
    @objc dynamic var release_date:String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    public static func with(realm: Realm, json: JSON) -> Movie? {
        let identifier = json["id"].int64Value
        if identifier == 0 {
            return nil
        }
        var obj = realm.object(ofType: Movie.self, forPrimaryKey: identifier)
        if obj == nil {
            obj = Movie()
            obj?.id = identifier
        } else {
            obj = Movie(value: obj!)
        }
        
        if json["vote_count"].exists() {
            obj?.vote_count = json["vote_count"].intValue
        }
        
        if json["video"].exists() {
            obj?.video = json["video"].boolValue
        }
        
        if json["vote_average"].exists() {
            obj?.vote_average = json["vote_average"].doubleValue
        }
        
        if json["title"].exists() {
            obj?.title = json["title"].string
        }
        
        if json["popularity"].exists() {
            obj?.popularity = json["popularity"].doubleValue
        }
        
        if json["poster_path"].exists() {
            obj?.poster_path = json["poster_path"].string
        }
        
        if json["original_language"].exists() {
            obj?.original_language = json["original_language"].string
        }
        
        if json["original_title"].exists() {
            obj?.original_title = json["original_title"].string
        }
        
        if json["backdrop_path"].exists() {
            obj?.backdrop_path = json["backdrop_path"].string
        }
        
        if json["overview"].exists() {
            obj?.overview = json["overview"].string
        }
        
        if json["release_date"].exists() {
            obj?.release_date = json["release_date"].string
        }
        
        if json["adult"].exists() {
            obj?.adult = json["adult"].boolValue
        }
        
        return obj
    }
    
    public static func with(json: JSON) -> Movie? {
        return with(realm: try! Realm(), json: json)
    }
    
}
