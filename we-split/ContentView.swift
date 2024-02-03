//
//  ContentView.swift
//  we-split
//
//  Created by Mirzad Varupa on 3. 2. 2024..
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2;
    @State private var tipAmount: Int = 20;
    @FocusState private var isAmountFocused: Bool;

    
    var totalAmount: Double {
        let tipSelection = Double(tipAmount);
        let tipValue = checkAmount / 100 * tipSelection;
        return checkAmount + tipValue;
    }
    
    var totalByPerson: Double {
        let peopleCount = Double(numberOfPeople);
        let tipSelection = Double(tipAmount);
        
        let tipValue = checkAmount / 100 * tipSelection;
        let grandTotal = checkAmount + tipValue;
        
        let amountPerPerson = grandTotal / peopleCount;
        
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationStack{
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused);
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(0..<100){ number in
                            Text("\(number) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip percentage", selection: $tipAmount){
                        ForEach(0..<101){ tip in
                            Text("\(tip) %");
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section("Amount per person"){
                    Text(totalByPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"));
                }
                
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                if isAmountFocused {
                    Button("Done"){
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
