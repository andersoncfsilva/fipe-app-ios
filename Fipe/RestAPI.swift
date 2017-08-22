//
//  FipeAPI.swift
//  Fipe
//
//  Created by Anderson Costa Fernandes Silva on 22/08/17.
//  Copyright © 2017 Anderson Costa Fernandes Silva. All rights reserved.
//

import UIKit

struct Brands : Codable {
    let key:String
    let id:Int
    let fipe_name:String
    let name:String
}

struct Vehicle : Codable {
    let key:String
    let id:String
    let fipe_name:String
    let name:String
}

struct Model : Codable {
    let fipe_codigo:String
    let name:String
    let key:String
    let veiculo:String
    let id:String
}

struct DataVehicle : Codable {
    let id:String
    let ano_modelo:String
    let marca:String
    let name:String
    let veiculo:String
    let preco:String
    let combustivel:String
    let referencia:String
    let fipe_codigo:String
    let key:String
}


class RestAPI: NSObject {
    
    func fetch<T: Codable>(url:String, onComplete: @escaping (T) -> Void, onError: @escaping (Error) -> Void) {
        let endpoint = url
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        guard let url = URL(string: endpoint) else { return }
        session.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                onError(error)
            } else {
                do {
                    guard let json = data else { return }
                    let brands = try JSONDecoder().decode(T.self, from: json)
                    onComplete(brands)
                } catch {
                    onError(error)
                }
            }
        }.resume()
    }

}
