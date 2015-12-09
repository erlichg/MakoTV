//
//  ViewController.swift
//  MakoVOD
//
//  Created by Guy Erlich on 11/26/15.
//  Copyright © 2015 n/a. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVPlayerViewControllerDelegate {

    @IBOutlet var table: UITableView!
    var items: [Dictionary<String, Any?>] = []
    var player:AVPlayer? = nil
    var controller:AVPlayerViewController? = nil
    var breadcrumb:[String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.table.dataSource = self
        self.table.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Menu.rawValue)];
        self.view.addGestureRecognizer(tapRecognizer)
        getVODItems("")
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            if breadcrumb.count >= 2 {
                breadcrumb.removeLast() //remove current url
                getVODItems(breadcrumb.removeLast())
            } else {
                //first page so quit
                exit(0)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.table.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        let a = items[indexPath.row]
        cell.textLabel?.text = (a["listitem"] as! [String:Any?])["title"] as? String
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let url = items[indexPath.row]["url"] as! String
        getVODItems(url)
    }
    
    func getVODItems(url: String) {
        //let overlay:UIView = UIView(frame: self.view.frame)
        //overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        let activity:UIActivityIndicatorView = UIActivityIndicatorView(frame: self.view.frame)
        activity.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(activity)
        activity.startAnimating()
        do {
            let new_items = try vod(url, view: self)
            if(new_items.count != 0) {
                breadcrumb.append(url)
                items = new_items
                self.table.reloadData()
            }
        } catch let error as VODErrors {
            var e = ""
            switch(error) {
            case VODErrors.NeedToPay:
                e = "פריט זה דורש תשלום"
                break
            case VODErrors.NoAccess:
                e = "אין גישה לפריט זה"
                break
            case VODErrors.Other(let reason):
                e = reason
                break
            }
            let alert:UIAlertController = UIAlertController(title: "Error", message: e, preferredStyle: UIAlertControllerStyle.Alert)
            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default)  {(action) in
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: {})
        } catch {
            
        }
        activity.removeFromSuperview()
    }
    
    func AVPlay(url:String?) {
        if url != nil {
            player = AVPlayer(URL: NSURL(string: url!)!)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "finishedPlaying:", name: AVPlayerItemDidPlayToEndTimeNotification, object: player?.currentItem)
            controller = AVPlayerViewController()
            controller!.player = player
            self.presentViewController(controller!, animated: true, completion: {
                self.player?.play()
            })
        }
    }
    
    func finishedPlaying(notification: NSNotification) {
        self.controller?.dismissViewControllerAnimated(true, completion: {})
    }
    
    func stoppedPlaying(notification: NSNotification) {
        let time = self.player?.currentTime()
        print(time)
    }
    
}

