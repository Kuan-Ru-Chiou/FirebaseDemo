//
//  ProfileViewController.swift
//  FirebaseDemo
//
// 
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Profile"
        
        if let currentUser = Auth.auth().currentUser {
            nameLabel.text = currentUser.displayName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func logout(sender: UIButton) {
        
        do {
            
            if let providerData = Auth.auth().currentUser?.providerData {
                let userInfo = providerData[0]
                
                
                switch userInfo.providerID {
                case "google.com" :
                    GIDSignIn.sharedInstance()?.signOut()
                default:
                    break
                }
            }
            
            
            try  Auth.auth().signOut()
            
        } catch {
            
            
           let alertController = UIAlertController(title: "Logout error", message: error.localizedDescription, preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        
            return
            
        }
        
        
        
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeView") {
            
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
        
    }
    
    
    
    
    
}
