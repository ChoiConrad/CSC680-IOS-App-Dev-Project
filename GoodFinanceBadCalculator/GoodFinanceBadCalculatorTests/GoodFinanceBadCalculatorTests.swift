import XCTest
import CoreMotion
@testable import GoodFinanceBadCalculator

class GoodFinanceBadCalculatorTests: XCTestCase {
    var viewModel: BadCalcViewModel!
    var mockMotionManager: MockCoreMotionManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockMotionManager = MockCoreMotionManager()
        viewModel = BadCalcViewModel(motionManager: mockMotionManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockMotionManager = nil
        try super.tearDownWithError()
    }

    func testGyroscopeResponse() {
        // Simulate rotation data
        mockMotionManager.simulateGyroData(rotationRate: CMRotationRate(x: 0, y: 1.0, z: 0))
        
        // Allow time for the asynchronous update
        let expectation = XCTestExpectation(description: "Wait for loan amount update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        // Assert the loan amount increased
        XCTAssertEqual(viewModel.loanAmount, 100, "Loan amount should increase by 100 when device is rotated to the right")
    }

    func testLoanCalculation() {
        viewModel.loanAmount = 10000
        viewModel.interestRate = 5.0
        viewModel.loanTerm = 12
        viewModel.downPayment = 0

        viewModel.calculateMonthlyPayment()

        let principal = viewModel.loanAmount - viewModel.downPayment
        let annualInterestRate = viewModel.interestRate / 100
        let monthlyInterestRate = annualInterestRate / 12
        let numberOfPayments = Double(viewModel.loanTerm)
        let expectedMonthlyPayment: Double

        if monthlyInterestRate != 0 {
            let part1 = pow((1 + monthlyInterestRate), numberOfPayments)
            expectedMonthlyPayment = principal * ((monthlyInterestRate * part1) / (part1 - 1))
        } else {
            expectedMonthlyPayment = principal / numberOfPayments
        }

        XCTAssertEqual(viewModel.monthlyPayment, String(format: "Monthly Payment: $%.2f", expectedMonthlyPayment), "Calculated monthly payment is incorrect.")
    }

    func testPerformanceLoanCalculation() {
        measure {
            viewModel.loanAmount = 20000
            viewModel.interestRate = 7.5
            viewModel.loanTerm = 24
            viewModel.calculateMonthlyPayment()
        }
    }
}
