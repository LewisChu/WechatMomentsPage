//
//  WeChatMomentsViewController.swift
//  WeChatMomentsPage
//
//  Created by BeiBeiLewis ZHU on 2020/12/17.
//  Copyright © 2020 BeiBeiLewis ZHU. All rights reserved.
//

import UIKit
import MJRefresh

// Presenter output
protocol WeChatMomentsDisplayLogic: class {
    func getUserInfoSuccess(_ userInfo: UserInfo)
    func getUserInfoFailure()
    
    func getTweetsFromSuccess(_ tweetsForms: [TweetsForm])
    func getTweetsFromFailure()
}

class WeChatMomentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // tableView header
    lazy var headerView = HeaderView()
    lazy var commentView = CommentView()
    
    // content for tableView display
    lazy var tableViewDatas: [TweetsForm] = []
    // refresh header
    lazy var header = MJRefreshNormalHeader()
    // refresh footer
    lazy var footer = MJRefreshAutoNormalFooter()
    // display page
    lazy var page: Int = 1
    
    // MARK: VIP Circle Parameter start
    var interactor: WeChatMomentsBusinessLogic?
    var router: WeChatMomentsRoutingLogic?
    // MARK: VIP Circle Parameter end
    
    struct ControllerConstant {
        static let DefaultTag = 2000
    }
    
    static let CellReuseIdentifier = "WeChatMomentsCellID"
    private func setup() {
        let viewController = self
        let presenter = WeChatMomentsPresenter()
        let interactor = WeChatMomentsInteractor()
        let router = WeChatMomentsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // observer  keyboard
        NotificationCenter.default.addObserver(self, selector:#selector(keyBoardWillShow(note:)), name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyBoardWillHide(note:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // load datas
        ActivityView.shared.start()
        self.interactor?.obtainInforBusiness()
    }

    // setup tableview
    func setupUI() {
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = UIView()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.tableView.mj_header = header
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView.mj_footer = footer
        footer.setTitle("", for: .idle)
        self.commentView.isHidden = true
        self.commentView.delegate = self
        self.view.addSubview(self.commentView)
        self.view.bringSubviewToFront(self.commentView)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    }
    
    
    
    //drag down for refresh
    @objc func headerRefresh()  {
        self.page = 1
        obtainData(self.page)
        self.tableView.reloadData()
        self.tableView.mj_header.endRefreshing()
        footer.resetNoMoreData()
    }
    
    //drag up for downloading
    @objc func footerRefresh() {
        if tableViewDatas.count ==  UserDefaultsUtils().obtainTotalModels()?.count{
            self.tableView.reloadData()
            footer.endRefreshingWithNoMoreData()
            return
        }
        self.page += 1
        obtainData(self.page)
        self.tableView.reloadData()
        self.tableView.mj_footer.endRefreshing()
        
    }
    
    func obtainData(_ page: Int) {
        if let models = UserDefaultsUtils().obtainModels(self.page) {
            tableViewDatas = models
        } else {
            self.interactor?.obtainInforBusiness()
        }
    }
    
    //click comment button
    @objc func commentsClick(btn: UIButton) {
        self.commentView.commentTextField.becomeFirstResponder()
        self.commentView.sendButton.tag = btn.tag - 2000
        self.commentView.sendButton.addTarget(self, action: #selector(sendEvent(sender:)), for: .touchUpInside)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.commentView.commentTextField.resignFirstResponder()
            self.commentView.isHidden = true
        }
        sender.cancelsTouchesInView = false
    }
    
    @objc func sendEvent(sender: UIButton) {
        print(sender.tag)
    }
    
    @objc func keyBoardWillShow(note:NSNotification) {
        let userInfo  = note.userInfo! as NSDictionary
        let keyboardBounds = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardBounds.size.height
        let commentOriginY = Constant.ScreenHeight - keyboardHeight - self.commentView.frame.size.height
        var frame = self.commentView.frame
        frame.origin.y = commentOriginY
        self.commentView.frame = frame
        self.commentView.isHidden = false
        self.commentView.commentTextField.text = ""
    }
    
    @objc func keyBoardWillHide(note:NSNotification) {
        self.commentView.isHidden = true
    }
}

extension WeChatMomentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDatas.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "staticCellReuseIdentifier - \(indexPath.description)"
        var cell: WeChatMomentsCell? = (tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? WeChatMomentsCell)
        if cell == nil {
            cell  = Bundle.main.loadNibNamed("WeChatMomentsCell", owner: self, options: nil)?.last as? WeChatMomentsCell
        }
        let tweetsForm = self.tableViewDatas[indexPath.row]
        cell?.commentBtn.tag = ControllerConstant.DefaultTag + indexPath.row
        cell?.commentBtn.addTarget(self, action: #selector(commentsClick), for: .touchUpInside)
        cell?.setDatas(tweetsForm)
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WeChatMomentsCell.obtainHeight(self.tableViewDatas[indexPath.row])
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension WeChatMomentsViewController: WeChatMomentsDisplayLogic {
    func getUserInfoSuccess(_ userInfo: UserInfo) {
        DownloadAndCacheImage.shard.obtainImage(userInfo.avatar!) { (data, url) in
            if let imageData = data{
                self.headerView.avatarImage.image = UIImage(data: imageData)
            }
        }
        DownloadAndCacheImage.shard.obtainImage(userInfo.profileimage!) { (data, url) in
            if let imageData = data{
                self.headerView.profileimage.image = UIImage(data: imageData)
            }
        }
        self.headerView.usernameLabel.text = userInfo.username
    }
    
    func getUserInfoFailure() {
        AlertView.shard.show("geting data is failure!, please try drag-down to refresh!")
    }
    
    func getTweetsFromSuccess(_ tweetsForms: [TweetsForm]) {
        self.tableViewDatas = tweetsForms
        self.tableView.reloadData()
    }
    
    func getTweetsFromFailure() {
        AlertView.shard.show("geting data is failure!, please try drag-down to refresh!")
    }
}


extension WeChatMomentsViewController: ClickSendDelegate {
    func clickSendButton() {
        self.commentView.commentTextField.resignFirstResponder()
        AlertView.shard.show("clicked send!")
    }
}
