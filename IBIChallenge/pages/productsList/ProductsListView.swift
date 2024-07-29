
import SwiftUI

struct ProductsListView: View {
    @Binding var appVM: AppViewModel
    @State var vm = ProductsListViewModel()
    
    var body: some View {
        NavigationStack(root: {
            VStack{
                if vm.products.count > 0 {
                    List(vm.products) { product in
                        NavigationLink {
                            ProductDetailView(product: product)
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
                            print("in onAppear")
                            guard appVM.hasLoggedIn else {
                                vm.products = []
                                return
                            }
                            print("reach here")
                            if vm.products.isEmpty {
                                print("products is empty")
                                vm.fetchProducts()
                            }
                        }
                }
            }
            .navigationTitle("Products")
            
        })
       
        
    }
}

#Preview {
    ProductsListView(appVM: .constant(AppViewModel()))
}
