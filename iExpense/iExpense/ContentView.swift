//
//  ContentView.swift
//  iExpense
//
//  Created by Beknar Danabek on 8/19/20.
//  Copyright © 2020 Beknar Danabek. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let var = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "items") {
            let decoder = JSONDecoder()
            if let items = try? decoder.decode([ExpenseItem].self, from: data) {
                self.items = items
                
                return
            }
        }
       
        self.items = []
    }
}

struct AmountTextStyle: ViewModifier {
    let amount: Int
    
    func body(content: Content) -> some View {
        var foregroundColor = Color.black
        switch amount {
        case 0...10:
            foregroundColor = .red
        case 10...50:
            foregroundColor = .orange
        case 100...:
            foregroundColor = .green
        default:
            foregroundColor = .black
        }
        
        return content.foregroundColor(foregroundColor)
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text("$ \(item.amount)")
                            .modifier(AmountTextStyle(amount: Int(item.amount)))
                    }
                }
                .onDelete(perform: removeItems)
                
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
