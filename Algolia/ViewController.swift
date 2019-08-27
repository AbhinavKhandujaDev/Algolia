//
//  ViewController.swift
//  Algolia
//
//  Created by abhinav khanduja on 27/08/19.
//  Copyright © 2019 abhinav khanduja. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let identifier = "cell"
    
    var page = 1
    
    var algoliaData : [Algolia.Hits] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Count: 0"
        fetchData(page: page) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "Count: \(self.algoliaData.count)"
            }
        }
    }
    
    fileprivate func fetchData(page: Int, completion: @escaping(()->())) {
        let url = URL(string: "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=\(page)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("url is ",url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let receivedData = data else {return}
            do {
                let decodedJson = try JSONDecoder().decode(Algolia.self, from: receivedData)
                decodedJson.hits.forEach({ (hit) in
                    self.algoliaData.append(hit)
                })
                completion()
            }catch {
                print("Error in fetching JSON: ",error)
            }
        }.resume()
    }

}

extension ViewController {
    
    //MARK:- TableView Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algoliaData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AlgoliaCell
        let row = algoliaData[indexPath.row]
        cell.titleLabel.text = "Title: " + row.title
        cell.createdAtLabel.text = "Created at: " + row.created_at
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == algoliaData.count - 1 {
            fetchData(page: page + 1) {
                DispatchQueue.main.async {
                    self.page += 1
                    self.tableView.reloadData()
                    self.navigationItem.title = "Count: \(self.algoliaData.count)"
                }
            }
        }
    }
}

