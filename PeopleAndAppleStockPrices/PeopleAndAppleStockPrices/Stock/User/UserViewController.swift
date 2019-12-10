//
//  UserViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Tanya Burke on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
        
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var searchBar: UISearchBar!
        
        let fileName = "userinfo"
        let ext = "json"
        
        var users = [User](){
            didSet{
                tableView.reloadData()
            }
        }
        
        var query = "" {
            didSet{
                users = getUsersSorted().filter{$0.name.returnFullName().lowercased().contains(query.lowercased())}
            }
        }

      override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        tableView.dataSource = self
        searchBar.delegate = self
      }
        
        func getRawData() -> Data{
            let data = Bundle.readRawjSONData(filename: fileName, ext: ext)
            return data
        }
        
        func getUsers() -> [User]{
            let data = Bundle.readRawjSONData(filename: fileName, ext: ext)
            let users = User.getUsers(from: data)
            return users
        }
        
        func getUsersSorted() -> [User]{
            users = getUsers().sorted{$0.name.first < $1.name.first}
            return users
        }
        
        func loadData(){
            users = getUsersSorted()
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let userInfoDVC = segue.destination as? UserDetailController, let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("failed to segue")
            }
            
            let user = users[indexPath.row]
            
            userInfoDVC.passedUserObj = user
        }

    }

    extension UserViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
            let user = users[indexPath.row]
            cell.textLabel?.text = user.name.returnFullName()
            cell.detailTextLabel?.text = user.cell
            
            return cell
        }
    }

    extension UserViewController: UISearchBarDelegate{
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard !searchText.isEmpty else {
                loadData()
                return
            }
            query = searchText
        }
    }
