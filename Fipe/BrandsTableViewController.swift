//
//  BrandsTableViewController.swift
//  Fipe
//
//  Created by Anderson Costa Fernandes Silva on 22/08/17.
//  Copyright © 2017 Anderson Costa Fernandes Silva. All rights reserved.
//

import UIKit

class BrandsTableViewController: UITableViewController {
    
    var brands : [Brands] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RestAPI().fetch(url: "https://fipeapi.appspot.com/api/1/carros/marcas.json",
                        onComplete: { (result: [Brands]) in
                            self.brands = result
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        },
                        onError: { (error) in
                            print(error)
                        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for: indexPath)
        cell.textLabel?.text = self.brands[indexPath.row].fipe_name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! VehiclesTableViewController
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        view.brandId = String(describing: brands[index].id)
    }

}
