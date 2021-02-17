//
//  NewUserViewController.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 08/02/2021.
//

import UIKit

class NewUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var newUserFirstNameTextField: UITextField!
    @IBOutlet weak var newUserLastNameTextField: UITextField!
    @IBOutlet weak var newUserInitialBalanceTextField: UITextField!
    @IBOutlet weak var newUserImage: UIImageView!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBOutlet weak var currencyStackView: UIStackView!
    weak var imagePicker:UIImagePickerController?
    var currencyPicked:Currency?
    var newImage:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    // enable registration dialog box panning for user comfort
    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.container)
            gestureRecognizer.view!.center =  CGPoint(x: gestureRecognizer.view!.center.x + translation.x,y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.container)
        }
    }
    // enable re centering of the registration dialog box on click
    @objc func handleScreenClick(gestureRecognizer: UITapGestureRecognizer) {
        container?.center.y = self.view.center.y - 64
        container?.center.x = self.view.center.x
    }
    func initViews() {
        // default to the firs trow at the picker view
        pickerView(currencyPicker, didSelectRow: 0, inComponent: 0)
        // add our dialog box tap gesture recognizer
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleScreenClick(gestureRecognizer:))))
        // add our image tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        newUserImage?.addGestureRecognizer(tapGesture)
        // enable image interaction
        newUserImage?.isUserInteractionEnabled = true
        // customize our image
        newUserImage?.roundedImage(borderColor: UIColor.black.cgColor, cornerRadius: 60.0)
        // remove our view's bacgkround
        self.view.backgroundColor = UIColor.clear
        // customize our registration dialog box
        container?.layer.cornerRadius = 32.0
        currencyStackView?.layer.cornerRadius = 8.0
        container?.layer.borderWidth = 1.0
        container?.layer.borderColor = UIColor.white.cgColor
        // add our dialog box pan gesture recognizer
        container?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:))))
        // change our button's color
        registerButton?.setTitleColor(UIColor.black, for: .normal)
        registerButton?.layer.borderWidth = 1.0
        registerButton?.layer.borderColor = UIColor.black.cgColor
        registerButton?.backgroundColor = UIColor.white
        registerButton?.layer.cornerRadius = 8.0
        registerButton?.setTitleColor(UIColor.systemBlue, for: .selected)
        registerButton?.setTitleColor(UIColor.systemBlue, for: .highlighted)
        // set our dialog box background color
        UIUtils.setLoginBackgroundImage(pView: container)
        // set all our view's delegate to self
        newUserFirstNameTextField.delegate = self
        newUserLastNameTextField.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        newUserInitialBalanceTextField.delegate = self
    }
    
    
    @objc func imageTapped() {
        // allow image selection from library
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        imagePicker = picker
        present(picker, animated: true)
    }
    
    
    @IBAction func createNewUserTapped(_ sender: Any) {
        var newUserFirstName:String?
        var newUserLastName:String?
        var newUserImageData:Data?
        var newUserInitialBalance:Int64?
        if let firstName = newUserFirstNameTextField?.text, let lastName = newUserLastNameTextField?.text, let initialBalance = newUserInitialBalanceTextField?.text {
            // check if first name constains more then 2 characters
            if firstName.count < 2 {
                let alert = UIAlertController(title: "Alert", message: "First name must contain at least 2 characters", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                present(alert, animated: true)
                return
            }else {
                // set our new user's first name
                newUserFirstName = firstName
            }
            // check if last name constains more then 2 characters
            if lastName.count < 2 {
                let alert = UIAlertController(title: "Alert", message: "Last name must contain at least 2 characters", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                present(alert, animated: true)
                return
            }else {
                // set our new user's last name
                newUserLastName = lastName
            }
            // check if initial balance constains more then 2 characters
            if initialBalance.count < 2 {
                let alert = UIAlertController(title: "Alert", message: "inital balance must contain at least 2 digits", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                present(alert, animated: true)
                return
            }else {
                // set our new user's initial balance
                newUserInitialBalance = Int64(initialBalance)
            }
        }
        // check if an image was selected
        if let image = newImage {
            let imagedata = image.pngData()
            // set our new user's image
            newUserImageData = imagedata
        }
        // save our user to the database
        if newUserFirstName != nil && newUserLastName != nil && newUserInitialBalance != nil  {
            // in case user selected an image , initiate a new user with an image
            if let imagedata = newUserImageData {
                let newUser = CorePerson(firstName: newUserFirstName!, lastName: newUserLastName!, balance: newUserInitialBalance!, income: 0, expense: 0, image: imagedata)
                CoreData.shared.saveUser(person: newUser)
                // user did no select image, initiate a new user with no image
            }else {
                let newUser:CorePerson = CorePerson(firstName: newUserFirstName!, lastName: newUserLastName!, balance: newUserInitialBalance!, income: 0, expense: 0)
                if let currencyPicked = currencyPicked {
                    let currency:CoreCurrency = CoreCurrency(name: currencyPicked.name,symbol:currencyPicked.symbol)
                    newUser.setUserCurrency(currency:currency)
                }
                CoreData.shared.saveUser(person: newUser)
            }
            // user created, present our home view tab controller and dismiss registration view
            let homevc:TabBarViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "mainController") as! TabBarViewController
            homevc.modalPresentationStyle = .fullScreen
            let alert = UIAlertController(title: "Welcome!", message: "Thank you for choosing FinanceTracker \(String(describing: AppDelegate.user!.firstName!)) click the + button to add invoices", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
            present(homevc, animated: true) {
                homevc.present(alert, animated: true)
            }
        }else {
            let alert = UIAlertController(title: "Alert", message: "Please fill all the fields in order to submit", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
            present(alert, animated: true)
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Currencies.shared.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        // create a custom label for our picker view text
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Montserrat", size: 10)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        pickerLabel?.textColor = UIColor.black
        pickerLabel?.text = Currencies.shared[row].name
        
        return pickerLabel!;
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // change the currency picked instance
        currencyPicked = Currencies.shared[row]
    }
    
}

extension NewUserViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing textSu
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        // balance has max of 16 chars allowed, name and last name 12
        if  textField == newUserInitialBalanceTextField {
            return updatedText.count <= 16 && allowedCharacters.isSuperset(of: characterSet)
        }else {
            return updatedText.count <= 12
        }
    }
}
extension NewUserViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else {return}
        newImage = userPickedImage
        newUserImage?.image = newImage
        imagePicker?.dismiss(animated: true)
    }
}

