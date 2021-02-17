//
//  EditProfileViewController.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 08/02/2021.
//

import UIKit

protocol UpdateProfileProtocol {
    func didUpdateProfile(user:CorePerson)
}

class EditProfileViewController: UIViewController {

    @IBOutlet weak var setFirstNameTextField: UITextField!
    @IBOutlet weak var setLastNameTextField: UITextField!
    @IBOutlet weak var setProfileImage: UIImageView!

    weak var imagePicker:UIImagePickerController?
    var delegate:UpdateProfileProtocol?
    var newImage:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    @objc func imageTapped() {
        // edit profile image - select from photo library
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        imagePicker = picker
        present(picker, animated: true)
    }
    
    func initViews() {
        // set image to user's current image if available
        if let user  = AppDelegate.user, let imageData = user.image {
            setProfileImage?.image = UIImage(data: imageData)
        }
        // customize our profile image
        setProfileImage?.roundedImage(borderColor: UIColor.black.cgColor, cornerRadius: 60.0)
        // set our text field delegates
        setFirstNameTextField?.delegate =  self
        setLastNameTextField?.delegate = self
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        // add it to the image view;
        setProfileImage?.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        setProfileImage?.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }


    @IBAction func updateProfileTapped(_ sender: UIButton) {
        guard let user  = AppDelegate.user else {return}
        if let firstName = setFirstNameTextField?.text, let lastName = setLastNameTextField?.text {
            // check if the first name provided is empty & if has more then 2 characters
            if !firstName.isEmpty  {
                if firstName.count < 2 {
                    let alert = UIAlertController(title: "Alert", message: "First name  contain at least 2 characters", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                    present(alert, animated: true)
                    return
                }else {
                    // set user first name
                    user.firstName = firstName
                }
            }
            // check if the last name provided is empty & if has more then 2 characters
            if !lastName.isEmpty {
                if lastName.count < 2 {
                    let alert = UIAlertController(title: "Alert", message: "Last name  contain at least 2 characters", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                    present(alert, animated: true)
                    return
                }else {
                    // set user last name
                    user.lastName = lastName
                }
            }
        }
        // check if a new image was provided
        if let image = newImage {
            let imagedata = image.pngData()
            user.image = imagedata
        }
        // call delegate -> update our profile
        delegate?.didUpdateProfile(user:user)
        navigationController?.popViewController(animated: true)
    }


}

extension EditProfileViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
    
        // add their new text to the existing textSu
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    
        // make sure the result is under 16 characters
        return updatedText.count <= 12
    }
}

extension EditProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else {return}
        newImage = userPickedImage
        setProfileImage?.image = newImage
        imagePicker?.dismiss(animated: true)
    }

}
