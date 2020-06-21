//
//  ViewController.swift
//  ColorfulTable
//
//  Created by Алексей Макаров on 21.06.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit
import SnapKit

struct ScaleTransitionManager {
  var cardView: UIView
  var cardViewFrame: CGRect
}

class ViewController: UIViewController {
  
  let colorsArray = [
    UIColor.systemRed,
    UIColor.systemBlue,
    UIColor.systemPink,
    UIColor.systemTeal,
    UIColor.yellow
  ]
  var scaleTransitionManager: ScaleTransitionManager!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
  }
  
  private func setupTableView() {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ColorfulTableViewCell.classForCoder(), forCellReuseIdentifier: "ColorfulCell")
    tableView.separatorStyle = .none
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(tableView)
    
    tableView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.view)
    }
  }
  
  private func goToNextViewVCFrom(row: Int) {
    let secondVC = SecondViewController()
    secondVC.delegate = self
    secondVC.selectedRow = row
    secondVC.modalPresentationStyle = .overCurrentContext
    secondVC.modalTransitionStyle = .crossDissolve
    present(secondVC, animated: true, completion: nil)
  }
  
  func didGoBack() {
    UIView.animate(withDuration: Constants.duration,
                   animations: {
                    self.scaleTransitionManager.cardView.frame = self.scaleTransitionManager.cardViewFrame
                    self.scaleTransitionManager.cardView.layer.cornerRadius = Constants.cornerRadiusCell
    }) { (shrinked) in
      self.scaleTransitionManager.cardView.removeFromSuperview()
    }
  }

}

extension ViewController: SecondVCDelegate {}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return colorsArray.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ColorfulCell", for: indexPath) as! ColorfulTableViewCell
    cell.cardView.backgroundColor = colorsArray[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? ColorfulTableViewCell else { return }
    let cardViewFrame = cell.cardView.superview?.convert(cell.cardView.frame, to: nil)
    let copyOfCardView = UIView(frame: cardViewFrame!)
    copyOfCardView.layer.cornerRadius = Constants.cornerRadiusCell
    copyOfCardView.backgroundColor = colorsArray[indexPath.row]
    view.addSubview(copyOfCardView)
    
    scaleTransitionManager = ScaleTransitionManager(cardView: copyOfCardView, cardViewFrame: cardViewFrame!)
    
    // animation
    UIView.animate(withDuration: Constants.duration,
                   animations: {
      copyOfCardView.layer.cornerRadius = 0
      copyOfCardView.frame = self.view.frame
    }) { (expanded) in
      self.goToNextViewVCFrom(row: indexPath.row)
    }
  }
  
}

