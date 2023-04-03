
import Foundation
import UIKit

class PhotosTableController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = PhotosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        viewModel.getPhotos()
    }
}

extension PhotosTableController: PhotosViewModelDelegate {
    
    func photosAreLoading() {
        
    }
    
    func photosAreLoaded() {
        tableView.reloadData()
    }
    
    func photosHasError(error: Error) {
        
    }
}

extension PhotosTableController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let photos = viewModel.photos {
            // calculam numarul de album id-uri distince
            let orderedPhotsById = photos.map {$0.albumId}
            let distinctIds = Set(orderedPhotsById)
            return distinctIds.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photos = viewModel.photos {
            // calculacum numarul de poze fin fiecare album
            let albumIds = photos.map {$0.albumId}
            let uniqueAlbumIds = Array(Set(albumIds)).sorted(by: <)
            let photosForCurrentAlbum = photos.filter { $0.albumId == uniqueAlbumIds[section] }
            return photosForCurrentAlbum.count
        } else {
            return 0
        }
        
        // return viewModel.photos?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        
        let albumIds = viewModel.photos!.map {$0.albumId}
        let uniqueAlbumIds = Array(Set(albumIds)).sorted(by: <)
        let currentAlbumId = uniqueAlbumIds[indexPath.section]
        let currentAlbumPhotos = viewModel.photos!.filter { $0.albumId == currentAlbumId }
        let currentPhoto = currentAlbumPhotos[indexPath.row]
        
        cell.configure(photo: currentPhoto)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Am apasat pe celula din sectiunea #\(indexPath.section), randul #\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Celula din sectiunea #\(indexPath.section), randul #\(indexPath.row) a aparut pe ecran")
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let albumIds = viewModel.photos!.map {$0.albumId}
        let uniqueAlbumIds = Array(Set(albumIds)).sorted(by: <)
        return "Album id = \(uniqueAlbumIds[section])"
    }
    
    /*
     HOMEWORK:
     PENTRU HEADER-UL DIN SECTIUNE NOI NE FOLOSIM DE METODA DIN DELEGAT CARE RETRURNEAZA UN STRING.
     CUM AS PUTEA CA PENTRU HEADERUL DIN DELEGAT SA AFISEZ UN LABEL CU BACKGROUND ALBSTRU SI FONT ALB ???
     */
    
}
