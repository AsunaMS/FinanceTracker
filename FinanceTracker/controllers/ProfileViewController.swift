//
//  ProfileViewController.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 31/01/2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var editProfile: UIBarButtonItem!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var profileDesc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        // Do any additional setup after loading the view.
    }
    
    func initViews() {
        // customize our profile image
        profilePic?.roundedImage(borderColor: UIColor.white.cgColor, cornerRadius: 60.0)
        // set our view's background color
        UIUtils.setBackgroundImage(pView: self.view)
        // customize the navigation bar
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // update our views in every appereance
        updateUserProfileViews()
    }
    
    func updateUserProfileViews() {
        if let user  = AppDelegate.user, let name = user.firstName, let lastName = user.lastName {
            profileName?.text = "\(name) \(lastName)"
            let lastActivity =  user.getInvoices()?.sorted(by: { (CoreInvoice1, CoreInvoice2) -> Bool in
                CoreInvoice1.invoiceDate! > CoreInvoice2.invoiceDate!
            }).first?.invoiceDate
            profileDesc?.text = "Last invoice added at:\r\n"
            if let lastActivity = lastActivity {
                profileDesc?.text! += "\(UIUtils.getFormattedDateString(for: lastActivity, dateStyle: .long))"
            }
            if let imageData = user.image {
                profilePic.image = UIImage(data: imageData)
            }
            if let imagedata = user.image {
                profilePic?.image = UIImage(data: imagedata)
            }
            profileName?.text = "\(name) \(lastName)"
        }
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editProfileVC = segue.destination as? EditProfileViewController {
            editProfileVC.delegate = self
        }
    }
    
}
extension ProfileViewController : UpdateProfileProtocol {
    func didUpdateProfile(user:CorePerson) {
        CoreData.shared.saveUser(person: user)
        updateUserProfileViews()
    }
}
