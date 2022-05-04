//
//  ViewController.swift
//  TestGRPCProject
//
//  Created by Avijit Mondal on 23/03/22.
//

import UIKit

class ViewController: UITableViewController{

    
    private var students : [Student_Student]?{
        didSet{
            tableView.reloadData()
        }
    }
    private let repo = GRPCRepository()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        getAllStudents()
    }
    
    private func getAllStudents(){
        repo.getAllStudent { result, error in
            self.students = result?.students
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        var config = cell.defaultContentConfiguration()
        config.text = students?[indexPath.row].name
        config.secondaryText = students?[indexPath.row].subject
        cell.contentConfiguration = config
        return cell
    }
    
    


}

