//
//  BaseUITests.swift
//  SocialMegUITests
//
//  Created by Raul Menezes on 08/11/2022.
//

import XCTest

class BaseUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        app.launch()
    }
}
