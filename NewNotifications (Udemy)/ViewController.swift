//
//  ViewController.swift
//  NewNotifications (Udemy)
//
//  Created by Mahmoud Hamad on 1/2/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1st request permision to use notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            
            if granted { //if i gave permision
                print("Notification Access Granted")
                
            } else { print(error?.localizedDescription)}
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully Scheduled Notification")
            } else {
                print("Error Scheduling Notification")
            }
        })
    }

    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        let notif = UNMutableNotificationContent() //our content
        notif.title = "New Notification (title)"
        notif.subtitle = "These are great (sub-Title)"
        notif.body = "The new notification options in IOS 10 is what i've always dreamed of!"
        
        //add an attachment
        let myImage = "rick_grimes"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            print("something went wrong with image attachment")
            completion(false) //coudn't complete it
            return //get kicked out of this
        }
        var attachment: UNNotificationAttachment!
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none) //force it we know its here
    
        // ONLY FOR OUR EXTENSION
        notif.categoryIdentifier = "myNotificationCategory"
        
        //add
        notif.attachments = [attachment] //array of attachmets can put more than one
        
        //trigger
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        //request
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        //constant string identifier
        
        //add to user notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {(Error) in
            if Error != nil { //there is error
                print(Error?.localizedDescription)
                completion(false)
            } else {
                print("Successful")
                completion(true)
            }
        }) //when we run it as App it gets called but as extension it doesn't get called
    }

}












