//
//  ServiceProvider.swift
//  ChuckNorrisFacts
//
//  Created by Lucas César  Nogueira Fonseca on 06/10/20.
//  Copyright © 2020 Lucas César  Nogueira Fonseca. All rights reserved.
//
import Foundation

struct ServiceProvider<T: Service> {
    
    private var executor: ServiceExecutor
    var listner: ((ServiceState) -> Void)?
    
    init(executor: ServiceExecutor = Executor()) {
        self.executor = executor
    }
    
    func load<U: Codable>(
        service: T,
        decodeType: U.Type,
        deliverQueue: DispatchQueue = DispatchQueue.main,
        completion: ((Result<U, CustomError>
        ) -> Void)?) {
        listner?(.request)
        executor.execute(service) { result in
            self.listner?(.response(result))
            switch result {
            case .success(let data):
                do {
                    let resp = try decodeType.decode(from: data)
                    deliverQueue.async {
                        completion?(.success(resp))
                    }
                } catch {
                    deliverQueue.async {
                        completion?(.failure(CustomError(error: error)))
                    }
                }
            case .failure(let error):
                deliverQueue.async {
                    completion?(.failure(CustomError(error: error)))
                }
            }
        }
    }
}
