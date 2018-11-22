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
    public var service = SMEngineService.instance
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
        
        var vm = MovieViewModel()
        vm.service = self.service
        vm.disposeBag = disposeBag
        let testScheduler = TestScheduler(initialClock: 0)
        
        let mockPullRefereshTriggerEvents: [Recorded<Event<Void>>] = [
            Recorded.next(300, ())
        ]
        
        let mockReachBottomTriggerEvents: [Recorded<Event<Void>>] = [
            Recorded.next(50, ()),
            Recorded.next(100, ()),
            Recorded.next(200, ())
        ]
        
        let indexPath = IndexPath(item: 0, section: 0)
        let mockClickTriggerEvents: [Recorded<Event<IndexPath>>] = []
        
        let mockRefreshTrigger = testScheduler.createHotObservable(mockPullRefereshTriggerEvents)
        let mockReachBottomGridTrigger = testScheduler.createHotObservable(mockReachBottomTriggerEvents)
        let mockClickTrigger = testScheduler.createHotObservable(mockClickTriggerEvents)
        let observerMovieCell = testScheduler.createObserver([Movie].self)
        
        let vmInput = MovieViewModel.Input.init(pullOfCollectionTrigger: mockRefreshTrigger.asDriver(onErrorJustReturn: ()), endOfCollectionTrigger: mockReachBottomGridTrigger.asDriver(onErrorJustReturn: ()), itemDidSelect: mockClickTrigger.asDriver(onErrorJustReturn: indexPath))
        let vmOutput = vm.loadData(input: vmInput)
        
        vmOutput.movieCellViewModel.drive(observerMovieCell).disposed(by: self.disposeBag)
        testScheduler.start()
        
        print("\(observerMovieCell.events.last?.value.element?.count)")
        XCTAssertEqual(observerMovieCell.events.last?.value.element?.count, 10)
        
    }
}
