//
//  ResultViewController.swift
//  Unit3_Project
//
//  Created by Kazunobu Someya on 2020-12-29.
//

import UIKit

class ResultViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        title = "Result"
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(returnToIntroduction(_:)))
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    @objc func returnToIntroduction(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
