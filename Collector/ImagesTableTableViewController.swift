//
//  ImagesTableTableViewController.swift
//  Collector
//
//  Created by Andy Harris on 23/02/2018.
//  Copyright © 2018 Andy Harris. All rights reserved.
//

import UIKit

class ImagesTableTableViewController: UITableViewController {

    var items : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        
        getItems()
    }
    func getItems(){
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            // retreive the data from core data as an array of Item objects
            
            if let coreDataStuff = try? context.fetch(Item.fetchRequest()) as? [Item] {
                
                // Items are optional, so unwrap
                if let coreDataItems = coreDataStuff {
                    // put the images extracted from core data, into the images array, ready to be displayed in the tableView
                    // this copies the entire core data array into the array used by tableview
                    items = coreDataItems
                    tableView.reloadData()
                    
                }
            }
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // retreive the item for that row
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // get the item title and place into cell
        cell.textLabel?.text = item.title
        // get the image from the item and place into cell
        if let imageData = item.image {
        
            cell.imageView?.image =  UIImage(data: imageData)
        }
        
        return cell
    }
    
        
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
       
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let item = items[indexPath.row]
                context.delete(item)
                try? context.save()
                getItems()
            }
        }
            
    }
    

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
