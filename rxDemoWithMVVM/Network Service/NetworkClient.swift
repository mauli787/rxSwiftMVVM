//
//  NetworkClient.swift
//  rxDemoWithMVVM
//
//  Created by Apple on 17/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import RxSwift

class NetworkClient{
    
    public func callAPIFromApiHandler(withUrlString : String)
        -> Observable<Data?> {
            
            Observable<Data?>.create { observer  in
                
                URLSession.shared.dataTask(with: URL(string: withUrlString)!) { (data, response, error) in
                    observer.onNext(data)
                    if error != nil {
                        observer.onError(error!)
                    }
                    observer.onCompleted()
                    
                }.resume()
                let disposable = Disposables.create()
                return disposable
                
            }
    }
}

