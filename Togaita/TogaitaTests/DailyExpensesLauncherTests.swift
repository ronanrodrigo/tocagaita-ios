import XCTest
@testable import Togaita

class DailyExpensesGatewayMock: DailyExpensesGateway {
  private var expense: Expense!

  func save(expense: Expense?) -> Result<Expense> {
    guard let expense = expense else { return Result.failure(DailyExpensesError.unexpected) }
    guard expense.amount > 0 else { return Result.failure(DailyExpensesError.invalidValue) }
    self.expense = expense
    return Result.success(self.expense)
  }

  func getSaved(expense: Expense) -> Expense? {
    guard expense.id == self.expense.id else { return nil }
    return self.expense
  }
}

final class DailyExpensesLauncherTests: XCTestCase {
  private var sut: DailyExpensesLauncher!
  private var gateway: DailyExpensesGatewayMock!

  override func setUp() {
    gateway = DailyExpensesGatewayMock()
    sut = DailyExpensesLauncher(gateway: gateway)
    super.setUp()
  }

  func testLaunchDailyExpenseWithPositiveIntegerValue() {
    let expense = Expense(amount: 100, description: "China in Box.")
    let result = sut.launch(expense: expense)
    var savedExpense: Expense!
    var error: Error? = nil
    switch result {
    case .success(let expenseValue):
      savedExpense = expenseValue
    case .failure(let errorValue):
      error = errorValue
    }
    XCTAssertEqual(expense.id, savedExpense.id)
    XCTAssertEqual(error == nil, true)
  }

  func testLaunchDailyExpenseWithANegativeValue() {
    let expense = Expense(amount: -100, description: "Ali Express.")
    let result = sut.launch(expense: expense)
    var savedExpense: Expense? = nil
    var error: Error? = nil
    switch result {
    case .success(let expenseValue):
      savedExpense = expenseValue
    case .failure(let errorValue):
      error = errorValue
    }
    XCTAssertEqual(error == nil, false)
    XCTAssertEqual(savedExpense == nil, true)
  }

}
