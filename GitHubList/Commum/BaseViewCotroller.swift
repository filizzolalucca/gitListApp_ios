//
//  BaseViewCotroller.swift
//  GitHubList
//
//  Created by Lucca Filizzola on 14/06/21.
//

import UIKit

import UIKit

class BaseViewController: UIViewController {
  
  // MARK: - Class propertiesb
  
  private enum Strings {
    static let close = "FECHAR   "
    static let goBack = "   VOLTAR"
    static let nameApp = "GihHubList"
  }
  
  // MARK: - Public properties
  
  private var activityIndicator: UIActivityIndicatorView!
  private var viewActivityIndicator: UIView!
  private var toast: ToastView!
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    self.view.backgroundColor = .clear
    self.setupActivityIndicatorView()
    self.setupToast()
    self.tabBarController?.delegate = self
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.refreshViewsFrame(self.viewActivityIndicator)
    self.activityIndicator.center = self.viewActivityIndicator.center
    self.viewActivityIndicator.layoutSubviews()
    
    let color = UIColor .colorBlack_222222.withAlphaComponent(0.2)
    self.navigationController?.setStatusBar(backgroundColor: color)
    self.navigationController?.navigationBar.backgroundColor = color
  }
  
  // MARK: - Class methods
  
  private func setupToast() {
    self.toast = ToastView.instanceFromNib()
    self.toast.setupUI()
  }
  
  private func setupActivityIndicatorView() {
    if #available(iOS 13.0, *) {
      self.activityIndicator = UIActivityIndicatorView(style: .large)
    } else {
      self.activityIndicator = UIActivityIndicatorView(style: .white)
    }
    self.activityIndicator.color = #colorLiteral(red: 1, green: 0.7294117647, blue: 0, alpha: 1)
    self.viewActivityIndicator = UIView(frame: self.view.frame)
    self.viewActivityIndicator.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1).withAlphaComponent(0.8)
    self.viewActivityIndicator.addSubview(self.activityIndicator)
    self.activityIndicator.hidesWhenStopped = true
  }
  
  @objc
  private func openMenuModule() {
    let vc = MenuViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc
  private func dismissModule() {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Public methods
  
  func showLoading(_ status: Bool) {
    DispatchQueue.main.async {
      UIView.transition(with: self.view,
                        duration: 0.5,
                        options: UIView.AnimationOptions.transitionCrossDissolve,
                        animations: {
                          if status {
                            self.view.addSubview(self.viewActivityIndicator)
                            self.activityIndicator.startAnimating()
                          } else {
                            self.viewActivityIndicator.removeFromSuperview()
                            self.activityIndicator.stopAnimating()
                          }},
                        completion: nil)
      
    }
  }
  
  func addMenuNavigationButton() {
    let image = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
    let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(openMenuModule))
    self.navigationItem.rightBarButtonItem = item
    self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0, alpha: 1)
  }
  
  func addCloseNavigationButton() {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "fechar"), for: .normal)
    let attributedTitle = NSAttributedString(string: Strings.close, attributes: [NSAttributedString.Key.font : UIFont.getFont(type: .roboto, style: .bold, size: 14)])
    button.setTitleColor(.white, for: .normal)
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(dismissModule), for: .touchUpInside)
    button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    self.navigationItem.rightBarButtonItem?.tintColor = .white
    self.navigationItem.hidesBackButton = true
    self.title = ""
  }
  
  func setupBackButton() {
    let button2 = UIButton(type: .custom)
    button2.setImage(UIImage(named: "arrow_ios_left"), for: .normal)
    let attributedTitle = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : UIFont.getFont(type: .roboto, style: .bold, size: 14), NSAttributedString.Key.foregroundColor : UIColor.white])
    button2.setAttributedTitle(attributedTitle, for: .normal)
    button2.addTarget(self, action: #selector(dismissModule), for: .touchUpInside)
    button2.backgroundColor = .clear
    button2.contentEdgeInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button2)
    self.setJeepNationNavigationTitle()
    self.setupTranslucentNavigationBar()
    self.tabBarController?.tabBar.isHidden = true
  }
  
  func setupHomeNavigation() {
    self.setupTranslucentNavigationBar()
    self.tabBarController?.tabBar.isHidden = false
    self.navigationItem.hidesBackButton = true
    self.navigationController?.setNavigationBarHidden(false, animated: .init())
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    var offset = scrollView.contentOffset.y / 150
    let color = UIColor .colorBlack_222222.withAlphaComponent(0.2)
    self.navigationController?.setStatusBar(backgroundColor: color)
    self.navigationController?.navigationBar.backgroundColor = color
    if offset > 1 {
      offset = 1
      let color = UIColor .colorBlack_222222.withAlphaComponent(offset)
      self.navigationController?.setStatusBar(backgroundColor: color)
      self.navigationController?.navigationBar.backgroundColor = color
    } else if offset > 0.2 {
      let color = UIColor .colorBlack_222222.withAlphaComponent(offset)
      self.navigationController?.setStatusBar(backgroundColor: color)
      self.navigationController?.navigationBar.backgroundColor = color
    }
  }
  
  func setJeepNationNavigationTitle() {
    self.title = Strings.nameApp.uppercased()
  }
  
  func removeNavigationBackButton() {
    self.navigationItem.leftBarButtonItems = []
    self.navigationItem.hidesBackButton = true
    self.navigationController?.setNavigationBarHidden(true, animated: .init())
  }
  
  func setupTranslucentNavigationBar() {
    self.navigationController?.navigationBar.isHidden = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.view.backgroundColor = .clear
  }
  
  func setupBackgroundImage() {
    if let navController = self.navigationController {
      let image = UIImage(named: "appbackground")
      let imageView = UIImageView(frame: navController.view.frame)
      imageView.image = image
      self.view.insertSubview(imageView, at: 0)
    }
  }
  
  // MARK: - Change FirstResponder TextField
  
  func nextResponderTextField(index: Int) {
    var thereIsNext = false
    let ind = index+1
    for i in ind..<ind+10 {
      for view in self.view.subviews {
        if let view_ = view.viewWithTag(i) {
          thereIsNext = true
          if view_.isUserInteractionEnabled == false {
            self.nextResponderTextField(index: i)
          } else {
            view_.becomeFirstResponder()
            return
          }
          break
        }
      }
    }
    if !thereIsNext {
      self.view.endEditing(true)
    }
  }
  
  func previousResponderTextField(index: Int) {
    var thereIsPrevious = false
    let ind = index-1
    for i in (-1..<ind).reversed() {
      for view in self.view.subviews {
        if let view_ = view.viewWithTag(i) {
          thereIsPrevious = true
          if view_.isUserInteractionEnabled == false {
            self.previousResponderTextField(index: i)
          } else {
            view_.becomeFirstResponder()
            return
          }
          break
        }
      }
    }
    if !thereIsPrevious {
      self.view.endEditing(true)
    }
  }
  
  // MARK: - Show alerts/views
  
  func showToast(text: String, time: Double = 2) {
    let x = self.view.frame.width/2
    let y = self.view.frame.maxY + toast.frame.height + 10
    self.toast.setupContent(text: text)
    self.toast.center = CGPoint(x: x, y: y)
    
    var newFrame = self.toast.frame
    newFrame.size.width = self.view.frame.width*0.8
    self.toast.frame = newFrame
    self.toast.layoutIfNeeded()
    
    let toastWidth = self.toast.labelTitle.frame.width
    let labelMaximumSize = CGSize(width: toastWidth, height: 9999)
    let labelSize = self.toast.labelTitle.sizeThatFits(labelMaximumSize)
    newFrame.size.height = labelSize.height + 30
    self.toast.frame = newFrame
    self.toast.layoutIfNeeded()
    
    self.toast.center = CGPoint(x: x, y: y)
    self.view.addSubview(toast)
    
    UIView.animate(withDuration: 1.0, animations: {
      let newY = self.view.frame.height - self.toast.frame.height - 10
      self.toast.center = CGPoint(x: x, y: newY)
    }) { _ in
      DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        UIView.animate(withDuration: 1.0, animations: {
          self.toast.center = CGPoint(x: x, y: y)
        }, completion: { (_) in
          self.toast.removeFromSuperview()
        })
      }
    }
  }
  
  func showPasswordPopUp() {
    let passwordPopUp = PasswordPopUp()
    self.showPopUp(passwordPopUp)
  }
}

extension BaseViewController: UITextFieldDelegate {
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.resignFirstResponder()
    return true
  }
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return true
  }
}

extension BaseViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    let tabBarIndex = tabBarController.selectedIndex
    switch tabBarIndex {
    case 0:
      FirebaseTagManager.sendEvent(tag: FirebaseTagName.tagNavExploreBtn)
    case 1:
      FirebaseTagManager.sendEvent(tag: FirebaseTagName.tagNavProfileBtn)
    default:
      break
    }
  }
}

extension UINavigationController {
  func setStatusBar(backgroundColor: UIColor) {
    let statusBarFrame: CGRect
    if #available(iOS 13.0, *) {
      statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
    } else {
      statusBarFrame = UIApplication.shared.statusBarFrame
    }
    let statusBarView = UIView(frame: statusBarFrame)
    statusBarView.backgroundColor = backgroundColor
    view.addSubview(statusBarView)
  }
}

