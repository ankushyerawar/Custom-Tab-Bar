//
//  ViewController.swift
//  Custom Tab Bar
//
//  Created by Ankush Yerawar on 27/10/20.
//  Copyright © 2020 Ankush Yerawar. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {

    var homeVC: UIViewController?
    var searchVC: UIViewController?
    var profileVC: UIViewController?
    
    @IBOutlet var tabView: UIView!
    @IBOutlet var homeView: UIStackView!
    @IBOutlet var searchView: UIStackView!
    @IBOutlet var profileView: UIStackView!
    @IBOutlet var tabViewBottom: NSLayoutConstraint!
    
    @IBOutlet var homeImage: UIImageView!
    @IBOutlet var searchImage: UIImageView!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var homeLabel: UILabel!
    @IBOutlet var searchLabel: UILabel!
    @IBOutlet var profileLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tab View Rounded Corner
        tabView.layer.cornerRadius = 17.0
        
        //Add Tap Gesture to Stack view
        let homeViewTapped = UITapGestureRecognizer(target: self, action: #selector(tabBar(tapGestureRecognizer:)))
        let searchViewTapped = UITapGestureRecognizer(target: self, action: #selector(tabBar(tapGestureRecognizer:)))
        let profileViewTapped = UITapGestureRecognizer(target: self, action: #selector(tabBar(tapGestureRecognizer:)))
        homeView.addGestureRecognizer(homeViewTapped)
        searchView.addGestureRecognizer(searchViewTapped)
        profileView.addGestureRecognizer(profileViewTapped)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load First Screen i.e HOME
        homeVC = HomeViewController.init(nibName: "HomeViewController", bundle: Bundle.main)
        self.view.insertSubview(homeVC!.view!, belowSubview: self.tabView)
        changeTabStyle()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animate Button to slide up from bottom
        UIView.animate(withDuration: 2.4, delay: 0.4, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
            
            self.tabView.alpha = 1.0
            self.tabView.center.y -= 40
            
        }, completion: nil)
    }
    
    @objc func tabBar(tapGestureRecognizer: UITapGestureRecognizer) {
        // UIView bottom margin
        tabViewBottom.constant = 40
        
        // Here check if the controller is already loaded or not, if it already exists show the same controller.
        switch tapGestureRecognizer.view! {
        case searchView:
            if searchVC == nil {
                searchVC = SearchViewController.init(nibName: "SearchViewController", bundle: Bundle.main)
            }
            changeTabStyle(index: 2)
            self.view.insertSubview(searchVC!.view!, belowSubview: self.tabView)
        case profileView:
            if profileVC == nil {
                profileVC = SettingsViewController.init(nibName: "SettingsViewController", bundle: Bundle.main)
            }
            changeTabStyle(index: 3)
            self.view.insertSubview(profileVC!.view!, belowSubview: self.tabView)
        default:
            if homeVC == nil {
                homeVC = HomeViewController.init(nibName: "HomeViewController", bundle: Bundle.main)
            }
            changeTabStyle()
            self.view.insertSubview(homeVC!.view!, belowSubview: self.tabView)
        }
    }
    
    func changeTabStyle(index: Int = 1) {
        
        // Default Style
        defaultImage(imageView: homeImage, label: homeLabel)
        defaultImage(imageView: searchImage, label: searchLabel)
        defaultImage(imageView: profileImage, label: profileLabel)
        
        switch index {
        case 2:
            searchImage.tintColor = .white
            searchLabel.textColor = .white
            searchLabel.font = .boldSystemFont(ofSize: 17)
        case 3:
            profileImage.image = UIImage(systemName: "person.fill")
            profileLabel.textColor = .white
            profileImage.tintColor = .white
            profileLabel.font = .boldSystemFont(ofSize: 17)
        default:
            homeImage.image = UIImage(systemName: "house.fill")
            homeLabel.textColor = .white
            homeImage.tintColor = .white
            homeLabel.font = .boldSystemFont(ofSize: 17)
            
        }
        
    }
    
    func defaultImage(imageView: UIImageView, label: UILabel) {
        
        //Default label Style
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 17)
        
        switch imageView {
        case homeImage:
            homeImage.image = UIImage(systemName: "house")
            homeImage.tintColor = UIColor(named: "ImageColor")
            
        case searchImage:
            searchImage.image = UIImage(systemName: "magnifyingglass")
            searchImage.tintColor = UIColor(named: "ImageColor")
            
        case profileImage:
            profileImage.image = UIImage(systemName: "person")
            profileImage.tintColor = UIColor(named: "ImageColor")
            
        default:
            break
        }
    }
}

