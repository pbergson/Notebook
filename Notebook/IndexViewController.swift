//
//  IndexViewController.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/16/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit
import RxSwift

class IndexViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var appNavigationDelegate: AppNavigationDelegate?
    
    private var disposeBag = DisposeBag()
    
    var viewModel: IndexViewModel? {
        didSet {
            bindIfReady(viewModel: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindIfReady(viewModel: viewModel)
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func bindIfReady(viewModel: IndexViewModel?) {
        
        guard let viewModel = viewModel, isViewLoaded else {
            return
        }

        viewModel.notes.asObservable()
            .subscribe(onNext: { [tableView] _ in
                tableView?.reloadData()
            })
            .disposed(by: disposeBag)
    
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        appNavigationDelegate?.showAddNote()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.indexViewController.showDetailSegue.identifier,
            let viewController = segue.destination as? NoteDetailViewController {
            viewController.viewModel = viewModel
        }
    }
}

extension IndexViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.notes.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.indexCell),
            let note = viewModel!.note(for: indexPath) else {
            assertionFailure("can't dequeue indexCell")
            return UITableViewCell()
        }
        
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.body
        return cell
    }
}

extension IndexViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel!.showNote(at: indexPath)
    }
}

