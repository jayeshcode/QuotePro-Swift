//
//  ViewController.swift
//  QuotePro
//
//  Created by Jayesh Wadhwani on 2016-06-08.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

import UIKit


protocol MyProtocol: class
{
    func sendArrayToPreviousVC(model:Model)
}


class QuoteViewController: UIViewController {
    
    var model:Model = Model()
   
    var quoteview: QuoteView!
    
    
    weak var mDelegate:MyProtocol?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    
        if let objects = NSBundle.mainBundle().loadNibNamed("QuoteView", owner: nil, options: [:]),
            let quoteView = objects.first as? QuoteView
        {
            // set up view in view hierarchy
            quoteView.translatesAutoresizingMaskIntoConstraints = false
            view.insertSubview(quoteView, atIndex: 0)
            quoteView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 1).active = true
            quoteView.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 1).active = true
            quoteView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 1).active = true
            quoteView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 1).active = true
         self.quoteview = quoteView
            
            self.quoteview.quoteLabel?.numberOfLines = 0;
            self.quoteview.authorLabel?.numberOfLines = 0;
            // create all the photo objects
            generateImage()
            generateQuote()
            
        }
      
        
        
        
        
        
       
        
        
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("fire")
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func generateQuote()  {
        let req = NSMutableURLRequest(URL: NSURL(string:"http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) { (data, resp, err) in
            
            guard let data = data else {
                print("no data returned from server \(err)")
                return
            }
            
            guard let resp = resp as? NSHTTPURLResponse else {
                print("no response returned from server \(err)")
                return
            }
            
            guard let rawJson = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
                print("data returned is not json, or not valid")
                return
            }
            
            guard resp.statusCode == 200 else {
                // handle error
                
                return
                
            }
            
            let quote = rawJson["quoteText"] as! NSString
            let author = rawJson["quoteAuthor"] as! NSString
            
            
            self.model.author = author as String?
            self.model.quote = quote as String?
          
                    
            dispatch_async(dispatch_get_main_queue(), {
                self.quoteview.setUpWithQuote(self.model)
                
                // code here
                
            })
            
            
        }
        
        
        task.resume()
        
        
    }
    
    
    func generateImage()  {
        let req = NSMutableURLRequest(URL: NSURL(string:"https://unsplash.it/200/300/?random")!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) { (data, resp, err) in
            
            guard let data = data else {
                print("no data returned from server \(err)")
                return
            }
            
            guard let resp = resp as? NSHTTPURLResponse else {
                print("no response returned from server \(err)")
                return
            }
            
            let anImage = UIImage(data: data)
            guard resp.statusCode == 200 else {
                // handle error
                
                return
                
            }
            self.model.photo=anImage
            dispatch_async(dispatch_get_main_queue(), {
                self.quoteview.setUpWithQuote(self.model)

                
                
            })
            
            
        }
        
        task.resume()
        
        
    }
    
    
    @IBAction func actionOnImage(sender: AnyObject) {
        
        generateImage()
        
    }
    
    
    @IBAction func actionOnSave(sender: AnyObject) {
        
        
        
        let model:Model = Model()
        model.author = quoteview.authorLabel.text
        model.photo = quoteview.MyImageView.image
        model.quote = quoteview.quoteLabel.text
        mDelegate?.sendArrayToPreviousVC(model)
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func actionOnQuote(sender: AnyObject) {
        self.generateQuote()
        
    }
}
    