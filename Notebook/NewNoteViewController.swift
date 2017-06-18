//
//  NewNoteViewController.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/17/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit
import RxSwift

class NewNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    var viewModel: NewNoteViewModel? {
        didSet {
            bindIfReady(viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindIfReady(viewModel: viewModel)
    }
    
    func bindIfReady(viewModel: NewNoteViewModel?) {

        guard let viewModel = viewModel,
        isViewLoaded else {
            return
        }
        
        titleTextField.rx.text
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
        
        bodyTextField.rx.text
            .bind(to: viewModel.bodyText)
            .disposed(by: disposeBag)
    }
}
