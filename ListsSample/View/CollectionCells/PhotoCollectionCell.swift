
import UIKit
import Kingfisher

class PhotoCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoIdLabel: UILabel!
    @IBOutlet private weak var photoThumnailImageView: UIImageView!
    
    override func prepareForReuse() {
        photoIdLabel.text = nil
        photoThumnailImageView.image = nil
    }
    
    func configure(photo: Photo) {
        photoIdLabel.text = String(photo.id)
        photoThumnailImageView.kf.setImage(with: photo.thumbnailUrl)
    }
    
}
