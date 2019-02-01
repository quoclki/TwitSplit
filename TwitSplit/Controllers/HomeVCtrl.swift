//
//  HomeVCtrl.swift
//  TwitSplit
//
//  Created by Lu Kien Quoc on 2/1/19.
//  Copyright © 2019 Lu Kien Quoc. All rights reserved.
//

import UIKit

class HomeVCtrl: UIViewController {

    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var tbvInput: UITableView!
    
    private var lstData: [MessageData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configTableView()
        eventListener()
    }

    func configTableView() {
        tbvInput.register(UINib(nibName: String(describing: HomeCell.self), bundle: nil), forCellReuseIdentifier: cellID)
        tbvInput.dataSource = self
        tbvInput.delegate = self
        tbvInput.estimatedRowHeight = 44
        tbvInput.separatorStyle = .none
    }

    private func eventListener() {
        // add tap gesture to viewInput
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewInputDidTap(gesture:)))
        txtInput.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func viewInputDidTap(gesture: UITapGestureRecognizer) {
        // config and present Input View Controller
        let inputVCtrl = InputVCtrl()
        inputVCtrl.handleDone = didInput
        present(inputVCtrl, animated: true, completion: nil)

    }

    func didInput(messages: [String]) {
        // insert new data to lstData
        messages.reversed().forEach {
            lstData.insert(MessageData($0), at: 0)
        }
        
        // reload tableView to show new data
        reloadTableView(numOfInsert: messages.count)
    }

    private func reloadTableView(numOfInsert: Int) {
        // prepare list indexPaths to insert
        let lstIP = (0..<numOfInsert).map {IndexPath(row: $0, section: 0)}
        
        // insertRows with animation
        tbvInput.beginUpdates()
        tbvInput.insertRows(at: lstIP, with: UITableViewRowAnimation.automatic)
        tbvInput.endUpdates()
        
        // scroll to top of table view to visible the newest data
        tbvInput.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
    }

}

extension HomeVCtrl: UITableViewDataSource, UITableViewDelegate {
    private var cellID: String {
        return "CellID"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? HomeCell {
            cell.updateCell(data: lstData[indexPath.row])
            return cell
        }
        
        return HomeCell(style: .default, reuseIdentifier: cellID)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}



