//
//  ModelsTableViewController.swift
//  Fipe
//
//  Created by Anderson Costa Fernandes Silva on 22/08/17.
//  Copyright © 2017 Anderson Costa Fernandes Silva. All rights reserved.
//

import UIKit

class ModelsTableViewController: UITableViewController {

    var models : [Model] = []
    var brandId: String? = nil
    var vehicleId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let brandId = self.brandId , let vehicleId = self.vehicleId {
            let url = "https://fipeapi.appspot.com/api/1/carros/veiculo/\(brandId)/\(vehicleId).json"
            RestAPI().fetch(url: url,
                            onComplete: { (result: [Model]) in
                                self.models = result
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
        return models.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "modelCell", for: indexPath)
        cell.textLabel?.text = self.models[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let view = segue.destination as! DataViewController
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        view.modelId = String(describing: self.models[index].id)
        view.vehicleId = self.vehicleId
        view.brandId = self.brandId
        
    }

}
