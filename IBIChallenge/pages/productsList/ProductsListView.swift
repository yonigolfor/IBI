
import SwiftUI

struct ProductsListView: View {
    @State var vm = ProductsListViewModel()
    
    var body: some View {
        NavigationStack(root: {
            VStack{
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
            }
                .navigationTitle("Products")
                
            
            })
        .onAppear{
            if vm.products.count == 0{
                vm.fetchProducts()
            }
        }
        }
    }

#Preview {
    ProductsListView()
}
