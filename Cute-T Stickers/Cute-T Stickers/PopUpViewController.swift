//
//  PopUpViewController.swift
//  Cute-T Stickers
//
//  Created by Ankit Garg on 4/21/20.
//  Copyright © 2020 Omni Soft Solutions. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class PopUpViewController: UIViewController, MFMailComposeViewControllerDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tap=UITapGestureRecognizer(target:self, action:#selector(dismissView))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView()
    {
        dismiss(animated:true, completion:nil)
    }
    
    @IBAction func rateUs()
    {
        if #available(iOS 10.3, *)
        {
            SKStoreReviewController.requestReview()
        }
        else
        {
            UIApplication.shared.open(URL(string:"itms-apps://itunes.apple.com/app/id1234567")!, options:[:], completionHandler:nil)
        }
    }
    
    @IBAction func contactUs()
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mail=MFMailComposeViewController()
            mail.mailComposeDelegate=self
            mail.setToRecipients(["2047636989@qq.com"])
            mail.setSubject("Contact me")
            present(mail, animated:true, completion:nil)
        }
    }
    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?)
    {
        controller.dismiss(animated:true)
    }
}
