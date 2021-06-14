//
//  PhotoPicker.swift
//  YTeThongMinh
//
//  Created by DatTV on 6/9/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//


import UIKit

open class PhotoPicker: NSObject {
    
    private static var instance = PhotoPicker()
    
    private var pickerController: UIImagePickerController!
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    private var callback: ((_ image: UIImage?) -> Void)? = nil
    
    public override init() {
        super.init()
        setup()
    }
    
    private func setup() {
        pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = ["public.image"]
        pickerController.modalPresentationStyle = .overFullScreen
    }
    
    private func getRootVC() -> UIViewController? {
        return AppDelegate.shared.window?.rootViewController
    }
        
    static func show(_ callback: ((_ image: UIImage?) -> Void)? = nil) {
        instance.callback = callback
        instance.present()
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            guard let vc = self.getRootVC() else { return }
            if type == .camera {
            } else {
                self.pickerController.sourceType = type
                vc.present(self.pickerController, animated: true, completion: {

                })
            }
        }
    }
    
    private func present() {
        let vc = self.getRootVC()
        if alertController.actions.isEmpty {
            if let action = self.action(for: .camera, title: "Mở Camera") {
                alertController.addAction(action)
            }
            
            if let action = self.action(for: .photoLibrary, title: "Mở thư viện") {
                alertController.addAction(action)
            }
            
            alertController.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: nil))
            if vc != nil {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    alertController.popoverPresentationController?.sourceView = vc!.view
                    alertController.popoverPresentationController?.sourceRect =  vc!.view!.bounds
                    alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
                }
            }
        }
        vc?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?, imageType: String? = nil) {
        controller.dismiss(animated: true, completion: nil)
        callback?(image)
        callback = nil
    }

}

extension PhotoPicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        
        if picker.sourceType == .camera {
            self.pickerController(picker, didSelect: image, imageType: Constants.ImageType.jpg.rawValue)
            return
        }
        
        guard let assetPathAbsoluteString = (info[UIImagePickerController.InfoKey.referenceURL] as? NSURL)?.absoluteString?.lowercased() else {
            self.pickerController(picker, didSelect: nil)
            return
        }
        
        var imageExtension: String?
        
        if (assetPathAbsoluteString.hasSuffix(Constants.ImageType.jpg.rawValue)) {
            imageExtension = Constants.ImageType.jpg.rawValue
        } else if (assetPathAbsoluteString.hasSuffix(Constants.ImageType.jpeg.rawValue)) {
            imageExtension = Constants.ImageType.jpeg.rawValue
        } else if (assetPathAbsoluteString.hasSuffix(Constants.ImageType.png.rawValue)) {
            imageExtension = Constants.ImageType.png.rawValue
        } else if (assetPathAbsoluteString.hasSuffix(Constants.ImageType.gif.rawValue)) {
            imageExtension = Constants.ImageType.gif.rawValue
        } else if (assetPathAbsoluteString.hasSuffix(Constants.ImageType.heic.rawValue)) {
            imageExtension = Constants.ImageType.heic.rawValue
        } else {
            imageExtension = nil
        }
        
        self.pickerController(picker, didSelect: image, imageType: imageExtension)
    }
}

extension PhotoPicker: UINavigationControllerDelegate {
    
}

