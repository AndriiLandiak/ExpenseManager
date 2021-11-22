import SwiftUI
import Firebase
struct AddNewCategoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var detName: String = ""
    private let viewModel = AddUpdateCategory()
    @State var caterogyImageName = "book"
    let user = Auth.auth().currentUser?.email ?? ""
    
    var body: some View {
        VStack{
            Image(systemName: caterogyImageName)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .padding(.top,50)
            CustonTextField(text: $detName)
            CategoryIconCell(imageName: $caterogyImageName)
            Spacer()
        }
        .padding(.top, 50)
        .navigationTitle("Сost category")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                if detName != ""  {
                    let categoryNew = CategoryViewModel(id: UUID(), name: detName, userEmail: user, imageName: caterogyImageName)
                    viewModel.addCategory(category: categoryNew)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                HStack(spacing: 3) {
                    Text("Save")
                }
            }
        }
    }
}

