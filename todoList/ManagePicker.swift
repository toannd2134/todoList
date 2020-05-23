
//  ManagePicker.swift
//  todoList
//
//  Created by Toan on 5/23/20.
//  Copyright © 2020 Toan. All rights reserved.


import Foundation
import UIKit
import Photos
class Manager {
    var imagePicker : UIImagePickerController!
    var viewConttroller : UIViewController!
    init(_ imagePicker :UIImagePickerController , _ viewconttroler : UIViewController ) {
        self.imagePicker = imagePicker
        self.viewConttroller = viewconttroler
    }


    // bạn phải comfirm vào Photto hay camera de thuc hien truy xuất dữ liệu
    func confirm(message :String ,viewController : UIViewController? , success : @escaping () -> Void) {
        let alert = UIAlertController(title: "Person app", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil
        )
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }

    func setting(){
        let message = "app cần truy cập ảnh và thư viện của bạn . Ảnh của bạn sẽ không được chia sẻ khi chưa được phép của bạn  "
        confirm(message: message, viewController: viewConttroller) {
            guard let setingUrl  = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(setingUrl){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.canOpenURL(setingUrl)
                }else{
                    UIApplication.shared.canOpenURL(setingUrl)
                }
            }
        }

    }
    // truy cập thư viện. phải qua các bước

    func fromLibery(){
        // truy câp vao photolibrary
        func choosePhoto(){
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary // nơi truy cập
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)! //cho phép dùng media co sẵn
            self.imagePicker.modalPresentationStyle = .popover // suất hiên tức khăc giữa màn hình
            DispatchQueue.main.async {
                self.viewConttroller.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        // kiểm tra tính xác thực  xem nếu thiết bị đã cho phép ,chưa cho phép và chưa đc xác định(gồm cả cho phép và chưa cho phép) bắt buộc
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized){
            choosePhoto()

        }else if (status == PHAuthorizationStatus.denied) {
            setting()
        }else if (status == PHAuthorizationStatus.notDetermined) {
            PHPhotoLibrary.requestAuthorization ({ (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized){
                    choosePhoto()
                }else {
                 print("không được phép truy cập vào thư viện ảnh ")
                    self.setting()
                }
            })
        }else if (status == PHAuthorizationStatus.restricted){
            print("restric access")
            setting()
        }
    }
    func fromcamera(){
        func takePhoto(){
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.cameraDevice = .front
                self.imagePicker.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    self.viewConttroller.present(self.imagePicker, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "thông báo", message: "không tìm thấy máy ảnh ", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "ok", style: .default, handler: nil )
                    alert.addAction(ok)
                    self.viewConttroller.present(alert, animated: true, completion: nil)
                }
            }
        }
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (responnd) in
            if responnd {
                takePhoto()

            }else {
                self.setting()
            }
        }
    }

}

