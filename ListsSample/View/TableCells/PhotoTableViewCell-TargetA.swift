

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var photoTitleLabel: UILabel!
    @IBOutlet private weak var photoThumbnailImageView: UIImageView!
    
    override func prepareForReuse() {
        photoTitleLabel.text = nil
        photoThumbnailImageView.image = nil
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            photoTitleLabel.textColor = .blue
        } else {
            photoTitleLabel.textColor = .black
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            photoTitleLabel.textColor = .red
        } else {
            photoTitleLabel.textColor = .black
        }
    }
    
    func configure(photo: Photo) {
        photoTitleLabel.text = photo.title
        photoThumbnailImageView.kf.setImage(with: photo.thumbnailUrl)
    }

}
