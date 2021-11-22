import SwiftUI
import Firebase

struct Edit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    private let expViewModel = AddExpensesViewModel()
    private let incViewModel = AddIncomeViewModel()
    let user = Auth.auth().currentUser?.email ?? ""
    var idx: Int
    var check: Int = 0
    
    @State var addNewCategory: Bool
    @State var checkExpense: Bool = true
    @State private var commentary: String = ""
    @State private var sum: String = ""
    @State private var date = Date()
    @State private var creditCard = false
    @State var choiceFilter: Int = 0// to show week picker, year picker or smth like that
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        VStack {
            ZStack {
                Form {
                    if transactionVM.transactions.count != idx  {
                        if transactionVM.transactions[idx].sum < 0 {
                            Text("Expense").frame(minWidth:0, maxWidth: .infinity)
                        }else if transactionVM.transactions.count != 0 {
                            Text("Income").frame(minWidth:0, maxWidth: .infinity)
                        }
                        Picker("", selection: $choiceFilter, content: {
                            Text("Cash").tag(0)
                            Text("Credit card").tag(1)
                        }).pickerStyle(SegmentedPickerStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)                    .stroke(Color.clear,lineWidth: 2)
                        )
                        HStack {
                            Image(systemName: "bag")
                            if transactionVM.transactions[idx].sum < 0 {
                                TextField(String(transactionVM.transactions[idx].sum), text: $sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                            }else{
                                TextField(String(transactionVM.transactions[idx].sum), text: $sum).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                            }
                        }
                        
                        HStack {
                            Image(systemName: "calendar")
                            DatePicker("", selection: $date, displayedComponents: .date).position(x: -15, y: 17).accentColor(Color("AuthorizationColor"))
                        }
                        HStack {
                            Image(systemName: "text.bubble")
                            TextField(String(transactionVM.transactions[idx].commentary), text: $commentary)
                        }
                    }
                }
                if self.alert{
                    ErrorView(alert: self.$alert, error: self.$error)
                }
            }
        }
        .onAppear() {
            if transactionVM.transactions[idx].card {
                choiceFilter = 1
            } else {
                choiceFilter = 0
            }
            if transactionVM.transactions[idx].sum < 0 {
                sum = String(-transactionVM.transactions[idx].sum)
                checkExpense = true
            }else {
                sum = String(transactionVM.transactions[idx].sum)
                checkExpense = false
            }
            commentary = transactionVM.transactions[idx].commentary
            date = transactionVM.transactions[idx].date
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            self.transactionVM.removeTransaction(at: idx)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "trash")
                        }
                        Button("Save") {
                            if (Double(sum) ?? 0) == 0 {
                                self.error = "Enter correct sum"
                                self.alert.toggle()
                            } else {
                                if commentary != transactionVM.transactions[idx].commentary || Double(sum) != transactionVM.transactions[idx].sum ||
                                    date != transactionVM.transactions[idx].date {
                                    if choiceFilter == 0 {
                                        creditCard = false
                                    } else if choiceFilter == 1{
                                        creditCard = true
                                    }
                                    let transNew = TransactionViewModel(id: transactionVM.transactions[idx].id, sum: Double(sum) ?? 0, date: date, category: transactionVM.transactions[idx].category, commentary: commentary, userEmail: user, card: creditCard)
                                    if checkExpense {
                                        expViewModel.updateTransaction(transaction: transNew)
                                    } else {
                                        incViewModel.updateTransaction(transaction: transNew)
                                    }
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                }
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                    }
                }.accentColor(Color("AuthorizationColor"))
            }
        }.accentColor(Color("AuthorizationColor"))
    }
}
