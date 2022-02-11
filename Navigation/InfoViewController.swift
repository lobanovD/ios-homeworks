//
//  InfoViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 25.08.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    var alertButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        alertButton = UIButton(frame: CGRect(x: view.frame.width/2-100, y: view.frame.height/2-25, width: 200, height: 50))
        alertButton.layer.cornerRadius = 25
        alertButton.backgroundColor = .green
        alertButton.setTitle("Alert", for: .normal)
        
        alertButton.addTarget(self, action: #selector(alert), for: .touchUpInside)
        
        view.addSubviews(alertButton, titleLable, orbitalPeriodLable)
    }
    
    var titleLable: UILabel {
        let titleLable = UILabel(frame: CGRect(x: view.frame.width/4, y: view.frame.height/10, width: 200, height: 50))
        titleLable.text = NetworkManager.title
        return titleLable
    }
    
    var orbitalPeriodLable: UILabel {
        let orbitalPeriodLable = UILabel(frame: CGRect(x: view.frame.width/4, y: view.frame.height/4, width: 200, height: 50))
        orbitalPeriodLable.text = NetworkManager.orbitalPeriod
        return orbitalPeriodLable
    }

    @objc func alert() {
        let alert = UIAlertController(title: "AlertTitle", message: "AlertMessage", preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: "FirstAlertAction", style: .default) { _ in
            print("First Alert Action")
        }
        let secondAlertAction = UIAlertAction(title: "SecondAlertAction", style: .default) { _ in
            print("Second Alert Action")
        }
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        self.present(alert, animated: true, completion: nil)
    }   
}
