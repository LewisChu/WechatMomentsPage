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
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
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
        // load datas
        self.interactor?.obtainInforBusiness()
        // observer  keyboard
        NotificationCenter.default.addObserver(self, selector:#selector(keyBoardWillShow(note:)), name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyBoardWillHide(note:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupUI() {
        self.headerView.frame = CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.HeaderViewHeight)
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = UIView()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.tableView.mj_header = header
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView.mj_footer = footer
        footer.setTitle("", for: .idle)
        
        
        self.activityView.color = UIColor.red
        self.activityView.hidesWhenStopped = true
        
        self.commentView.frame = CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: 40)
        self.commentView.isHidden = true
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
        print(btn.tag)
        self.commentView.commentTextField.becomeFirstResponder()
        self.commentView.sendBtn.tag = btn.tag - 2000
        self.commentView.sendBtn.addTarget(self, action: #selector(sendComment(sender:)), for:.touchUpInside)
    }
    
    //click send for comment
    @objc func sendComment(sender: UIButton)  {
        
        print(sender.tag)
        let textContent = self.commentView.commentTextField.text?.trimmingCharacters(in: .whitespaces)
        self.commentView.commentTextField.resignFirstResponder()
        self.commentView.isHidden = true
        if (textContent?.count)! > 0{
            
//            let tweetsInfo: TweetsForm =  self.tableViewDatas[sender.tag]
//            let dic = ["content": textContent ?? "","sender" : ["username": tweetsInfo.sender?.username,"nick": tweetsInfo.sender?.nick,"avatar": tweetsInfo.sender?.avatar]] as [String : Any]
//            do{
//                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
//                let com = try DecodeModels.shared.JSONModel(Comments.self, jsonData)
//
//                if let comments = tweetsInfo.comments{
//                    var tempComments = comments
//                    tempComments.append(com)
//                    tweetsInfo.comments = tempComments
//                }else{
//                    tweetsInfo.comments = [com]
//                }
//                self.tableViewDatas[sender.tag] = tweetsInfo
//                self.totaltableViewDatas[sender.tag] = tweetsInfo
//                let indexPath = IndexPath(row: sender.tag, section: 0)
//                self.tabView.reloadRows(at: [indexPath], with: .automatic)
//            }catch{
//
//            }
        }
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.commentView.commentTextField.resignFirstResponder()
            self.commentView.isHidden = true
        }
        sender.cancelsTouchesInView = false
    }
    
    @objc func keyBoardWillShow(note:NSNotification) {
        let userInfo  = note.userInfo! as NSDictionary
        let keyBoardBounds = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = keyBoardBounds.size.height
        let commentY = Constant.ScreenHeight - deltaY - 40
        var frame = self.commentView.frame
        frame.origin.y = commentY
        self.commentView.frame = frame
        self.commentView.isHidden = false
        self.commentView.commentTextField.text = ""
    }
    
    @objc func keyBoardWillHide(note:NSNotification) {
        self.commentView.isHidden = true
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
        
    }
    
    func getTweetsFromSuccess(_ tweetsForms: [TweetsForm]) {
        print(tweetsForms.count)
        self.tableViewDatas = tweetsForms
        self.tableView.reloadData()
    }
    
    func getTweetsFromFailure() {
        
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
         cell?.commentBtn.tag = 2000 + indexPath.row
         cell?.commentBtn.addTarget(self, action: #selector(commentsClick), for: .touchUpInside)
         cell?.setDatas(tweetsForm)
        cell?.selectionStyle = .none
         return cell!
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
         var nickHei = CGFloat(0)
         var imagesHei = CGFloat(0)
         var commentssHei = CGFloat(0)
         
         let tweetsForm = self.tableViewDatas[indexPath.row]
         if let content = tweetsForm.content {
            nickHei = ObtainHeight.shared.getHeightViaWidth(15, Constant.ScreenWidth - 80, content)
         }
         if let tempImages = tweetsForm.images{
             var imgUrlArray: [String] = []
             for i in 0..<tempImages.count{
                 if let imgUrl = tempImages[i].url{
                     imgUrlArray.append(imgUrl)
                 }
             }
             if imgUrlArray.count>=1{
                 if imgUrlArray.count == 1{
                     imagesHei = (Constant.ScreenWidth - 120)*2/3
                 }else if  imgUrlArray.count < 4{
                     imagesHei = (Constant.ScreenWidth - 120)/3
                 }else if imgUrlArray.count < 7 {
                     imagesHei = (Constant.ScreenWidth - 120)*2/3 + 10
                 }else {
                     imagesHei = (Constant.ScreenWidth - 120) + 20
                 }
             }
         }
         
         if let comments = tweetsForm.comments{
             var commentsHeight = CGFloat(0)
             for comment in comments {
                 var nameStr = ""
                 var commentsContentStr = ""
                 var commentStr = ""
                 if let sender = comment.sender,let commentsNick = sender.nick{
                     nameStr = commentsNick + "："
                 }
                 if let commentsContent = comment.content{
                     commentsContentStr = commentsContent
                 }
                 commentStr = nameStr + commentsContentStr
                 let tempCommentHeight = ObtainHeight.shared.getHeightViaWidth(13, Constant.ScreenWidth - 80 - 16, commentStr)
                 commentsHeight += tempCommentHeight + 4
             }
             commentssHei = commentsHeight
         }
         return 16 + 21 + 8 + nickHei + 8 + imagesHei + 30 + commentssHei + 16
     }
     
   
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
     }
    
}
