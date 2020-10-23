//
//  DetailsCell.swift
//  Code Challenge
//
//  Created by Rahul Patil on 21/10/20.
//

import UIKit

class DetailsCell: UICollectionViewCell {
  //MARK: Variables
  private var parentView = UIView()
  private var imageView = CellImageView()
  let imagesCache = NSCache<NSString, AnyObject>()
  private var idLabel = UILabel()
  private var idLabelView = UIView()
  
  private var dateLabel = UILabel()
  private var dateLabelView = UIView()
  private var descriptionLabel = UILabel()
  
  //MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    prepareUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Custom methods
  /// Prepares UI and constraints.
  private func prepareUI() {
    addSubview(parentView)
    parentView.backgroundColor = .gray
    parentView.layer.borderColor = UIColor.darkGray.cgColor
    parentView.layer.borderWidth = 0.5
    parentView.snp.makeConstraints { (maker) in
      maker.leading.top.equalTo(8)
      maker.bottom.trailing.equalTo(-8)
    }
    parentView.layer.cornerRadius = 8
    parentView.clipsToBounds = true
    
    parentView.addSubview(imageView)
    imageView.snp.makeConstraints { (maker) in
      maker.leading.trailing.top.bottom.equalTo(0)
    }
    imageView.contentMode = .scaleAspectFill
    
    parentView.addSubview(idLabelView)
    idLabelView.backgroundColor = UIColor(white: 1, alpha: 0.5)
    idLabelView.snp.makeConstraints { (maker) in
      maker.leading.top.equalTo(0)
      maker.trailing.equalTo(0)
    }
    
    idLabelView.addSubview(idLabel)
    idLabel.textColor = .black
    idLabel.font = .systemFont(ofSize: 12)
    idLabel.snp.makeConstraints { (maker) in
      maker.leading.top.equalTo(4)
      maker.trailing.equalTo(4)
      maker.bottom.equalTo(idLabelView)
    }
    
    parentView.addSubview(dateLabelView)
    dateLabelView.backgroundColor = UIColor(white: 1, alpha: 0.5)
    dateLabelView.snp.makeConstraints { (maker) in
      maker.leading.equalTo(0)
      maker.trailing.bottom.equalTo(0)
    }
    
    dateLabelView.addSubview(dateLabel)
    dateLabel.textAlignment = .right
    dateLabel.textColor = .black
    dateLabel.font = .systemFont(ofSize: 12)
    dateLabel.snp.makeConstraints { (maker) in
      maker.leading.equalTo(4)
      maker.trailing.bottom.equalTo(-4)
      maker.top.equalTo(dateLabelView)
    }
    
    parentView.addSubview(descriptionLabel)
    descriptionLabel.numberOfLines = 3
    descriptionLabel.textColor = .white
    descriptionLabel.textAlignment = .center
    descriptionLabel.font = .systemFont(ofSize: 12)
    descriptionLabel.snp.makeConstraints { (maker) in
      maker.leading.equalTo(4)
      maker.trailing.equalTo(-4)
      maker.top.equalTo(idLabelView)
      maker.bottom.equalTo(dateLabelView)
    }
  }
  
  /// It handles the visibility of views according the content.
  /// It also set the data to views.
  /// - Parameters:
  ///   - data: ResponseModel
  func set(data: ResponseModel) {
    idLabel.text = "ID: \(data.id ?? "NA")"
    dateLabel.text = data.date ?? "NA"
    imageView.image = nil
    descriptionLabel.text = nil
    switch DataType(rawValue: data.type ?? "") {
    case .Text:
      imageView.isHidden = true
      descriptionLabel.isHidden = false
      descriptionLabel.text = data.data ?? "NA"
      
    case .Image:
      descriptionLabel.isHidden = true
      imageView.isHidden = false
      imageView.urlString = nil
      if data.type == "image", let url = data.data {
        imageView.setImg(from: url)
      }
      
    default:
      break
    }
  }
}
