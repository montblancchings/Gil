//
//  SearchViewController.swift
//  gil
//
//  Created by HyungSoo Song on 2021/03/14.
//

import UIKit
import TMapSDK

/**
 장소 검색 이후, 검색된 결과를 선택하여, 이벤트를 생성하는 ViewController.
 - Date: 20210314
 */
class SearchViewController: UIViewController{
    /**
     입력 상태
     - Date: 20210314
     */
    enum SearchStatus{
        case none
        case editting
        case done
    }
    var editStatus: SearchStatus = .none {
        didSet{
            switch editStatus{
            case .done:
                UIView.animate(withDuration: 0.5) {
                    self.searchTextFieldTopConstraint.constant = 350
                    self.view.layoutIfNeeded()
                }
                break
            case .editting:
                UIView.animate(withDuration: 0.5) {
                    self.searchTextFieldTopConstraint.constant = 50
                    self.view.layoutIfNeeded()
                }
                break
            case .none:
                UIView.animate(withDuration: 0.5) {
                    self.searchTextFieldTopConstraint.constant = 350
                    self.view.layoutIfNeeded()
                }
                break
            }
        }
    }
    
    
    @IBOutlet var tableViewBottomConstraint: NSLayoutConstraint!
    /**
     Search Input Text Field top Constraint
     */
    @IBOutlet var searchTextFieldTopConstraint: NSLayoutConstraint!
    /**
     Search Input text Field
     */
    @IBOutlet weak var searchTextField: UITextField!
    /**
     Search Result TableView
     */
    @IBOutlet weak var searchResultTableView: UITableView!
    
    private var searchResultKeywords: [String] = [] {
        didSet{
            DispatchQueue.main.async {
                self.searchResultTableView.reloadData()
            }
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardObserver()
        
        searchTextField.delegate = self
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    private func addKeyboardObserver(){
        /**
         class let keyboardDidChangeFrameNotification: NSNotification.Name
         Posted immediately after a change in the keyboard’s frame.
         class let keyboardDidHideNotification: NSNotification.Name
         Posted immediately after the dismissal of the keyboard.
         class let keyboardDidShowNotification: NSNotification.Name
         Posted immediately after the display of the keyboard.
         class let keyboardWillChangeFrameNotification: NSNotification.Name
         Posted immediately prior to a change in the keyboard’s frame.
         class let keyboardWillHideNotification: NSNotification.Name
         Posted immediately prior to the dismissal of the keyboard.
         class let keyboardWillShowNotification: NSNotification.Name
         Posted immediately prior to the display of the keyboard.
         */
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShow), name: SearchViewController.keyboardWillShowNotification, object: nil)
    }
    
    @objc func willShow(_ sender:Notification){
        self.editStatus = .editting
        
        guard let userinfo = sender.userInfo, let rect = userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        
        
        self.tableViewBottomConstraint.constant = rect.height
        self.view.layoutIfNeeded()
    }
    
    @IBAction func textFieldEditting(_ sender: Any) {
        let manager = TMapManager()
        guard let text = self.searchTextField.text else {return}
        manager.requestAutoComplete(keyword: text) { (result) in
            let result = result ?? []
            self.searchResultKeywords = result
        }
    }
}

extension SearchViewController: UITextFieldDelegate{
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultKeywords.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = self.searchResultKeywords[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(searchResult)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(self.searchResultKeywords[indexPath.row])")
        
        let manager = TMapManager()
        manager.requestPathData()
    }
}
