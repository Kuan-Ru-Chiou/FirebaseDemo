//
//  ResetPasswordViewController.swift
//  FirebaseDemo
//


//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Forgot Password"
        emailTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func resetPassword(sender: UIButton) {
        
        //輸入驗證
        guard let emailAddress = emailTextField.text, emailAddress != "" else {
            let alertController = UIAlertController(title: "Input error", message: "Please provide your email address for password reset" , preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        
        //傳送密碼重設的 email
        Auth.auth().sendPasswordReset(withEmail: emailAddress, completion: { (error) in
            
            let title = (error == nil) ? "Password Reset Follow-up" : "Password Reset Error"
            
            let message = (error == nil) ? "We have just send you a password reset email. Please check your inbox and follow the instruction to reset your password." : error?.localizedDescription
          
            let alertController = UIAlertController(title: "title", message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                
                if error == nil {
                    
                    //解除鍵盤
                    
                    self.view.endEditing(true)
                    
                    //返回登入畫面
                    
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                    
                }
            
            
            
            
            
            
            
            
    })

            alertController.addAction(okayAction)
            
            self.present(alertController, animated: true, completion: nil)
})


}

}
