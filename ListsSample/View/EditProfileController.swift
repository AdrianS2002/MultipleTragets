

import UIKit
import PhotosUI

class EditProfileController: UIViewController {
    
    @IBOutlet weak private var profilePictureImageView: UIImageView!
    
    private var phPickerController: PHPickerViewController!
    private var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePHPicker()
        configureImagePickerController()
    }
    
    private func configureImagePickerController() {
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .camera
        self.imagePickerController.allowsEditing = true
    }
    
    private func configurePHPicker() {
        var phPickerConfiguration = PHPickerConfiguration()
        phPickerConfiguration.selectionLimit = 1
        self.phPickerController = PHPickerViewController(configuration: phPickerConfiguration)
        phPickerController.delegate = self
    }
    
    private func openGallery() {
        present(phPickerController, animated: true)
    }
    
    private func openCamera() {
        present(imagePickerController, animated: true)
    }
    
    @IBAction private func onEditPicturePressed(_ sender: Any) {
        
        let alertController = UIAlertController(
            title: "Choose",
            message: "You can take a picture using camera or select an existing picture from gallery",
            preferredStyle: .actionSheet
        )
        
        let galleryAction = UIAlertAction(
            title: "Open Gallery",
            style: .default) { [weak self] alert in
                guard let self else {return}
                self.openGallery()
            }
        
        let cameraAction = UIAlertAction(
            title: "Open Camera",
            style: .default) { [weak self] alert in
                guard let self else {return}
                self.openCamera()
            }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        
        alertController.addAction(galleryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

extension EditProfileController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let result = results.first {
            let provider = result.itemProvider
            if provider.canLoadObject(ofClass: UIImage.self) {
                let image = provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                    guard let self else {return}
                    if let uiImage = image as? UIImage {
                        DispatchQueue.main.async {
                            self.profilePictureImageView.image = uiImage
                            picker.dismiss(animated: true)
                        }
                    }
                }
            }
            
        }
    }
}

extension EditProfileController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            DispatchQueue.main.async { [weak self] in
                self?.profilePictureImageView.image = image
                picker.dismiss(animated: true)
            }
        }
    }
}
