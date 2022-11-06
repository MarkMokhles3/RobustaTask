//
//  RepositoriesViewModelTests.swift
//  RobustaTaskTests
//
//  Created by Mark Mokhles on 06/11/2022.
//

import XCTest
@testable import RobustaTask

final class RepositoriesViewModelTests: XCTestCase {

    private var sut: RepositoriesViewModel!
    private var dataSource: RepositoriesAPIServiceMock!
    private var router: RouterMock!

    override func setUp() {
        super.setUp()
        dataSource = RepositoriesAPIServiceMock()
        router = RouterMock()
        sut = RepositoriesViewModel(dataSource: dataSource,
                                    router: router)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testRepositoriesViewModel_whenCalledSelectedIndex_RouteToDetailsWithThisIndex() {
        // given
        let selectedIndex = 1
        // when
        sut.onSelect(index: selectedIndex)
        // then
        XCTAssertTrue(router.calledRouteToDetails)
    }
}

class RouterMock: RepositoriesRouterProtocol {
    var calledRouteToDetails = false
    func routeToDetails(repository: RobustaTask.Repository) {
        calledRouteToDetails = true
    }
}
