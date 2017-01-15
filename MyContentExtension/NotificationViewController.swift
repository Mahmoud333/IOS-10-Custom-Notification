//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Mahmoud Hamad on 1/11/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func didReceive(_ notification: UNNotification) {

        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        //pulling 1st attachment out of it
        //when you create these extensions thet're not sandboxing your app, your app can be totally be cloased down and when you receive one of these notifications it operates outside of your app sandbox
        
        if attachment.url.startAccessingSecurityScopedResource() {
            let imageData = try? Data.init(contentsOf: attachment.url)
            
            if let img = imageData {
                imageView.image = UIImage(data: img)
            }
            //then go to plist NSExtension->NSExtensionAttributes->UNNotificationExtensionCategory
        }
        
        //this AccessingSecurityScopedResource is just because its operating outside ur sandbox so we have got to do this route here
    }

    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        //when we open it as extension it will call it
        if response.actionIdentifier == "fistBump" {
            print("fistBump")
            completion(.dismissAndForwardAction) //we are not setting up custom code to handle these but this basically just going to dismiss the notification and forward it to that delegate
        } else if response.actionIdentifier == "dismiss" {
            print("dismiss")
            completion(.dismissAndForwardAction)
        }
    }

}
