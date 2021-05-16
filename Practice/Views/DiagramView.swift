//
//  DiagramView.swift
//  Practice
//
//  Created by Andrew Landiak on 03.05.2021.
//

import SwiftUI
import Firebase

struct DiagramView: View {
    
    @ObservedObject var transactionVM = TransactionListViewModel()
    
    var allM = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    @State var changeFilter: Bool
    @State var value: Int
    @State var forAllDiagram: Bool = true
    @State var forYearDiagram: Bool = true // because class PieCharView can't 2 times show ...
    @State var forYearDiagramAn: Bool = true // because class PieCharView can't 2 times show ...
    @State var analForYear: Int = 2021 // filter on year in analytics
    @State var analForYMYear: Int = 2021 // filter on year-month
    @State var analForYMMonth: Int = 4 // filter on year-month
    @State var analText: String = ""
    
    let user = Auth.auth().currentUser?.email ?? ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    if value == 2 && transactionVM.takeDictionary().values.count > 0{
                        if forAllDiagram {
                            PieChartView(
                                        values: Array(transactionVM.takeDictionary().values),
                                        names: Array(transactionVM.takeDictionary().keys),
                                        formatter: {value2432 in String(format: "%.2f", value2432)})
                        } else {
                            PieChartView(
                                        values: Array(transactionVM.takeDictionary().values),
                                        names: Array(transactionVM.takeDictionary().keys),
                                        formatter: {value333 in String(format: "%.2f", value333)})
                        }
                    }
                    else if value == 1 && Array(transactionVM.takeByYear(analForYear).values).count > 0{
                        if forYearDiagram {
                            PieChartView(
                                        values: Array(transactionVM.takeByYear(analForYear).values),
                                        names: Array(transactionVM.takeByYear(analForYear).keys),
                                        formatter: {value2 in String(format: "%.2f", value2)})
                        }else {
                            PieChartView(
                                        values: Array(transactionVM.takeByYear(analForYear).values),
                                        names: Array(transactionVM.takeByYear(analForYear).keys),
                                        formatter: {value3 in String(format: "%.2f", value3)})
                        }
                    }
            else if value == 0  &&                  Array(transactionVM.takeByYearAndMonth(analForYMYear, analForYMMonth).values).count > 0 {
                if forYearDiagramAn {
                    PieChartView(
                                values: Array(transactionVM.takeByYearAndMonth(analForYMYear, analForYMMonth).values),
                                names: Array(transactionVM.takeByYearAndMonth(analForYMYear, analForYMMonth).keys),
                                formatter: {value2 in String(format: "%.2f", value2)})
                }else {
                    PieChartView(
                                values: Array(transactionVM.takeByYearAndMonth(analForYMYear, analForYMMonth).values),
                                names: Array(transactionVM.takeByYearAndMonth(analForYMYear, analForYMMonth).keys),
                                formatter: {value3 in String(format: "%.2f", value3)})
                }
            }
            }.onAppear() {
                changeFilter = false
                refreshData()
                value = value
                if value == 1 {
                    analText = String(analForYear)
                    forYearDiagram.toggle()
                } else if value == 0 {
                    analText = String(allM[analForYMMonth]) + ", " + String(analForYMYear)
                    forYearDiagramAn.toggle()
                } else if value == 2 {
                    analText = "Full analytics"
                    forAllDiagram.toggle()
                }
            }
            .navigationBarTitle(Text(analText), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        changeFilter.toggle()
                    }, label: {
                        Image("filter").resizable().frame(width:30, height:30)
                    }).frame(width: 40, height: 40, alignment: .leading)
                    .background(
                        NavigationLink(destination: FilterView(choiceFilter: value, valueFromParent: $value, analForYear: $analForYear, analForYMYear: $analForYMYear, analForYMMonth: $analForYMMonth).navigationTitle(""), isActive: $changeFilter) {
                                EmptyView()
                        }
                    )
                }
              }
        }
    }
    
    func refreshData() {
        self.transactionVM.fetchAllTransaction(userEmail: user)
    }
    func delete(at offsets: IndexSet) {
        for index in offsets {
            self.transactionVM.removeTransaction(at: index)
        }
        refreshData()
    }
}

extension Date {
    var year: Int { Calendar.current.component(.year, from: self) }
}
