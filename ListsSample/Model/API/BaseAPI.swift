
import Foundation

enum APIEnvironment: String {
    case prod = "https://jsonplaceholder.typicode.com/"
    case dev = "https://jsonplaceholder.typicode.com"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class BaseAPI {
    
    let basePath: String
    
    init() {
        #if DEV
        basePath = APIEnvironment.dev.rawValue
        #elseif PROD
        basePath = APIEnvironment.prod.rawValue
        #endif
    }
    
    let decoder = JSONDecoder()
    
    func createURL(
        path: String,
        query: [String: String]? = nil
    ) -> URL {
        var urlComponents = URLComponents(string: basePath) // https://emag.ro
        let currentPath = (urlComponents?.path ?? "").trimmingCharacters(in: CharacterSet(["/"]))
        let formattedPath = "/" + path.trimmingCharacters(in: CharacterSet(["/"]))
        let newPath = "/" + (currentPath + formattedPath).trimmingCharacters(in: CharacterSet(["/"]))
        urlComponents?.path = newPath
        if let query {
            urlComponents?.queryItems = query.map({ key, value in
                URLQueryItem(name: key, value: value)
            })
        }
        return (urlComponents?.url)!
    }
    
    func createURLRequest(
        url: URL,
        httpMethod: HTTPMethod,
        headers: [String: String]?,
        body: Data?
    ) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        return urlRequest
    }
}
