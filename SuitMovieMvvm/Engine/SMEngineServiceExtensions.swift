//
//  SMEngineServiceExtensions.swift
//  SuitMovieMvvm
//
//  Created by Rifat Firdaus on 10/1/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

import RxSwift
import RxCocoa

struct APIResponse {
    var message: String?
    var code: Int?
    var result: JSON?
}

extension SMEngineService {
    func favoriteMovie(apiKey:String) -> Observable<[Movie]> {
        return manager.requestJSON(.get, home + "/3/discover/movie?api_key=\(apiKey)", parameters: nil, headers: nil)
            .mapJson()
            .do(onError: { error in
                print("🚫 \(error.localizedDescription)")
            })
            .map({ data in
                var dataList = [Movie]()
                for item in data["results"].arrayValue {
                    if let match = Movie.with(json: item) {
                        dataList.append(match)
                    }
                }
                return dataList
            })
    }
    
}
