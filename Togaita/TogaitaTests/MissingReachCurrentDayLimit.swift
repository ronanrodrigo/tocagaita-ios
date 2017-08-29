import XCTest
@testable import Togaita

enum TocagaitaError: Error {
    case costInvalid
}

class MissingReachCurrentDayLimit {
    func calculate(dailyExpense: Float, currentCost: Float) throws -> Float {
        if currentCost < 0 {
            throw TocagaitaError.costInvalid
        }
        return dailyExpense - currentCost
    }
}


final class MissingReachCurrentDayLimitTests: XCTestCase {
    
    private var sut: MissingReachCurrentDayLimit!
    
    override func setUp() {
        sut = MissingReachCurrentDayLimit()
        super.setUp()
    }
    
    func testCalculateWhenCostsThenReturnDailyRemainingLimit() {
        let limitPerDay = try! sut.calculate(dailyExpense: 100.0, currentCost: 50.0)

        XCTAssertEqual(limitPerDay, 50.0)
    }

    func testCalculateWhenNegativeCostsThenReturnAnError() {
        XCTAssertThrowsError(try sut.calculate(dailyExpense: 100.0, currentCost: -50.0))
    }
    
}

