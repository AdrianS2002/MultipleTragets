
import Foundation

protocol PhotosViewModelDelegate: AnyObject {
    func photosAreLoading()
    func photosAreLoaded()
    func photosHasError(error: Error)
}

class PhotosViewModel {
    
    private let photosManager = PhotosManager.shared
    weak var delegate: PhotosViewModelDelegate?
    private(set) var photos: [Photo]?
    
    func getPhotos() {
        delegate?.photosAreLoading()
        
        photosManager.getPhotos { [weak self] photos, error in
            guard let self else {return}
            if let photos {
                self.photos = photos
                self.delegate?.photosAreLoaded()
            } else if let error {
                self.delegate?.photosHasError(error: error)
            }
        }
    }
    
}
