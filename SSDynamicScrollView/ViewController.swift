//
//  ViewController.swift
//  SSDynamicScrollView
//
//  Created by Sunny on 5/21/16.
//  Copyright © 2016 Sunny. All rights reserved.
//

import UIKit

extension UIScrollView {
    var currentPage:Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}

class ViewController: UIViewController ,UIScrollViewDelegate {

    var scrollView : UIScrollView!;
    var contectView = UIView();

    
    override func viewDidLoad() {
        self.createScrollView();
        
        self.contectView.translatesAutoresizingMaskIntoConstraints = false;
        self.scrollView.addSubview(self.contectView);
        
        
        let views = ["contectView" : self.contectView , "scrollview" : self.scrollView ];

        // create constraint for scrollview
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        // create constraint for contectview with low priority for width and height
        self.scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contectView(==scrollview@250)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        self.scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contectView(==scrollview@250)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))



        
        
        var horizontalConstraintsFormat = "";  // create horizantal constraint string
        let subViews = NSMutableDictionary();
        subViews["scrollView"] = self.scrollView;
        
        
        let totalPage : NSInteger = 10;

        for i in 0...totalPage {

            // Create your page here
            let objProductView : CustomView = NSBundle.mainBundle().loadNibNamed("CustomView", owner: self, options: nil)[0] as! CustomView
            objProductView.translatesAutoresizingMaskIntoConstraints = false;
            objProductView.backgroundColor = UIColor(white: CGFloat(arc4random()%100)/CGFloat(100), alpha: 1)

            self.contectView.addSubview(objProductView);
            
            
            
            let key = NSString(format: "productView%d", i) as  NSString
            objProductView.lblPage.text = NSString(format: "Page %d", i+1)  as String

            subViews[key] = objProductView;
            
            
            if(i==0){
                horizontalConstraintsFormat = horizontalConstraintsFormat.stringByAppendingFormat("|-0-[%@(==scrollView)]", key);
            }
            else if (i==totalPage) {
                horizontalConstraintsFormat = horizontalConstraintsFormat.stringByAppendingFormat("-0-[%@(==scrollView)]-0-|", key);
                
            }
            else{
                horizontalConstraintsFormat = horizontalConstraintsFormat.stringByAppendingFormat("-0-[%@(==scrollView)]", key);
                
            }
            
            let verticalConstraintsFormat = NSString(format:"V:|[%@(==scrollView)]", key);
            self.scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraintsFormat as String, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: subViews as AnyObject as! [String : AnyObject]));
            

        }
        self.scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraintsFormat as String, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: subViews as AnyObject as! [String : AnyObject]));
        
        
        


        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
        // Dispose of any resources that can be recreated.
    }


    func createScrollView(){
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = true;
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(self.scrollView);

    }
}

