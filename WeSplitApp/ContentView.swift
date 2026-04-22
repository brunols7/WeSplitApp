import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var tipAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return tipValue
    }
    
    var totalAmount: Double {
        let grandTotal = checkAmount + tipAmount
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let grandTotal = checkAmount + tipAmount
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check details") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Summary") {
                    HStack{
                        Text("Subtotal:")
                            .bold()
                        
                        Spacer()
                        
                        Text(checkAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
                    }
                    
                    HStack {
                        Text("Tip:")
                            .bold()
                        
                        Spacer()
                        
                        Text(tipAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
                    }
                    
                    HStack {
                        Text("Total amount:")
                            .bold()
                        
                        Spacer()
                        
                        Text(totalAmount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))
                    }
                    
                    HStack {
                        Text("Per person:")
                            .bold()
                            .font(.title3)
                        
                        Spacer()
                        
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .bold()
                            .font(.title3)
                    }
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
