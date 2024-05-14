import Foundation
import CoreMotion

/// ViewModel for finance calculations and adjusting loan amount with the gyroscope.
class BadCalcViewModel: ObservableObject {
    // Published properties to update the UI when their values change.
    @Published var loanAmount: Double = 0.0
    @Published var interestRate: Double = 0.0
    @Published var loanTerm: Int = 0  // Loan term in months
    @Published var downPayment: Double = 0.0
    @Published var monthlyPayment: String = ""

    // Core Motion manager for handling gyroscope updates.
    private let motionManager: CoreMotionManager

    /// Initializes the ViewModel and sets up the gyroscope.
    ///  The CoreMotionManager instance to use. Defaults to the shared instance.
    init(motionManager: CoreMotionManager = CoreMotionManager.shared) {
        self.motionManager = motionManager
        setupGyroscope()
    }

    /// Sets up the gyroscope to monitor device motion and update values.
    private func setupGyroscope() {
        motionManager.gyroUpdate = { [weak self] rotationRate in
            self?.updateValues(rotationRate: rotationRate)
        }
        motionManager.startGyroscope()
    }

    /// Updates the loan amount based on the gyroscope's rotation rate.
    /// The rotation rate data from the gyroscope.
    private func updateValues(rotationRate: CMRotationRate) {
        DispatchQueue.main.async {
            let sensitivity = 0.5  // Threshold for detecting tilt
            if rotationRate.y > sensitivity {
                self.loanAmount += 100  // Increase loan amount
            } else if rotationRate.y < -sensitivity {
                self.loanAmount -= 100  // Decrease loan amount
            }
        }
    }

    /// Calculates the monthly payment based on loan details.
    func calculateMonthlyPayment() {
        let principal = loanAmount - downPayment
        let annualInterestRate = interestRate / 100
        let monthlyInterestRate = annualInterestRate / 12
        let numberOfPayments = Double(loanTerm)

        if monthlyInterestRate != 0 {
            let part1 = pow((1 + monthlyInterestRate), numberOfPayments)
            let monthlyPaymentAmount = principal * ((monthlyInterestRate * part1) / (part1 - 1))
            monthlyPayment = String(format: "Monthly Payment: $%.2f", monthlyPaymentAmount)
        } else {
            let monthlyPaymentAmount = principal / numberOfPayments
            monthlyPayment = String(format: "Monthly Payment: $%.2f", monthlyPaymentAmount)
        }
    }

    /// Clears the monthly payment display.
    func clearPayment() {
        monthlyPayment = ""
    }

    /// Sets the monthly payment display to a test value.
    func setTestPayment() {
        monthlyPayment = "Test"
    }
}
