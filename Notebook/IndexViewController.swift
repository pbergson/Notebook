//
//  IndexViewController.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/16/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var appNavigationDelegate: AppNavigationDelegate?
    
    var viewModel: IndexViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        appNavigationDelegate?.showAddNote()
    }
}

extension IndexViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.indexCell),
            let note = viewModel.note(for: indexPath) else {
            assertionFailure("can't dequeue indexCell")
            return UITableViewCell()
        }
        
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.author
        return cell
    }
}

extension IndexViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

