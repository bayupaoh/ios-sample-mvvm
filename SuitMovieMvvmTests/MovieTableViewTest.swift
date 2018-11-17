//
//  MovieTableViewTest.swift
//  SuitMovieMvvmTests
//
//  Created by Bayu Paoh on 04/11/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift
import CoreText
import RxTest

@testable import SuitMovieMvvm

class MovieTableViewTest: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableViewWhenReachBottomandClick() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testScheduler = TestScheduler(initialClock: 0)
        let mockReachBottomTriggerEvents: [Recorded<Event<Void>>] = [
            Recorded.next(50, ()),
            Recorded.next(100, ()),
            Recorded.next(200, ())
        ]
        
        let indexPath = IndexPath(item: 0, section: 0)
        let mockClickTriggerEvents: [Recorded<Event<IndexPath>>] = []
        
        let mockReachBottomGridTrigger = testScheduler.createHotObservable(mockReachBottomTriggerEvents)
        let mockClickTrigger = testScheduler.createHotObservable(mockClickTriggerEvents)
        let observerMovieCell = testScheduler.createObserver([Movie].self)
        
        let vm = MovieViewModel()
        let vmInput = MovieViewModel.Input.init(endOfCollectionTrigger: mockReachBottomGridTrigger.asDriverOnErrorJustComplete(), itemDidSelect: mockClickTrigger.asDriverOnErrorJustComplete())
        let vmOutput = vm.loadData(input: vmInput)
        
        vmOutput.movieCellViewModel.drive(observerMovieCell).disposed(by: self.disposeBag)
        testScheduler.start()
        
        let expectedEvents = [
            next(50, [Movie]),
            next(100, [Movie]),
            next(200, [Movie])
        ]
        
        XCTAssertEqual(observerMovieCell.events, expectedEvents)
        
    }
}
