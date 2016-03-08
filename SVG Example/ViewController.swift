//
//  ViewController.swift
//  SVG Example
//
//  Created by eze on 3/2/16.
//  Copyright © 2016 Eze. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var imageView : SVGKLayeredImageView?
    var tapGesture : UITapGestureRecognizer?
    var lastHitLayer : CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.delegate = self
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
                navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        title = "SVG Rocks"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        loadSVGFile("Tank.svg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadSVGFile (svgName : String) {
        let image : SVGKImage = SVGKImage(named: svgName)
        imageView = SVGKLayeredImageView(SVGKImage: image)
        
        if tapGesture == nil {
            tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        }
        imageView!.addGestureRecognizer(tapGesture!)
        scrollView.addSubview(imageView!)
        scrollView.contentSize = imageView!.frame.size
        
        let screenToSizeRatio : CGFloat = scrollView.frame.size.width / imageView!.frame.size.width
        
        scrollView.minimumZoomScale = min(1, screenToSizeRatio)
        scrollView.maximumZoomScale = max(1, screenToSizeRatio)
    }
    
    //MARK: TAP
    
    func handleTap(gesture : UITapGestureRecognizer) {
        let point : CGPoint = gesture.locationInView(imageView)
        print(point)
        let zoomedPoint : CGPoint = self.imageView!.convertPoint(point, toView: self.scrollView)
        let layer = imageView?.layer
        
        let hitTest = layer?.hitTest(zoomedPoint)
        hitTest?.borderColor = UIColor.greenColor().CGColor
        hitTest?.borderWidth = 2.0
        
        lastHitLayer?.borderColor = UIColor.clearColor().CGColor
        lastHitLayer?.borderWidth = 0.0
        lastHitLayer = hitTest
    }
    
    //MARK: ScrollViewDelegate
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

