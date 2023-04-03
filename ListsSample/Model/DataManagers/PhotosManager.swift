
import Foundation

class PhotosManager {
    
    static let shared = PhotosManager()
    private let photosAPI = PhotosAPI()
    private init() {}
    
    func getPhotos(
        completionHandler: @escaping ([Photo]?, Error?) -> Void
    ) {
        photosAPI.getPhotos(completionHandler: completionHandler)
    }
}
