//
//  ListVC.swift
//  Code Challenge
//
//  Created by Rahul Patil on 20/10/20.
//

import UIKit
import SnapKit

/// Following operations performed by the class.
/// - Display list in *UICollectionView*.
/// - Update UI of *UICollectionView* for different devices (iPhone and iPad)
/// - Show *UIActivityIndicatorView* while fetching and displaying data.
/// - Show an alert when data is not available.
class ListVC: UIViewController {
  // MARK: Variables
  private var collectionView: UICollectionView!
  private var presenter: ListPresenterProtocol?
  private var activityIndicator = UIActivityIndicatorView()
  private var model = [ResponseModel]() {
    didSet {
      activityIndicator(animate: false)
      collectionView.reloadData()
    }
  }
  private var cellWidth: CGFloat = 0
  private var cellHeight: CGFloat = 0
  weak var listDelegate: ListDelegate?
  
  // MARK: Initialization
  convenience init(_listDelegate: ListDelegate) {
    self.init()
    listDelegate = _listDelegate
  }
  
  // MARK: Lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView.collectionViewLayout = getCollectionViewLayout()
  }
  
  override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
    collectionView.collectionViewLayout = getCollectionViewLayout()
  }
  
  // MARK: Custom methods
  private func prepareUI() {
    title = "List"
    prepareBarButtons()
    let flowLayout = getCollectionViewLayout()
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.dataSource = self
    collectionView.delegate = self
    setViwsConstraints()
    collectionView.register(DetailsCell.self, forCellWithReuseIdentifier: "DetailsCell")
    presenter = ListPresenter(_view: self)
    refreshTapped()
  }
  
  
  /// It returns UICollectionViewFlowLayout for iPad and iPhone
  /// - Returns: UICollectionViewFlowLayout
  private func getCollectionViewLayout() -> UICollectionViewFlowLayout {
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
      // Cell width and height for iPhone
      cellWidth = (view.bounds.width / 2) - 10
      cellHeight = (view.bounds.width / 2) - 10
      
    case .pad:
      // Cell width and height for iPad
      cellWidth = (view.bounds.width / 1) - 10
      cellHeight = cellWidth - 50
      
    default: break
    }
    
    // Prepare FlowLayout
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: 10, height: 10)
    flowLayout.scrollDirection = .vertical
    flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    flowLayout.minimumInteritemSpacing = 4
    flowLayout.minimumLineSpacing = 4
    return flowLayout
  }
  
  /// Prepares the NavigationBar and button
  private func prepareBarButtons() {
    let refreshButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshTapped))
    navigationItem.rightBarButtonItem = refreshButton
  }
  
  /// Refresh all data.
  /// - Starts Activity Indicator
  /// - It deletes existing data from Realm.
  /// - It clears image cache.
  /// - Fetch new data.
  /// - If device is iPad then updates DetailVC
  @objc private func refreshTapped() {
    activityIndicator(animate: true)
    RealmUtils.shared.removeAll()
    imagesCache.removeAllObjects()
    presenter?.getAPIData()
    if let delegate = listDelegate {
      delegate.selected(model: ResponseModel())
    }
  }
  
  /// It prepares constraints for UI
  private func setViwsConstraints() {
    view.addSubview(collectionView)
    collectionView.backgroundColor = .lightGray
    collectionView.snp.makeConstraints { (maker) in
      maker.leading.trailing.topMargin.bottomMargin.equalToSuperview()
    }
    
    view.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { (maker) in
      maker.center.equalToSuperview()
    }
  }
  
  /// It handels Animation and Visibility
  /// - Parameter animate: Bool
  private func activityIndicator(animate: Bool) {
    if animate {
      activityIndicator.isHidden = false
      activityIndicator.startAnimating()
    } else {
      activityIndicator.isHidden = false
      activityIndicator.stopAnimating()
    }
  }
}

// MARK: CollectionView Delegate and DataSource
extension ListVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as? DetailsCell
    cell?.set(data: model[indexPath.item])
    return cell!
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let delegate = listDelegate {
      delegate.selected(model: model[indexPath.item])
    } else {
      let vc = DetailsVC(data: model[indexPath.item])
      let nc = UINavigationController(rootViewController: vc)
      nc.modalPresentationStyle = .fullScreen
      present(nc, animated: true)
    }
  }
}

// MARK: Presenter Protocol extension.
extension ListVC: ListViewProtocol {
  func showAlert(title: String, message: String) {
    activityIndicator(animate: false)
    update(data: [])
    AlertUtils.shared.showAlert(with: title, message: message, target: self)
  }
  
  func update(data: [ResponseModel]) {
    model = data
  }
}
