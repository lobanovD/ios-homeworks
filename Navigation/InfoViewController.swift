//
//  InfoViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 25.08.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
//    var alertButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
//        alertButton = UIButton(frame: CGRect(x: view.frame.width/2-100, y: view.frame.height/2-25, width: 200, height: 50))
//        alertButton.layer.cornerRadius = 25
//        alertButton.backgroundColor = .green
//        alertButton.setTitle("Alert", for: .normal)
//
//        alertButton.addTarget(self, action: #selector(alert), for: .touchUpInside)
        
        view.addSubviews(titleLable, orbitalPeriodLable, personNameTable)
        setupConstraints()
        titleLable.text = NetworkManager.title
        orbitalPeriodLable.text = "Орбитальный период = \(NetworkManager.orbitalPeriod)"
        
        self.personNameTable.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.personNameTable.dataSource = self
    }
    
    private lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.toAutoLayout()
        return titleLable
    }()
    
    var orbitalPeriodLable: UILabel = {
        let orbitalPeriodLable = UILabel()
        orbitalPeriodLable.toAutoLayout()
        return orbitalPeriodLable
    }()
//
    var personNameTable: UITableView = {
        let personNameTable = UITableView()
        personNameTable.toAutoLayout()
        personNameTable.backgroundColor = .lightGray
        return personNameTable
    }()
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLable.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            orbitalPeriodLable.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            orbitalPeriodLable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            personNameTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            personNameTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            personNameTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            personNameTable.heightAnchor.constraint(equalToConstant: 400)
        ])
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

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NetworkManager.namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.personNameTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.backgroundColor = .lightGray
        cell.textLabel?.text = NetworkManager.namesArray[indexPath.row]
           return cell
    }
}

class TableViewCell: UITableViewCell {}
