import SwiftUI

struct ContentView: View {
    // Observed object to bind ViewModel properties to the view
    @ObservedObject var viewModel = BadCalcViewModel()
    // Focus state to manage focus of text fields
    @FocusState private var focusedField: Field?

    // Enumeration for managing focus state of different text fields
    enum Field {
        case loanAmount, interestRate, downPayment, loanTerm
    }

    var body: some View {
        // Navigation view to provide a navigation bar
        NavigationView {
            // Form to organize input fields and buttons
            Form {
                // Section for loan details input fields
                Section(header: Text("Loan Details")) {
                    // TextField for loan amount input
                    TextField("Loan Amount", value: $viewModel.loanAmount, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .loanAmount)
                        .placeholder(when: viewModel.loanAmount == 0 && focusedField != .loanAmount, placeholder: "Enter loan amount")
                    
                    // TextField for interest rate input
                    TextField("Interest Rate (Annual %)", value: $viewModel.interestRate, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .interestRate)
                        .placeholder(when: viewModel.interestRate == 0 && focusedField != .interestRate, placeholder: "Enter annual interest rate")
                    
                    // TextField for down payment input
                    TextField("Down Payment", value: $viewModel.downPayment, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .downPayment)
                        .placeholder(when: viewModel.downPayment == 0 && focusedField != .downPayment, placeholder: "Enter down payment")
                    
                    // TextField for loan term input
                    TextField("Loan Term (Months)", value: $viewModel.loanTerm, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .loanTerm)
                        .placeholder(when: viewModel.loanTerm == 0 && focusedField != .loanTerm, placeholder: "Enter loan term in months")
                }
                
                // Section for action buttons
                Section {
                    HStack {
                        // Button to calculate the monthly payment
                        Button("Calculate") {
                            viewModel.clearPayment()
                            /*Took idea from https://stackoverflow.com/questions/37801436/how-do-i-write-dispatch-after-gcd-in-swift-3-4-and-5 */

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                viewModel.calculateMonthlyPayment()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        // Button to set a test payment value
                        Button("Suggested") {
                            viewModel.clearPayment()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                viewModel.setTestPayment()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                
                // display the calculated monthly payment
                Section(header: Text("Monthly Payment")) {
                    Text(viewModel.monthlyPayment.isEmpty ? "Enter details and calculate" : viewModel.monthlyPayment)
                }
            }
            .navigationTitle("Finance Calculator")
        }
    }
}

// Extension to add a placeholder
extension View {
    // Adds a placeholder in case true
    func placeholder(when condition: Bool, placeholder text: String) -> some View {
        overlay {
            if condition {
                Text(text)
                    .foregroundColor(.gray)
                    .padding(.leading, 5)
            }
        }
    }
}

// Preview i stole from stack overflow https://stackoverflow.com/questions/71024422/swiftui-contentview-previews-not-running-function
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
