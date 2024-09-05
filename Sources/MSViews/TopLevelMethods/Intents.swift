//
//  File.swift
//  
//
//  Created by Corptia 02 on 16/08/2022.
//

import Foundation
import UIKit

public class Intents {
    public static let shared = Intents.init()
    
    public func goToWhatsApp(_ phoneNumber:String) {
        
        
        var appURL = phoneNumber.starts(with: "https://") || phoneNumber.localizedStandardContains("whats") ?
            URL(string: phoneNumber)
        : URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL!) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL!, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL!)
            }
        } else {
            appURL = phoneNumber.starts(with: "https://") || phoneNumber.localizedStandardContains("whats") ? URL(string: phoneNumber) : URL(string: "https://wa.me/\(phoneNumber)")!
            if UIApplication.shared.canOpenURL(appURL!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL!)
                }
            }
        }
    }
    
    public func makeCall(_ phone: String){
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    public func openFacebook(_ page_id:String) {
        let facebookURL = URL(string: "fb://profile/\(page_id)")!
        let safariURL = URL(string: "https://www.facebook.com/\(page_id)")!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(facebookURL) {
            // Open Facebook app
            application.open(facebookURL, options: [:], completionHandler: nil)
        } else {
            // Open Safari with the Facebook page URL
            application.open(safariURL, options: [:], completionHandler: nil)
        }
    }
    
    public func openAppStoreOnMyApp(_ link : String){
        if let url = URL(string: link),
           UIApplication.shared.canOpenURL(url)
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            //            msViews.viewsHelper.showToast(message: "Not in app store", mainView: mainView, type: .error)
        }
    }
    
    public func openInstagram(_ username:String) {
        let instagramURL = username.starts(with: "instagram://") ? URL(string: "instagram://user?username=\(username)")! : URL(string: username)
        let safariURL =  username.starts(with: "https://") ? URL(string: "https://www.instagram.com/\(username)")! : URL(string: username)
        
        let application = UIApplication.shared
        
        if application.canOpenURL(instagramURL!) {
            // Open Instagram app
            application.open(instagramURL!, options: [:], completionHandler: nil)
        } else {
            // Open Safari with the Instagram profile URL
            application.open(safariURL!, options: [:], completionHandler: nil)
        }
    }
    
    public func openTikTok(_ username:String) {
        if let tiktokURL = username.starts(with: "https://")
        || username.localizedStandardContains("tiktok")
        ? URL(string: username)
            : URL(string: "https://www.tiktok.com/@\(username)") {
            let application = UIApplication.shared
            application.open(tiktokURL, options: [:], completionHandler: nil)
        }
    }
    
    public func openSnapchat(_ username:String) {
        if let snapchatURL = username.starts(with: "https://")
            || username.localizedStandardContains("snapchat")
            ? URL(string: username)
            : URL(string: "https://www.snapchat.com/\(username)") {
            let application = UIApplication.shared
            application.open(snapchatURL, options: [:], completionHandler: nil)
        }
    }
    
    public func openTwitter(_ username : String) {
        // Replace {username} with the Twitter username or profile ID
        let twitterURL = username.starts(with: "twitter://") ? URL(string: "twitter://user?screen_name=\(username)")! : URL(string: username)
        let safariURL = username.starts(with: "https://") ? URL(string: "https://twitter.com/\(username)")! : URL(string: username)
        
        let application = UIApplication.shared
        
        if application.canOpenURL(twitterURL!) {
            // Open Twitter app if installed
            application.open(twitterURL!, options: [:], completionHandler: nil)
        } else {
            // Open Safari with the Twitter profile URL
            application.open(safariURL!, options: [:], completionHandler: nil)
        }
    }
    
    public func openMaps(lat: Double, lng: Double, label: String? = nil) {
        var urlString = "http://maps.apple.com/?ll=\(lat),\(lng)"
        if let label = label, !label.isEmpty {
            urlString += "&q=\(label.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }

    public func openMapsApps(lat:Double , lng : Double , toGoogleMaps:Bool = true , showDirections: Bool = false , label:String? = nil) {
        let googleMapsURL = URL(string: "comgooglemaps://?daddr=\(lat),\(lng)&directionsmode=driving&center=\(lat),\(lng)&zoom=14&q=\(lat),\(lng)")!
        let appleMapsURL = URL(string: "http://maps.apple.com/?daddr=\(lat),\(lng)&dirflg=d")!
        
        if(toGoogleMaps) {
            if UIApplication.shared.canOpenURL(googleMapsURL) {
                // Open Google Maps
                UIApplication.shared.open(googleMapsURL, options: [:], completionHandler: nil)
            } else {
                if(!showDirections) {
                    openMaps(lat: lat, lng: lng , label: label)
                } else {
                    // Open Apple Maps
                    UIApplication.shared.open(appleMapsURL, options: [:], completionHandler: nil)
                }
            }
        } else {
            if (!showDirections) {
                openMaps(lat: lat, lng: lng , label: label)
            } else {
                UIApplication.shared.open(appleMapsURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    public func checkForUpdates(completion: @escaping (Bool) -> Void) {
        guard let bundleID = Bundle.main.bundleIdentifier else {
            print("Bundle identifier not found.")
            completion(false)
            return
        }

        let urlString = "https://itunes.apple.com/lookup?bundleId=\(bundleID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            completion(false)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(false)
                return
            }

            guard let data = data else {
                print("Data not found.")
                completion(false)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let results = json?["results"] as? [[String: Any]], let appData = results.first {
                    if let currentVersion = appData["version"] as? String {
                        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                        
                        print("VERSION CHECK ", appVersion)
                        print("VERSION CHECK " ,currentVersion)

                        if currentVersion > appVersion! {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    } else {
                        print("Version information not found.")
                        completion(false)
                    }
                } else {
                    print("Results not found.")
                    completion(false)
                }
            } catch {
                print("Error parsing JSON: \(error)")
                completion(false)
            }
        }

        task.resume()
    }
}
