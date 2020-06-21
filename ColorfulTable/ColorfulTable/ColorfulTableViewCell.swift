//
//  ColorfulTableViewCell.swift
//  ColorfulTable
//
//  Created by Алексей Макаров on 22.06.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit
import SnapKit

class ColorfulTableViewCell: UITableViewCell {
  
  var cardView: UIView!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCardView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Functions
  
  private func setupCardView() {
    self.backgroundColor = .clear
    self.selectionStyle = .none
    
    let cardView: UIView = UIView()
    cardView.backgroundColor = .orange
    cardView.layer.cornerRadius = Constants.cornerRadiusCell
    cardView.translatesAutoresizingMaskIntoConstraints = false
    self.cardView = cardView
    
    addSubview(cardView)
    
    cardView.snp_makeConstraints { (make) in
      make.top.equalTo(self).offset(5)
      make.leading.equalTo(self).offset(10)
      make.trailing.equalTo(self).offset(-10)
      make.bottom.equalTo(self).offset(-5)
    }
     
  }
  
}
