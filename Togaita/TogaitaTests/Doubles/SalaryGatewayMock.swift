@testable import Togaita

class SalaryGatewayMock: SalaryGateway {

    func salaries() -> [Salary] {
        return [Salary(amount: 1000, monthNumber: 1),
                Salary(amount: 2000, monthNumber: 6)]
    }
}
