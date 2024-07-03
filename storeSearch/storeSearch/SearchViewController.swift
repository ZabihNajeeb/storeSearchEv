//
//  ViewController.swift
//  storeSearch
//
//  Created by MacUser on 2024-07-02.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchResults = [SearchResult]()
    var hasSearched = false


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 51, left: 0, bottom: 0, right: 0)

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
  
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchResults = []
        if searchBar.text! != "justin bieber" {
            for i in 0...2 {
                let searchResult = SearchResult()
                searchResult.name = String(format: "Fake Result %d for", i)
                searchResult.artistName = searchBar.text!
                searchResults.append(searchResult)
            }
        }
        hasSearched = true      // Add this line
          tableView.reloadData()
    }
}
// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
      if !hasSearched {
        return 0
      } else if searchResults.count == 0 {
        return 1
      } else {
        return searchResults.count
      }
    }

    func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cellIdentifier = "SearchResultCell"
      
      var cell = tableView.dequeueReusableCell(
        withIdentifier: cellIdentifier)
      if cell == nil {
        cell = UITableViewCell(
            style: .subtitle, reuseIdentifier: cellIdentifier)
      }
        // New code
        if searchResults.count == 0 {
            cell?.textLabel!.text = "(Nothing found)"
            cell?.detailTextLabel!.text = ""
        } else {
          let searchResult = searchResults[indexPath.row]
            cell?.textLabel!.text = searchResult.name
            cell?.detailTextLabel!.text = searchResult.artistName
        }
        // End of new code
        return cell!
    }
    
    func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
      
    func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
      if searchResults.count == 0 {
        return nil
      } else {
        return indexPath
      }
    }


  }

