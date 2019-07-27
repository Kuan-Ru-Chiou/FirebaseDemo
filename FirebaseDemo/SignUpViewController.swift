//
//  SignUpViewController.swift
//  FirebaseDemo
//

//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sign Up"
        nameTextField.becomeFirstResponder()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @ IBAction func registerAccount(sender: UIButton) {
        
        // 輸入驗證
        guard let name = nameTextField.text, name != "",
        let emailAddress = emailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
                
                
                let alertController = UIAlertController(title: "Registration error", message: "Please make sure you provide your name, email address and password to complete the registration", preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        //在Firebase 註冊使用者帳號
        Auth.auth().createUser(withEmail: emailAddress, password: password, completion: { (user, error) in
            
            if let error = error {
                let alertController = UIAlertController(title: "Register error", message: error.localizedDescription, preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
                
            }
            
            //儲存使用者名稱
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                
                
                changeRequest.displayName = name
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("Failed to change the display name:\(error.localizedDescription)")
                        
                    }
            })
            
        }
            
            //移除鍵盤
            self.view.endEditing(true)
            
            
            //傳送確認信
//
            user?.user.sendEmailVerification(completion: nil)
//
            let alertController = UIAlertController(title: "Email Verification", message: "We have just sent a confirmation email to your email address. Please check your inbox and click the verification link in that email to complete the sign up", preferredStyle: .alert)

            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                
                self.dismiss(animated: true, completion: nil)
                
            })
            
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            
            
            //呈現主視圖
//            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
//                UIApplication.shared.keyWindow?.rootViewController = viewController
//                self.dismiss(animated: true, completion: nil)
//            }
            
        
        
        
    })
    
    
    
}

}



