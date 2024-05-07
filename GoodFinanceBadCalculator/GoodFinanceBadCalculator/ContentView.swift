import SwiftUI

struct ContentView: View {
    @State private var loanAmount = ""
    @State private var interestRate = ""
    @State private var loanTerm = "" // in months
    @State private var monthlyPayment = ""
    @State private var downPayment = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Loan Details")) {
                    TextField("Loan Amount", text: $loanAmount)
                        .keyboardType(.decimalPad)
                    TextField("Interest Rate (Annual %)", text: $interestRate)
                        .keyboardType(.decimalPad)
                    TextField("Down Payment", text: $downPayment)
                        .keyboardType(.numberPad)
                    TextField("Loan Term (Months)", text: $loanTerm)
                        .keyboardType(.numberPad)
                }
                Section {
                    Button("Calculate") {
                    }
                }
                Section(header: Text("Monthly Payment")) {
                    Text(monthlyPayment)
                }
            }
            .navigationTitle("Bad Calculator")
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
