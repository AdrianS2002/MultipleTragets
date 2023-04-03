

import Foundation

class PhotosAPI: BaseAPI {
    
    func getPhotos(
        completionHandler: @escaping ([Photo]?, Error?) -> Void
    ) {
        
        let urlRequest = createURLRequest(
            url: createURL(path: "photos"),
            httpMethod: .get,
            headers: nil,
            body: nil
        )
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self else {return}
            DispatchQueue.main.async {
                if let error {
                    completionHandler(nil, error)
                } else if let data {
                    do {
                        let photos = try self.decoder.decode([Photo].self, from: data)
                        completionHandler(photos, nil)
                    } catch(let myError) {
                        completionHandler(nil, myError)
                    }
                } else {
                    let unknownError = MessageError(text: "Unfortunately, an error has occured.")
                    completionHandler(nil, unknownError)
                }
            }
        }
        
        task.resume()
    }
}

