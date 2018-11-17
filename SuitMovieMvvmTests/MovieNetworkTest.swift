//
//  MovieNetworkTest.swift
//  SuitMovieMvvmTests
//
//  Created by Bayu Paoh on 03/11/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import CoreText
import RxTest

@testable import SuitMovieMvvm

class MovieNetworkTest: XCTestCase {
    
    public var service = SMEngineService.instance
    public var disposeBag = DisposeBag()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func getMovie() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        service.favoriteMovie(apiKey: "1b2f29d43bf2e4f3142530bc6929d341", page: 1)
        .asObservable()
        .do(onNext: { data in
            XCTAssertEqual(data.count > 0, true)
        })
        .do(onError:{ error in
            XCTAssertEqual(false, true)
        })
        .subscribe()
        .disposed(by: disposeBag)
    }
}
