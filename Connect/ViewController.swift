//
//  ViewController.swift
//  Connect
//
//  Created by Elizabeth S. Akman on 8/11/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var meetingPlace: UITextField!
    
    @IBOutlet weak var connectButton: UIButton!
    
    @IBAction func connectButtonPressed(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }

    }
        
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([emailAddress.text!])
        mailComposerVC.setSubject("Nice to meet you at \(meetingPlace.text!)")
        mailComposerVC.setMessageBody("Hello \(name.text!). It was great meeting you at \(meetingPlace.text!). Let's keep in touch!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
       // finished sending email, clear text field values
        emailAddress.text = ""
        meetingPlace.text = ""
        name.text = ""
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        name.becomeFirstResponder()
        
        self.emailAddress.delegate = self
        self.meetingPlace.delegate = self
        self.name.delegate = self
    }
    
    // dismiss keyboard if you press enter
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("pressed return key")
        // if in name and press next, go to email address
        if name.isFirstResponder() {
            emailAddress.becomeFirstResponder()
        } else if emailAddress.isFirstResponder() {
            meetingPlace.becomeFirstResponder()
        } else {
            self.view.endEditing(true) //hides keyboard
        }
        
        return false
    }

}

