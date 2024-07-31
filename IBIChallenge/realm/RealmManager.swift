import RealmSwift
import Foundation

@Observable
final class RealmManager {
    static let shared = RealmManager()
    private var realm: Realm
    
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Error opening Realm: \(error)")
        }
    }

    func updateFavoriteProduct(product: Product) {
        do {
            try realm.write {
                // Fetch all favorite products
                let favoriteProducts = realm.objects(FavoriteProduct.self)
                
                // Find the product that matches the new product's ID
                if let existingProduct = favoriteProducts.where({ $0.id == product.id }).first {
                    // Update the properties of the existing product
                    existingProduct.title = product.title
                    existingProduct.price = product.price
                    existingProduct.thumbnail = product.thumbnail
                    // Update other properties as needed
                } else {
                    print("Product with ID \(product.id) not found.")
                }
            }
        } catch {
            print("Error adding product: \(error)")
        }
    }
    func addFavoriteProduct(_ product: FavoriteProduct) {
        do {
            try realm.write {
                realm.add(product, update: .modified)
            }
        } catch {
            print("Error adding product: \(error)")
        }
    }
    
    func removeFavoriteProduct(_ product: FavoriteProduct) {
        let productToDelete = realm.object(ofType: FavoriteProduct.self, forPrimaryKey: product.id)
        guard let safeProductToDelete = productToDelete else {
            fatalError("Product to delete not found in db")
        }

        do {
            try realm.write {
                realm.delete(safeProductToDelete)
            }
        } catch {
            print("Error adding product: \(error)")
        }
    }

    func getFavoriteProducts() -> Results<FavoriteProduct> {
        return realm.objects(FavoriteProduct.self)
    }
}
