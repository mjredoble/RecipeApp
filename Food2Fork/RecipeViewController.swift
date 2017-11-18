//
//  ViewController.swift
//  Food2Fork
//
//  Created by Michael Redoble on 18/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dateSource = RecipeDataSource.self
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func configureView() {
        let logo = UIImage(named: "small_logo")
        self.navigationItem.titleView = UIImageView(image: logo)
        
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.tableFooterView = UIView()
    }
    
    func loadData() {
        RecipeDataSource.searchRecipe(keyword: "", successHandler: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    func reloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.loadData()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    @objc func pullToRefresh() {
        reloadData()
    }
    
    //MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if RecipeDataSource.listOfReicpe.count > 0 {
            return dateSource.listOfReicpe.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
        cell.recipe = dateSource.listOfReicpe[indexPath.row]
        
        return cell
    }
}

