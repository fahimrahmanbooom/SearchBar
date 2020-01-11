//
//  ViewController.swift
//  SearchBar
//
//  Created by Fahim Rahman on 11/1/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // creating an object of Country class
    let countries = Country()
    
    // creating a variable to determined which array to load on the table view
    var searching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting the delegate and datasource of table view and search bar
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        // hides empty cells section line
        tableView.tableFooterView = UIView()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    // table view functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // checking which array elements to count
        if searching {
            
            return countries.searchCountry.count
        }
        else {
            
            return countries.countryList.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        // checking which array to show on the table view
        
        if searching {
            cell.label.text = countries.searchCountry[indexPath.row]
        }
        else {
            cell.label.text = countries.countryList[indexPath.row]
        }
        
        return cell
    }
    
    // search bar functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // filtering the elements based on what user types on the searchbar
        countries.searchCountry = countries.countryList.filter({ $0.lowercased().prefix(searchText.count) == searchText.lowercased() })
        
        // making the searching variable true
        searching = true
        
        // reloading the table view based on what user searched for
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        // making the searching variable false
        searching = false
        
        // making search field empty when the cancel button is pressed
        searchBar.text = ""
        
        // reloading the table view when search field is empty
        tableView.reloadData()
        
        // hiding the keyboard when cancel button is pressed
        self.view.endEditing(true)
    }
}
