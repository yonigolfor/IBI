//
//  NewProductFormView.swift
//  IBIChallenge
//
//  Created by Yoni Golfor on 30/07/2024.
//

import SwiftUI

struct NewProductFormView: View {
    let onFinish: (Product) -> Void
    let product: Product?
    @State var vm: NewProductsFormViewModel

    init(onFinish: @escaping (Product) -> Void, product: Product? = nil) {
            self.onFinish = onFinish
            self.product = product
            self._vm = State(initialValue: NewProductsFormViewModel(p: product))
        }
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 12).frame(width: 80,height: 6)
                .padding(.top, 6)
            Text("New Product")
                .font(.title)
                .bold()
            Spacer()
            
            Form {
                Section(header: Text("Product Information")) {
                    TextField("Title", text: $vm.title)
                    TextField("Description", text: $vm.description)
                    TextField("Price", text: $vm.price)
                        .keyboardType(.decimalPad)
                    TextField("Brand", text: $vm.brand)
                    TextField("Image URL", text: $vm.imageURL)
                }
                
                Button(action: {
                    // Handle form submission
                    let newProd = Product(id: vm.id, title: vm.title, description: vm.description, price: Double(vm.price) ?? 10, brand: vm.brand, thumbnail: vm.imageURL, images: nil)
                    onFinish(newProd)
                    vm.resetForm()

                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.cyan.gradient)
        }
    }
}


#Preview {
    NewProductFormView(onFinish: {_ in }, product: nil)
}
