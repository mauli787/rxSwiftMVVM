//
//  ViewController.swift
//  rxDemoWithMVVM
//
//  Created by Apple on 17/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewBindings()
        self.setupSubscription()
    }
    
    func setupViewBindings(){
        viewModel.dataSource.bind(to: self.tblView.rx.items) { (tableView,row,element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(element.title) @ row \(row)"
            return cell
        }
        .disposed(by: self.disposeBag)
    }
    
    func setupSubscription(){
       callAPI(withURL: "https://jsonplaceholder.typicode.com/posts")
    }
    public func callAPI(withURL:String){
        self.viewModel.callAPIFromViewModel(withURLString: withURL)
    }

}

