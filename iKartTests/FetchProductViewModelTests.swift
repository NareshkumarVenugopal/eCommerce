//
//  FetchProductViewModelTests.swift
//  iKartTests
//
//  Created by Jasmin Infotech Private Limited on 29/11/24.
//

import XCTest
@testable import iKart

final class FetchProductViewModelTests: XCTestCase {
    
    private var systemUndertest: ProductViewModel!
    
    override func setUp() {
        super.setUp()
        systemUndertest = ProductViewModel()
    }
    
    override func tearDown() {
        systemUndertest = nil
        super.tearDown()
    }
    
    
}
