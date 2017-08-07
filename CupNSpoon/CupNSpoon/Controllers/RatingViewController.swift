//
//  RatingViewController.swift
//  CupNSpoon
//
//  Created by Raymond Diamonds on 2017-07-25.
//  Copyright © 2017 Raymond Diamonds. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    var cafe: Cafe?
    
    var selectedHash = [String]()
    
    @IBAction func selectedHash(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            sender.layer.borderWidth = 0
            
            selectedHash.append(sender.currentTitle!)
            
        } else {
            sender.layer.borderWidth = 1
            selectedHash.remove(at: selectedHash.index(of: sender.currentTitle!)!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let yelpID = cafe?.id else { return }
        RatingService.create(hashtags: selectedHash, yelpID: yelpID, completion: {})
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }




}

extension RatingViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPC(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return BounceCAT()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return SlideOutCAT()
    }
    
}
