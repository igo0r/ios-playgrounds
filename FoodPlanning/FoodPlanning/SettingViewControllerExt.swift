//
//  SettingViewControllerExt.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 20/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import MessageUI

extension SettingViewController: MFMailComposeViewControllerDelegate {
    
    /*
     mail configuration for feddback action
     */
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([appEmail])
        
        let versionNumberString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? ""
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") ?? ""
        
        mailComposerVC.setSubject("Feedback: \(appName) \(versionNumberString)")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func showSendMailErrorAlert() {
        let alert = AlertUtils.sendMailError()
        self.present(alert, animated: true, completion: nil)
    }
}
