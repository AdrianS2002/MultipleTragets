
import Foundation

class UserDefaultsManager {
    
    enum Keys: String {
        case count = "count"
        case appTheme = "app_theme"
    }
    
    static let instance = UserDefaultsManager()
    
    private init() {}
    
    func delete(key: Keys) {
        save(value: nil, key: key)
    }
    
    func deleteAll() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    func save(value: Any?, key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getInt(key: Keys) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    func getBool(key: Keys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    func getDouble(key: Keys) -> Double {
        return UserDefaults.standard.double(forKey: key.rawValue)
    }
    
    func getDictionary(key: Keys) -> [String: Any]? {
        return UserDefaults.standard.dictionary(forKey: key.rawValue)
    }
    
    func getData(key: Keys) -> Data? {
        return UserDefaults.standard.data(forKey: key.rawValue)
    }
    
    func setEncodableObject<T: Encodable>(object: T, key: Keys) {
        do {
            let encodedObject = try JSONEncoder().encode(object)
            save(value: encodedObject, key: key)
        } catch {
            print(error)
        }
    }
    
    func getDecodableObject<T: Decodable>(key: Keys, type: T.Type) -> T? {
        guard let data = getData(key: key)  else {return nil}
        let decodedObject = try? JSONDecoder().decode(T.self, from: data)
        return decodedObject
    }
    
}
