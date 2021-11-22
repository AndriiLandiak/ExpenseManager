import SwiftUI


struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var choiceFilter: Int // to show week picker, year picker or smth like that
    @State var monthIndex: Int = 4
    @State var yearIndexForMonthYear: Int = 0
    @State var yearIndexForYear: Int = 0
    
//    @Binding var changeFilter: Bool
    @Binding var valueFromParent: Int
    @Binding var analForYear: Int // only year
    @Binding var analForYMYear: Int // year + month
    @Binding var analForYMMonth: Int // year + month
    
    let monthSymbols = Calendar.current.monthSymbols
    let years = Array(Date().year-20..<Date().year+1)
    
    var body: some View {
            VStack {
                Picker("C", selection: $choiceFilter, content: {
                    Text("Month").tag(0)
                    Text("Year").tag(1)
                    Text("All").tag(2)
                }).pickerStyle(SegmentedPickerStyle())
                .frame(width: UIScreen.screenWidth - 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)                    .stroke(Color.clear,lineWidth: 2)
                )
                if choiceFilter == 0 {
                    VStack  {
                        GeometryReader{ geometry in
                            HStack(spacing: 0) {
                                Picker(selection: $monthIndex, label: Text("")) {
                                    ForEach(0..<monthSymbols.count) { index in
                                        Text(monthSymbols[index])
                                    }
                                }.frame(maxWidth: geometry.size.width / 2).clipped()
                                Picker(selection: $yearIndexForMonthYear, label: Text("")) {
                                    ForEach(0..<years.count) { index in
                                        Text(String(years[(years.count-1)-index]))
                                    }
                                }.frame(maxWidth: geometry.size.width / 2).clipped()
                            }
                        }
                        Spacer()
                        Text("Choose month and year")
                        Text("Press \(Text(Image(systemName: "square.and.arrow.down"))) to watch analytics")
                    }
                }else if choiceFilter == 1{
                    VStack {
                        Picker(selection: $yearIndexForYear, label: Text("")) {
                            ForEach(0..<years.count) { index in
                                Text(String(years[(years.count-1)-index]))
                            }
                        }
                        Spacer()
                        Text("Choose year and press \(                        Text(Image(systemName: "square.and.arrow.down"))) to watch analytics")
                    }
                }else {
                    VStack {
                        Image("lolimage")
                        Spacer()
                        Text("Nothing to choose :( \(                        Text(Image(systemName: "square.and.arrow.down"))) to watch analytics")
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.top, 100)
                }
            }.padding(.top,10)
            .accentColor(.black)
            .onAppear {
                choiceFilter = valueFromParent
                yearIndexForYear = (2021 - analForYear)
                monthIndex = analForYMMonth
                yearIndexForMonthYear = (2021 - analForYMYear)
            }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text("Filter"), displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: {
                        valueFromParent = choiceFilter
                        analForYear = (2021 - yearIndexForYear)
                        analForYMMonth = monthIndex
                        analForYMYear = (2021 - yearIndexForMonthYear)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "square.and.arrow.down")
                    }
                }
            }
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply")
                }
            }
        }
    }
}

