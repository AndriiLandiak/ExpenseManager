import SwiftUI

struct CustonTextField: View {
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name").font(.body).foregroundColor(.gray)
            HStack {
                TextField("Category name", text: $text)
            }.modifier(CustomViewModifier(roundedCornes: 6, backgroundColor: .white, textColor: .black))
        }.padding()
    }
}


struct CustomViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var backgroundColor: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                        .stroke(Color.blue ,lineWidth: 1))
            .font(.custom("Open Sans", size: 18))
            .shadow(radius: 10)
    }
}
