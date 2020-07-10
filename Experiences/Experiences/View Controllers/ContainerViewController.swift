//
//  ContainerViewController.swift
//  Experiences
//
//  Created by Joe Veverka on 7/10/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    // MARK: Properties
    var media: Media?
    var mediaType: MediaType?{
        didSet{
            
        }
    }
    var delegate: ExperienceViewControllerDelegate?
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func handleMedia() {
        guard let type = mediaType else { return }
        switch type {
        case .audio:
            add(asChildViewController: audioViewController)
        case .image:
            
            break
        case .video:
            break
        }
    }
    
    private lazy var audioViewController: AudioViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerViewController") as! AudioViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    private lazy var videoViewController: VideoViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "VideoPlayerController") as! VideoViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var imageViewController: ImageViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "VideoRecorderViewController") as! ImageViewController
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    private func updateView() {
        
    }
}
