 import Foundation

struct DailyExpensesBasedOnSalary {

    private let gateway: SalaryGateway

    init(gateway: SalaryGateway) {
        self.gateway = gateway
    }

    func calculate(monthNumber: Int) -> Float {
        let isInvalidMonth = monthNumber < 0 || monthNumber > 12
        if isInvalidMonth { return 0 }
        let salaries = gateway.salaries()
        guard let salary = salaries.first(where: { $0.monthNumber == monthNumber }) else { return 0 }
        let monthDays = Float(getDays(ofMonthNumber: monthNumber))

        let salariesCalculated = salary.amount / monthDays

        return salariesCalculated
    }

    private func getDays(ofMonthNumber month: Int) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!

        return range.count
    }

}
