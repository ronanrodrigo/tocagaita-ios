import XCTest
@testable import Togaita

final class DailyExpensesBasedOnSalaryTests: XCTestCase {

    private var sut: DailyExpensesBasedOnSalary!
    private var gateway: SalaryGatewayMock!

    override func setUp() {
        gateway = SalaryGatewayMock()
        sut  = DailyExpensesBasedOnSalary(gateway: gateway)
        super.setUp()
    }

    func testCalculateWhenMonthIsInvalidThenDoensNottCalculate() {
        let dailyExpenses = sut.calculate(monthNumber: -1)
        XCTAssertEqual(dailyExpenses, 0)
    }

    func testCalculateWhenMonthIsValidButDoesNotExistThenDoensNottCalculate() {
        let dailyExpenses = sut.calculate(monthNumber: 3)
        XCTAssertEqual(dailyExpenses, 0)
    }

    func testCalculateWhenMohthHave31DaysExistThenCalculateDailyExpenses() {
        let dailyExpenses = sut.calculate(monthNumber: 1)
        XCTAssertEqual(dailyExpenses, 32.2580645161)
    }

    func testCalculateWhenMohthHave30DayThenCalculateDailyExpenses() {
        let dailyExpenses = sut.calculate(monthNumber: 6)
        XCTAssertEqual(dailyExpenses, 66.6666666667)
    }

}

