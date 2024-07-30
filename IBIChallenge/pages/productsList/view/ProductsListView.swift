
import SwiftUI

struct ProductsListView: View {
    @Binding var appVM: AppViewModel
    @State var vm = ProductsListViewModel()
    
    
    private func onToggleFavorite(shouldAdd: Bool, product: Product) {
        let favProduct = FavoriteProduct(id: product.id, title: product.title, price: product.price, thumbnail: product.thumbnail)
        
        appVM.toggleRealmFavorite(shouldAdd: shouldAdd, product: favProduct)
    }
    
    var body: some View {
        NavigationStack(root: {
            VStack{
                if vm.products.count > 0 {
                    List(vm.products) { product in
                        NavigationLink {
                            ProductDetailView(product: product, onToggleFavorite: {
                                shouldAdd in onToggleFavorite(shouldAdd: shouldAdd, product: product)
                            }, onUpdateProduct: { updatedProduct in
                                vm.onUpdateProduct(p: updatedProduct)
                            })
                        } label: {
                            ProductRowView(product: product)
                                .onAppear{
                                    if product == vm.products.last{
                                        vm.fetchProducts()
                                    }
                                }
                        }
                    }
                    if vm.isLoading{
                        ProgressView()
                            .scaleEffect(CGSize(width: 1.5, height: 1.5))
                            .tint(.blue)
                    }
                } else {
                    ProgressView()
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                        .tint(.blue)
                        .onAppear{
                            guard appVM.hasLoggedIn else {
                                vm.products = []
                                return
                            }
                            if vm.products.isEmpty {
                                vm.fetchProducts()
                            }
                        }
                }
            }
            .navigationTitle("Products")
            .toolbar{
                Button(action: {
                    vm.showNewProductSheet = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $vm.showNewProductSheet, content: {
                NewProductFormView(onFinish: vm.onAddNewProduct, product: nil)
            })
            
        })
       
        
    }
}

#Preview {
    ProductsListView(appVM: .constant(AppViewModel()))
}

