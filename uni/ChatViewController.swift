import UIKit
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage

class ChatViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {


    var currentUser: User = Auth.auth().currentUser!
    
    var user2Name = "Logan"
    var user2ImgUrl = "https://firebasestorage.googleapis.com/v0/b/unimarketplace-dd3f6.appspot.com/o/Profile%20Image%2FS3UtuLPdsFQRV0yrTyr1OazjcP33?alt=media&token=15f1ab56-0d82-4e23-8994-a4ca865ffd38"
    var user2UID = "S3UtuLPdsFQRV0yrTyr1OazjcP33"
    
    private var docReference: DocumentReference?
    
    var messages: [Message] = []
    override func viewDidAppear(_ animated: Bool) {
        self.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = user2Name
        navigationItem.largeTitleDisplayMode = .never
        maintainPositionOnKeyboardFrameChanged = true
        configureMessageInputBar()
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        //createNewChat()
        loadChat()
        
    }
    
    // MARK: - Custom messages handlers
    
    func createNewChat() {
        let users = [self.currentUser.uid, self.user2UID]
         let data: [String: Any] = [
             "users":users
         ]
         
         let db = Firestore.firestore().collection("Chats")
         db.addDocument(data: data) { (error) in
             if let error = error {
                 print("Unable to create chat! \(error)")
                 return
             } else {
                 
                self.loadChat()
             }
         }
    }
    
    func loadChat() {

        //Fetch all the chats which has current user in it
        let currentUserID = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        db.collection("Users").document(currentUserID).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let currentRoomID = dataDescription?["Current RoomID"] as! String
                let docRef = db.collection("Post Images").document(currentRoomID)
                self.docReference = docRef
                docRef.collection("thread").order(by: "created", descending: false)
                                            .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
                                            if let error = error {
                                                print("Error: \(error)")
                                                return
                                            } else {
                                                self.messages.removeAll()
                                                    for message in threadQuery!.documents {
                
                                                        let msg = Message(dictionary: message.data())
                                                        self.messages.append(msg!)
                                                        print("Data: \(msg?.content ?? "No message found")")
                                                    }
                                                self.messagesCollectionView.reloadData()
                                                self.messagesCollectionView.scrollToBottom(animated: true)
                                            }
                                            })
                return
                
            } else {
                print("Document does not exist")
            }
        }
            
    


