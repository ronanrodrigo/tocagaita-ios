import Foundation

struct DailyExpensesLauncher {
  private let gateway: DailyExpensesGateway

  init(gateway: DailyExpensesGateway) {
    self.gateway = gateway
  }

  func launch(expense: Expense?) -> Result<Expense> {
    return gateway.save(expense: expense)
  }

}

