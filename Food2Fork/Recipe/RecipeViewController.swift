//
//  ViewController.swift
//  Food2Fork
//
//  Created by Michael Redoble on 18/11/2017.
//  Copyright © 2017 mjredoble. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataSource = RecipeDataSource.self
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
            return dataSource.listOfReicpe.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
        cell.recipe = dataSource.listOfReicpe[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let selectedRecipe = dataSource.listOfReicpe[indexPath.row]
        self.performSegue(withIdentifier: "RecipeDetailSegue", sender: selectedRecipe)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetailSegue" {
            let destinationViewController = segue.destination as! RecipeDetailViewController
            destinationViewController.recipe = sender as? Recipe
        }
    }
}

