//
//  HomeViewModelTest.swift
//  MVVMTests
//
//  Created by Kelvin Tan on 10/06/2021.
//

import XCTest

@testable import MVVM
class HomeViewModelTest: XCTestCase {

    var viewModel: HomeViewModel!

    func setupViewModel(bucketLists: [BucketList]) {
        viewModel = HomeViewModel(bucketLists: bucketLists)
    }

    func testAppendTwoBucketList() {
        let bucketLists = [BucketList(name: "Jump off the cliff", date: Date()),
                           BucketList(name: "Swim with the shark", date: Date())]
        setupViewModel(bucketLists: bucketLists)

        XCTAssertTrue(viewModel.bucketLists.value.first?.name == "Jump off the cliff")
        XCTAssertTrue(viewModel.bucketLists.value.count == 2)
    }

    func testAppendZeroBucketList() {
        setupViewModel(bucketLists: [])

        XCTAssertTrue(viewModel.bucketLists.value.count == 0)
    }
}
