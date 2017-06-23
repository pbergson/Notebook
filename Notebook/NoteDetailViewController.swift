//
//  NoteDetailViewController.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/23/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var bodyTextLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: IndexViewModel? {
        didSet {
            bindIfReady(viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindIfReady(viewModel: viewModel)
    }
    
    func bindIfReady(viewModel: IndexViewModel?) {
        
        guard let viewModel = viewModel, isViewLoaded else {
            return
        }
        
        if let noteDetail = viewModel.noteDetail {
            populate(with: noteDetail)
        }
    }
    
    private func populate(with note: NoteDetail) {
        
        titleLabel.text = note.title
        dateLabel.text = note.dateString
        bodyTextLabel.text = note.body
        locationLabel.text = note.locationName
        imageView.image = note.image
    }
}
