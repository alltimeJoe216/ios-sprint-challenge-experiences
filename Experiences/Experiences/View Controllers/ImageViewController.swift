//
//  ImageViewController.swift
//  Experiences
//
//  Created by Joe Veverka on 7/10/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - Properties
    
    var media: Media?
    var delegate: ExperienceViewControllerDelegate?
    var imagePicker: UIImagePickerController!
    
    var imageTaken: UIImage?
    let context = CIContext(options: nil)
    var filteredImage: UIImage?
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterSegmented: UISegmentedControl!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateViews()
        
        if media == nil {
            
            takePhoto()
            
        } else {
            
            if let media = media,
                
                let mediaData = media.mediaData {
                
                imageTaken = UIImage(data:mediaData)
                
            }
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func takePhotoTapped(_ sender: Any) {
        takePhoto()
    }
    
    @IBAction func filterChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0: ///None
            filteredImage = nil
            
        case 1: ///Sepia
            
            guard let image = imageTaken,
                
                let filteredImage = sepiaEffectFilter(image) else { return }
            
            self.filteredImage = filteredImage
            
        case 2: ///Black and White
            
            guard let image = imageTaken,
                
                let filteredImage = bwEffectFilter(image) else { return }
            
            self.filteredImage = filteredImage
            
        default:
            
            break
            
        }
        
        updateViews()
        
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        guard let delegate = delegate else {
            
            print("No Delegate!")
            return
        }
        
        /// Here's our image, let's save it.
        var imageToSave: UIImage
        if let image = filteredImage {
            
            imageToSave = image
            
        } else if let image = imageTaken {
            
            imageToSave = image
            
        } else {
            
            navigationController?.popViewController(animated: true)
            return
            
        }
        
        if let media = self.media {
            
            media.updatedDate = Date()
            media.mediaData = imageToSave.jpegData(compressionQuality: 90)
            
        } else {
            
            let newMedia = Media(mediaType: .image, url: nil, data: imageToSave.jpegData(compressionQuality: 90), date: Date())
            delegate.mediaAdded(media: newMedia)
            
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Private Methods
    
    private func takePhoto() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera)
            
            else {
                
                selectImageFrom(.photoLibrary)
                return
        }
        
        selectImageFrom(.camera)
        
    }
    
    private func updateViews() {
        
        if let media = media {
            
            if let mediaData = media.mediaData {
                
                guard let image = UIImage(data: mediaData) else { return }
                
                imageView.image = image
                
            } else {
                fatalError("Error updating media views")
                
            }
            
        }
        
        if let image = filteredImage {
            
            imageView.image = image
            
        }
            
        else if let image = imageTaken {
            
            imageView.image = image
            
        }
    }
    
    private func showAlertWith(title: String, message: String) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    private func selectImageFrom(_ source: ImageSource) {
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        
        /// Take a pic or choose from photo library
        
        switch source {
            
        case .camera:
            
            imagePicker.sourceType = .camera
            
        case .photoLibrary:
            
            imagePicker.sourceType = .photoLibrary
            
        }
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    /// Sepia Filter
    private func sepiaEffectFilter(_ image: UIImage) -> UIImage? {
        
        guard   let filter = CIFilter(name: "CISepiaTone"),
            
            let originalImage = CIImage(image: image) else { return nil }
        
        filter.setValue(originalImage, forKey: kCIInputImageKey)
        
        guard   let outputImage = filter.outputImage,
            
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage).flattened
        
    }
    
    /// Black and White Filter
    private func bwEffectFilter(_ image: UIImage) -> UIImage? {
        
        guard   let filter = CIFilter(name: "CIPhotoEffectMono"),
            
            let originalImage = CIImage(image: image) else { return nil }
        
        
        filter.setValue(originalImage, forKey: kCIInputImageKey)
        
        guard   let outputImage = filter.outputImage,
            
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage).flattened
        
    }
}

//MARK: - Extensions
extension ImageViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            
            print("Image Was Not Found")
            return
        }
        
        imageTaken = selectedImage.flattened
        updateViews()
        
    }
}

extension UIImage {
    
    var flattened: UIImage {
        
        if imageOrientation == .up { return self }
        
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { context in
            
            draw(at: .zero)
        }
    }
}
