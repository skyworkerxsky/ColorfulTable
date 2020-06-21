//
//  SecondViewController.swift
//  ColorfulTable
//
//  Created by Алексей Макаров on 22.06.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit

protocol SecondVCDelegate {
  func didGoBack()
}

class SecondViewController: UIViewController {
  
  // MARK: - Properties
  
  var selectedRow = 0
  var delegate: SecondVCDelegate?
  
  // MARK: - Life
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .clear
    setupLbel()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goBack))
    view.addGestureRecognizer(tapGesture)
  }
  
  // MARK: - Functions
  
  @objc func goBack(_ sender: UITapGestureRecognizer) {
    guard let delegate = delegate else { return }
    delegate.didGoBack()
    dismiss(animated: true, completion: nil)
  }
  
  private func setupLbel() {
    let label: UILabel = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 30)
    label.textColor = .white
    label.textAlignment = .center
    label.text = "Scaling \n from row \n \(selectedRow + 1)"
    label.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(label)
    
    label.snp_makeConstraints { (make) in
      make.top.equalTo(view).offset(64)
      make.leading.equalTo(view).offset(32)
      make.trailing.equalTo(view).offset(-32)
      make.centerX.equalTo(view)
    }
  }
  
}
