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

    func addFavoriteProduct(_ product: FavoriteProduct) {
        print("reach 3. product \(product)")

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
