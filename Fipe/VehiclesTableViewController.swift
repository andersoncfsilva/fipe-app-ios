//
//  VehiclesTableViewController.swift
//  Fipe
//
//  Created by Anderson Costa Fernandes Silva on 22/08/17.
//  Copyright © 2017 Anderson Costa Fernandes Silva. All rights reserved.
//

import UIKit

class VehiclesTableViewController: UITableViewController {

    var vehicles : [Vehicle] = []
    var brandId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = brandId {
            let url = "https://fipeapi.appspot.com/api/1/carros/veiculos/\(id).json"
            RestAPI().fetch(url: url,
                            onComplete: { (result: [Vehicle]) in
                                self.vehicles = result
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            },
                            onError: { (error) in
                                print(error)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleCell", for: indexPath)
        cell.textLabel?.text = self.vehicles[indexPath.row].fipe_name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! ModelsTableViewController
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        view.vehicleId = String(describing: self.vehicles[index].id)
        view.brandId = self.brandId
    }

}
