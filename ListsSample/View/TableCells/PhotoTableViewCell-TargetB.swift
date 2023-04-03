
import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var photoTitleLabel: UILabel!
    @IBOutlet private weak var photoThumbnailImageView: UIImageView!
    
    override func prepareForReuse() {
        photoTitleLabel.text = nil
        photoThumbnailImageView.image = nil
    }
    
    func configure(photo: Photo) {
        photoTitleLabel.backgroundColor = .red
        photoTitleLabel.text = photo.title
        photoThumbnailImageView.kf.setImage(with: photo.thumbnailUrl)
    }

}
