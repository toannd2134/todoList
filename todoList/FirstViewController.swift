//
//  FirstViewController.swift
//  todoList
//
//  Created by Toan on 5/23/20.
//  Copyright © 2020 Toan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var person = [Person]()
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let addbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        self.navigationItem.rightBarButtonItem = addbutton
        self.navigationItem.title = "List items"
        self.table.tableFooterView = UIView()
        self.table.delegate = self
        self .table.dataSource = self
        self.table.register(UINib(nibName: "todoListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
       
    }
    @objc func addAction(){
        
        let vc  = addUserViewController()
       
               vc.passdata = { [weak self] data in
                   guard let main = self  else {return}
                   main.person.append(data)
                   main.table.reloadData()
                   
               }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }



}
extension FirstViewController : UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100             
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! todoListTableViewCell
        cell.nameLabel.text = person[indexPath.row].name
        cell.sdtLabel.text = person[indexPath.row].phone
        cell.Userimage.image = person[indexPath.row].avartar
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete  = UIContextualAction(style: .normal, title: "delete") { (action, view1, competion) in
            self.person.remove(at: indexPath.row)
            tableView.reloadData()
            view1.backgroundColor = .red
        }
        let edit = UIContextualAction(style: .normal, title: "edit") { (action, view, competion) in
            let vc = addUserViewController()
            vc.setPhone = self.person[indexPath.row].phone
            vc.setName = self.person[indexPath.row].name
            vc.setImage = self.person[indexPath.row].avartar
            vc.passdata = { [weak self] data in
                guard let main = self else{return}
                main.person.remove(at: indexPath.row)
                main.person.insert(data, at: indexPath.row)
                tableView.reloadData()
                
            }
            self.navigationController?.pushViewController(vc, animated: true)
           
            
            view.backgroundColor = .blue
        }
        let confinguartion = UISwipeActionsConfiguration(actions: [edit,delete])
        return confinguartion
    }
    
}
