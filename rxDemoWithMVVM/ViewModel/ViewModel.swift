//
//  ViewModel.swift
//  rxDemoWithMVVM
//
//  Created by Apple on 17/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {
    
    let dataSource : BehaviorRelay<[ItemModel]> = BehaviorRelay(value: [])
    var error : Error?
    let disposeBag = DisposeBag()
    
    
    public func callAPIFromViewModel(withURLString:String){
        
        let disposableBag = NetworkClient.init().callAPIFromApiHandler(withUrlString: withURLString).subscribe(onNext:{ (data) in
            let jsonDecoder = JSONDecoder.init()
            do{
                let model = try jsonDecoder.decode([ItemModel].self, from: data!)
                self.dataSource.accept(model)
            }catch{
                self.error = error
            }
        }, onError: { (error) in
            self.error = error
        },onCompleted: { }){
            print("Dispose")
        }
        disposableBag.disposed(by: disposeBag)
    }
}
