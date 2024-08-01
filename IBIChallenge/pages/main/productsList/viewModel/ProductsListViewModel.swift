
import Foundation

@Observable
class ProductsListViewModel{
    var products: [Product] = [Product]()
    var currentPage: Int = 0
    var isLoading: Bool = false
    var showNewProductSheet: Bool = false
    private var canLoadMorePages: Bool = true
    private var productsPerPage: Int = 5
    
    func onUpdateProduct(p: Product) {
        if let index = products.firstIndex(where: { $0.id == p.id }) {
            self.products[index] = p
        }
    }
    func onAddNewProduct(_ product: Product){
        self.showNewProductSheet = false
        self.products.insert(product, at: 0)
    }
    
    func fetchProducts() {
        guard !isLoading && canLoadMorePages else { return }
        self.isLoading = true
        
        guard let url = URL(string: "https://dummyjson.com/products?limit=\(productsPerPage)&skip=\(currentPage * productsPerPage)") else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, urlResponse, error in
            self.isLoading = false
            if error != nil {
                print(error!)
                self.canLoadMorePages = false
                return
            }
            
            if let safeData = data {
                self.parseJSON(data: safeData)
            }
        }
        
        task.resume()
    }
    
    func parseJSON(data: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ProductsReponse.self, from: data)
            self.products.append(contentsOf: decodedData.products)
            self.canLoadMorePages = decodedData.products.count == self.productsPerPage
            self.currentPage += 1
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
