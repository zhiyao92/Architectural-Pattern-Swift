//
//  HomePresenterTest.swift
//  MVPTests
//
//  Created by Kelvin Tan on 21/06/2021.
//

import XCTest
import MVP

class HomeViewMock: HomePresenterViewProtocol {

    var bucketLists: [BucketList] = []
    var isReload = false

    func reloadView(_ bucketLists: [BucketList]) {
        self.bucketLists = bucketLists
        self.isReload = true
    }
}

@testable import MVP
class HomePresenterTest: XCTestCase {

    var presenter: HomePresenter!
    var viewMock: HomeViewMock!

    func setupPresenter() {
        viewMock = HomeViewMock()
        presenter = HomePresenter(with: viewMock)
    }

    func testAddBucketList() {
        setupPresenter()

        presenter.addBucketList("Jump off the plane")

        XCTAssertTrue(viewMock.bucketLists.count == 1)
        XCTAssertTrue(viewMock.bucketLists.first?.name == "Jump off the plane")
        XCTAssertTrue(viewMock.isReload)
    }

    func testAddMultipleBucketList() {
        setupPresenter()

        presenter.addBucketList("Jump off the plane")
        presenter.addBucketList("Travel the world")
        presenter.addBucketList("Fly on a plane")

        XCTAssertTrue(viewMock.bucketLists.count == 3)
        XCTAssertTrue(viewMock.isReload)
    }

}
