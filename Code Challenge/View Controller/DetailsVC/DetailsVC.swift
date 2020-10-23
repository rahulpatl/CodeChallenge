//
//  DetailsVC.swift
//  Code Challenge
//
//  Created by Rahul Patil on 22/10/20.
//

import UIKit

class DetailsVC: UIViewController {
  // MARK: Variables
  private var imageView = CellImageView()
  private var textView = UITextView()
  private var model: ResponseModel?
  
  // MARK: Initialization
  convenience init(data: ResponseModel) {
    self.init()
    model = data
  }
  
  // MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareUI()
    updateData()
  }
  
  // MARK: Custom methods
  
  /// Prepares UI of controller.
  private func prepareUI() {
    title = "Details"
    prepareBarButtons()
    view.backgroundColor = .white
    view.addSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    imageView.snp.makeConstraints { (maker) in
      maker.leading.top.equalTo(8)
      maker.trailing.bottom.equalTo(-8)
    }
    
    view.addSubview(textView)
    textView.backgroundColor = .lightGray
    textView.isEditable = false
    textView.layer.cornerRadius = 8
    textView.snp.makeConstraints { (maker) in
      maker.leading.top.equalTo(8)
      maker.trailing.bottomMargin.equalTo(-8)
    }
  }
  
  /// Prepares navigation bar button
  private func prepareBarButtons() {
    let refreshButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeTapped))
    navigationItem.leftBarButtonItem = refreshButton
  }
  
  /// Dismiss the controller.
  @objc private func closeTapped() {
    dismiss(animated: true)
  }
  
  /// It handles the visibility of the View also set the data to the respective view.
  private func updateData() {
    switch DataType(rawValue: (model?.type) ?? "") {
    case .Text:
      imageView.isHidden = true
      textView.isHidden = false
      textView.text = model?.data
      
    case .Image:
      textView.isHidden = true
      imageView.isHidden = false
      imageView.setImg(from: (model?.data) ?? "")
      
    default:
      break
    }
  }
  
  /// It helps to update data while using iPad with UISplitViewController
  /// - Parameter data: ResponseModel
  func update(data: ResponseModel) {
    textView.text = nil
    imageView.image = nil
    model = data
    updateData()
  }
}