//        db.getDocuments { (chatQuerySnap, error) in
//
//            if let error = error {
//                print("Error: \(error)")
//                return
//            } else {
//
//                //Count the no. of documents returned
//                guard let queryCount = chatQuerySnap?.documents.count else {
//                    return
//                }
//
////                if queryCount == 0 {
////                    //If documents count is zero that means there is no chat available and we need to create a new instance
////                    self.createNewChat()
////                }
//                //else if queryCount >= 1 {
//                    //Chat(s) found for currentUser
//                    print(chatQuerySnap)
//                    for doc in chatQuerySnap!.documents {
//
//                        let chat = Chat(dictionary: doc.data())
//                        //Get the chat which has user2 id
//                        if (chat?.users.contains(self.user2UID))! {
//
//                            self.docReference = doc.reference
//                            //fetch it's thread collection
////                             doc.reference.collection("thread")
////                                .order(by: "created", descending: false)
////                                .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
////                            if let error = error {
////                                print("Error: \(error)")
////                                return
////                            } else {
////                                self.messages.removeAll()
////                                    for message in threadQuery!.documents {
////
////                                        let msg = Message(dictionary: message.data())
////                                        self.messages.append(msg!)
////                                        print("Data: \(msg?.content ?? "No message found")")
////                                    }
////                                self.messagesCollectionView.reloadData()
////                                self.messagesCollectionView.scrollToBottom(animated: true)
////                            }
////                            })
//                            return
//                        } //end of if
//                    } //end of for
//                    //
//                //self.createNewChat()
////                } else {
////                    print("Let's hope this error never prints!")
////                }
//            }
//        }
    }
    
    
    private func insertNewMessage(_ message: Message) {
        
        messages.append(message)
        messagesCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    private func save(_ message: Message) {
        
        let data: [String: Any] = [
            "content": message.content,
            "created": message.created,
            "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName
        ]
        
        docReference?.collection("thread").addDocument(data: data, completion: { (error) in
            
            if let error = error {
                print("Error Sending message: \(error)")
                return
            }
            print("message saved")
            self.messagesCollectionView.scrollToBottom()
            
        })
    }
    
    // MARK: - InputBarAccessoryViewDelegate
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {

        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: currentUser.uid, senderName: currentUser.uid)
        
          //messages.append(message)
          insertNewMessage(message)
          save(message)

          inputBar.inputTextView.text = ""
          messagesCollectionView.reloadData()
          messagesCollectionView.scrollToBottom(animated: true)
    }
    
    
    // MARK: - MessagesDataSource
    func currentSender() -> SenderType {
        
        return Sender(id: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.uid ?? "Name not found")
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
        
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        
        if messages.count == 0 {
            print("No messages to display")
            return 0
        } else {
            return messages.count
        }
    }
    
    
    // MARK: - MessagesLayoutDelegate
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    // MARK: - MessagesDisplayDelegate
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .blue: .lightGray
    }

    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        if message.sender.senderId == currentUser.uid {
            SDWebImageManager.shared.loadImage(with: currentUser.photoURL, options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                avatarView.image = image
            }
        } else {
            SDWebImageManager.shared.loadImage(with: URL(string: user2ImgUrl), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                avatarView.image = image
            }
        }
    }
    
    private func configureInputBarPadding() {
    
        // Entire InputBar padding
        messageInputBar.padding.bottom = 8
        
        // or MiddleContentView padding
        messageInputBar.middleContentViewPadding.right = -38

        // or InputTextView padding
        messageInputBar.inputTextView.textContainerInset.bottom = 8
        
    }
    
    private func configureInputBarItems() {
        messageInputBar.inputTextView.placeholderLabel.text = "  Express yourself..."
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.sendButton.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        messageInputBar.sendButton.setSize(CGSize(width: 36, height: 36), animated: false)
        messageInputBar.sendButton.image = #imageLiteral(resourceName: "cowpic")
        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.imageView?.layer.cornerRadius = 16
        let charCountButton = InputBarButtonItem()
            .configure {
                $0.title = "0/140"
                $0.contentHorizontalAlignment = .right
                $0.setTitleColor(UIColor(white: 0.6, alpha: 1), for: .normal)
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
                $0.setSize(CGSize(width: 50, height: 25), animated: false)
            }.onTextViewDidChange { (item, textView) in
                item.title = "\(textView.text.count)/140"
                let isOverLimit = textView.text.count > 140
                item.inputBarAccessoryView?.shouldManageSendButtonEnabledState = !isOverLimit // Disable automated management when over limit
                if isOverLimit {
                    item.inputBarAccessoryView?.sendButton.isEnabled = false
                }
                let color = isOverLimit ? .red : UIColor(white: 0.6, alpha: 1)
                item.setTitleColor(color, for: .normal)
        }
        let bottomItems = [.flexibleSpace, charCountButton]
        
        configureInputBarPadding()
        
        messageInputBar.setStackViewItems(bottomItems, forStack: .bottom, animated: false)

        // This just adds some more flare
        messageInputBar.sendButton
            .onEnabled { item in
                UIView.animate(withDuration: 0.3, animations: {
                    item.imageView?.backgroundColor = .red
                })
            }.onDisabled { item in
                UIView.animate(withDuration: 0.3, animations: {
                    item.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
                })
        }
    }
    
    func configureMessageInputBar() {
        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.inputTextView.tintColor = .red
        messageInputBar.inputTextView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        messageInputBar.inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)
        messageInputBar.inputTextView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        messageInputBar.inputTextView.layer.borderWidth = 1.0
        messageInputBar.inputTextView.layer.cornerRadius = 16.0
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        configureInputBarItems()
    }
    

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {

        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)

    }
    
    
}
