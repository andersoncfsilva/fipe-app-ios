//
//  ViewController.swift
//  Fipe
//
//  Created by Anderson Costa Fernandes Silva on 22/08/17.
//  Copyright © 2017 Anderson Costa Fernandes Silva. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    var data : DataVehicle? = nil
    var brandId: String? = nil
    var vehicleId: String? = nil
    var modelId: String? = nil
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbGasType: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if
            let brandId = self.brandId ,
            let vehicleId = self.vehicleId,
            let modelId = self.modelId
        {
                
            let url = "https://fipeapi.appspot.com/api/1/carros/veiculo/\(brandId)/\(vehicleId)/\(modelId).json"
            RestAPI().fetch(
                url: url,
                onComplete: { (result: DataVehicle) in
                    self.data = result
                    DispatchQueue.main.async {
                        if
                            let name = self.data?.name,
                            let price = self.data?.preco,
                            let gasType = self.data?.combustivel,
                            let year = self.data?.ano_modelo
                        {
                            
                            self.lbName.text = name
                            self.lbYear.text = year
                            self.lbPrice.text = price
                            self.lbGasType.text = gasType
                        }
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


}

