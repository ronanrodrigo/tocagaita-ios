//
//  MissingReachCurrentDayLimit.swift
//  Togaita
//
//  Created by Vinicius Carvalho Marques on 27/08/17.
//  Copyright © 2017 Ronan R. Nunes. All rights reserved.
//

import XCTest
@testable import Togaita

protocol CostGateway {
    func cost() -> [Salary]
}

struct Cost {
    let amountDay: Float
    let amount: Int
}

struct MissingReachCurrentDayLimit {
    
    private let gateway: CostGateway
    
    init(gateway: CostGateway) {
        self.gateway = gateway
    }
    
    
    func calculateReportMissingToReach() -> Int {
        let costForLimit = gateway.cost()
        
        let reachedLimit = Salary.amount - costForLimit
        
        return reachedLimit
    }
    
}


final class MissingReachCurrentDayLimitTests: XCTestCase {
    
    private var sut: MissingReachCurrentDayLimit!
    private var gateway: CostGatewayMock!
    
    override func setUp() {
        gateway = CostGatewayMock()
        sut = MissingReachCurrentDayLimit(gateway: gateway)
        super.setUp()
    }
    
    func testCalculateWhenReachedLimitThenCalculatePerDayBasedOnSalary() {
        let limitPerDay = sut.calculateReportMissingToReach
        
        //let dailyExpenses = sut.calculate(monthNumber: -1)
        XCTAssertEqual()
    }
    
}

