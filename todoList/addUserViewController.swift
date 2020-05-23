//
//  addUserViewController.swift
//  todoList
//
//  Created by Toan on 5/23/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import UIKit

class addUserViewController: UIViewController {
    var passdata : ((Person) -> ())?
    var passEditData : ((Person) -> ())?
    var  imagePicker : UIImagePickerController!
    var manager : Manager!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var nameTexField: UITextField!
    var setName :String!
    var setPhone :String!
    var setImage :UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton =  UIButton(type: .system )
        backButton.setTitle("List item ", for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        manager = Manager(imagePicker, self)
        self.photoImage.image = setImage
        self.PhoneTextField.text = setPhone
        self.nameTexField.text = setName
    }
    @objc func back () {
        
        for vc in self.navigationController!.viewControllers{
            let vc1 = FirstViewController()
            if vc  == vc1{
                self.navigationController?.popToViewController(vc1, animated: true)
            }
        }
    }

    @IBAction func addItem(_ sender: Any) {
      guard let name = nameTexField.text , let phone = PhoneTextField.text else {
                 return
             }
             guard let avatar = photoImage.image else {
                 return
             }
             let person = Person(name: name, phone: phone, avartar: avatar)
             passdata?(person)
             passEditData?(person)
        self.navigationController?.popViewController(animated: true)
       
    }
    
 
    @IBAction func ChoicePhoto(_ sender: Any) {
        let alert  = UIAlertController(title: "thư viện ", message: "chọn ảnh từ", preferredStyle: .alert)
               let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
               let libbray = UIAlertAction(title: "thư viện ", style: .default) { (_) in
                   self.manager.fromLibery()
               }
               let camera = UIAlertAction(title: "máy ảnh", style: .default) { (_) in
                   self.manager.fromcamera()
               }
               alert.addAction(camera)
               alert.addAction(libbray)
               alert.addAction(cancel)
               present(alert, animated: true, completion: nil)
        
    }
    
}
extension addUserViewController :  UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage  else {
            return
        }
        photoImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
