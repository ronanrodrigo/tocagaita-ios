import Foundation

protocol DailyExpensesGateway {
  func save(expense: Expense?) -> Result<Expense>
}
