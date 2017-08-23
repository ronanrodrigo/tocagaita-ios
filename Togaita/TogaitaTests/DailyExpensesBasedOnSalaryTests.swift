import XCTest

struct DailyExpensesBasedOnSalary {

    let gateway: SalaryGateway

    init(gateway: SalaryGateway) {
        self.gateway = gateway
    }

    func calculate(monthNumber: Int) -> Float {
        let isValidMonth = monthNumber > 0 && monthNumber < 12
        if isValidMonth {
            let salaries = gateway.salaries()
            if salaries.contains(where: { $0.monthNumber == monthNumber }) {
                return salaries[0].amount / 31
            }
        }
        return 0
    }
}

class SalaryGatewayMock: SalaryGateway {

    func salaries() -> [Salary] {
        return [Salary(amount: 1000, monthNumber: 1), Salary(amount: 1000, monthNumber: 6)]
    }
}

protocol SalaryGateway {
    func salaries() -> [Salary]
}

struct Salary {
    let amount: Float
    let monthNumber: Int
}

final class DailyExpensesBasedOnSalaryTests: XCTestCase {

    var sut: DailyExpensesBasedOnSalary!
    var gateway: SalaryGatewayMock!

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
        XCTAssertEqual(dailyExpenses, 33.3333333333)
    }

}

