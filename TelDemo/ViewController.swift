//
//  ViewController.swift
//  TelDemo
//
//  Created by lunkr on 2018/3/26.
//  Copyright © 2018年 xizhipian. All rights reserved.
//

import UIKit
import WebKit

enum SectionType: Int {
    case normal = 0
    case option
    case webview
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let items = ["tel://your phone number", "telprompt://your phone number"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.webview.rawValue + 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        tableViewCell.textLabel?.text = items[indexPath.row]
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let section = indexPath.section
        
        guard row < items.count else {
            print("error IndexPath.row")
            return
        }
        
        guard let sectionType = SectionType(rawValue: section) else {
            print("error IndexPath.section")
            return
        }
        
        let url = items[row]
        
        callTo(url: url, section: sectionType)
    }
    
    func callTo(url:String, section:SectionType = SectionType.normal) {
        guard let callURL = URL(string:url) else {
            print("error nil url \(#function)")
            return
        }
        let shared = UIApplication.shared
        
        
        switch section {
        case .normal:
            if #available(iOS 10, *)  {
                print("Deprecated API")
            } else {
                shared.openURL(callURL)
            }
        case .option:
            if #available(iOS 10, *)  {
                shared.open(callURL, options: [:], completionHandler: nil)
            } else {
                print("futuer API support begin iOS 10")
            }
        default:
            let request = URLRequest(url: callURL)
            let webView = UIWebView()
            self.view.addSubview(webView)
            webView.loadRequest(request)
        }
    }
}

