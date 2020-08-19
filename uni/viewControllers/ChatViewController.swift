import UIKit
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage
import Lottie
import AVKit


class ChatViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, UIGestureRecognizerDelegate {

    // MARK: - MessageInputBar
    
    @IBOutlet weak var ch1_animation: AnimationView!
    @IBOutlet weak var ch2_animation: AnimationView!
    @IBOutlet weak var ch3_animation: AnimationView!
    @IBOutlet weak var ch4_animation: AnimationView!
    var currentUser: User = Auth.auth().currentUser!
    var db = Firestore.firestore()
    var user2Name = "Logan"
    var user2ImgUrl = "https://firebasestorage.googleapis.com/v0/b/unimarketplace-dd3f6.appspot.com/o/Profile%20Image%2FS3UtuLPdsFQRV0yrTyr1OazjcP33?alt=media&token=15f1ab56-0d82-4e23-8994-a4ca865ffd38"
    var user2UID = "S3UtuLPdsFQRV0yrTyr1OazjcP33"
    var count = 0
    var count_join = UserDefaults.standard.integer(forKey: "join_count")
    private var docReference: DocumentReference?
    
    var messages: [Message] = []
    
    override func viewDidAppear(_ animated: Bool) {
        self.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ch1_animation.isHidden = true
        ch2_animation.isHidden = true
        ch3_animation.isHidden = true
        ch4_animation.isHidden = true
//        start_animation()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        messagesCollectionView.addGestureRecognizer(tap)

        self.title = user2Name
        navigationItem.largeTitleDisplayMode = .never
        maintainPositionOnKeyboardFrameChanged = true
        configureMessageInputBar()
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        self.view.backgroundColor = UIColor(red: 0.076, green: 0.073, blue: 0.2, alpha: 1)
        messagesCollectionView.backgroundColor = .clear
        
        scrollsToBottomOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        super.viewDidLayoutSubviews()
        
        messageInputBar.inputTextView.keyboardAppearance = UIKeyboardAppearance.dark
        
        let gradientLayer = CAGradientLayer()
        let backgroundColor = UIColor(red: 0.055, green: 0.046, blue: 0.108, alpha: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        gradientLayer.colors = [backgroundColor.withAlphaComponent(0.05).cgColor,backgroundColor.withAlphaComponent(0.8).cgColor, backgroundColor.withAlphaComponent(1).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        intro_animation()
        newMemberAnim()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.85) { // Change `2.0` to the desired number of seconds.
            self.loadChat()
        }
        //createNewChat()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.willEnterForegroundNotification, object: nil)
        ch1_animation.backgroundBehavior = .pauseAndRestore
        if ch1_animation.isAnimationPlaying == false{
            //ch1_animation.loopMode = .loop
            ch1_animation.play()
            //ch2_animation.loopMode = .loop
            ch2_animation.play()
            //ch3_animation.loopMode = .loop
            ch3_animation.play()
            //ch4_animation.loopMode = .loop
            ch4_animation.play()
        }
    }

    
    override func viewDidLayoutSubviews() {
        let frame_width = self.view.frame.width
        let frame_height = self.view.frame.height
        
        self.view.frame.size.height = UIScreen.main.bounds.height * (490/812)
        messagesCollectionView.frame.size.height = UIScreen.main.bounds.height * (485/812)

        ch1_animation.translatesAutoresizingMaskIntoConstraints = false
        ch1_animation.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(-130/480)).isActive = true
        ch1_animation.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(-35/375)).isActive = true
        ch1_animation.widthAnchor.constraint(equalToConstant: frame_width*(210/375)).isActive = true
        ch1_animation.widthAnchor.constraint(equalTo: ch1_animation.heightAnchor, multiplier: 210/150).isActive = true
        
        ch2_animation.translatesAutoresizingMaskIntoConstraints = false
        ch2_animation.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(-170/480)).isActive = true
        ch2_animation.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(80/375)).isActive = true
        ch2_animation.widthAnchor.constraint(equalToConstant: frame_width*(130/375)).isActive = true
        ch2_animation.widthAnchor.constraint(equalTo: ch2_animation.heightAnchor, multiplier: 130/150).isActive = true
        
        ch3_animation.translatesAutoresizingMaskIntoConstraints = false
        ch3_animation.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(-145/480)).isActive = true
        ch3_animation.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(170/375)).isActive = true
        ch3_animation.widthAnchor.constraint(equalToConstant: frame_width*(130/375)).isActive = true
        ch3_animation.widthAnchor.constraint(equalTo: ch3_animation.heightAnchor, multiplier: 130/120).isActive = true
        
        ch4_animation.translatesAutoresizingMaskIntoConstraints = false
        ch4_animation.topAnchor.constraint(equalTo: self.view.topAnchor, constant: frame_height*(-130/480)).isActive = true
        ch4_animation.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: frame_width*(215/375)).isActive = true
        ch4_animation.widthAnchor.constraint(equalToConstant: frame_width*(200/375)).isActive = true
        ch4_animation.widthAnchor.constraint(equalTo: ch4_animation.heightAnchor, multiplier: 200/140).isActive = true
        
        
//        ch1_animation.backgroundColor = .clear
//        ch1_animation.contentMode = .scaleAspectFill
//        ch1_animation.loopMode = .loop
//        ch1_animation.play()
//        ch2_animation.backgroundColor = .clear
//        ch2_animation.contentMode = .scaleAspectFill
//        ch2_animation.loopMode = .loop
//        ch2_animation.play()
//        ch3_animation.backgroundColor = .clear
//        ch3_animation.contentMode = .scaleAspectFill
//        ch3_animation.loopMode = .loop
//        ch3_animation.play()
//        ch4_animation.backgroundColor = .clear
//        ch4_animation.contentMode = .scaleAspectFill
//        ch4_animation.loopMode = .loop
//        ch4_animation.play()
    }
    
    @objc func didBecomeActive(){

        ch1_animation.play()
        ch2_animation.play()
        ch3_animation.play()
        ch4_animation.play()
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        messageInputBar.inputTextView.resignFirstResponder()
    }
    
    func intro_animation(){
        
        let avatar = UserDefaults.standard.string(forKey: "Avatar")
        let avatar_1 = UserDefaults.standard.bool(forKey: "Avatar 1")
        let avatar_2 = UserDefaults.standard.bool(forKey: "Avatar 2")
        let avatar_3 = UserDefaults.standard.bool(forKey: "Avatar 3")
        let avatar_4 = UserDefaults.standard.bool(forKey: "Avatar 4")
        
        if avatar == "Avatar 1"{
            ch1_animation.isHidden = false
            ch1_animation.animation = Animation.named("ch1_join")
            ch1_animation.contentMode = .scaleAspectFill
            ch1_animation.loopMode = .playOnce
            ch1_animation.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.85) { // Change `2.0` to the desired number of seconds.
                self.ch1_animation.animation = Animation.named("ch1_blink")
                self.ch1_animation.loopMode = .loop
                self.ch1_animation.play()
            }
            if avatar_2 == true{
                ch2_animation.isHidden = false
                ch2_animation.contentMode = .scaleAspectFill
                ch2_animation.loopMode = .loop
                ch2_animation.play()
            }
            if avatar_3 == true{
                ch3_animation.isHidden = false
                ch3_animation.contentMode = .scaleAspectFill
                ch3_animation.loopMode = .loop
                ch3_animation.play()
            }
            if avatar_4 == true{
                ch4_animation.isHidden = false
                ch4_animation.contentMode = .scaleAspectFill
                ch4_animation.loopMode = .loop
                ch4_animation.play()
            }
        } else if avatar == "Avatar 2"{
            ch2_animation.isHidden = false
            ch2_animation.animation = Animation.named("ch2_join")
            ch2_animation.contentMode = .scaleAspectFill
            ch2_animation.loopMode = .playOnce
            ch2_animation.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.85) { // Change `2.0` to the desired number of seconds.
                self.ch2_animation.animation = Animation.named("ch2_blink")
                self.ch2_animation.loopMode = .loop
                self.ch2_animation.play()
            }
//            ch2_animation.isHidden = false
//            self.animate(character: "ch2", animation: "ch2_join", default_animation: "ch2_blink")
            if avatar_1 == true{
                ch1_animation.isHidden = false
                ch1_animation.contentMode = .scaleAspectFill
                ch1_animation.loopMode = .loop
                ch1_animation.play()
            }
            if avatar_3 == true{
                ch3_animation.isHidden = false
                ch3_animation.contentMode = .scaleAspectFill
                ch3_animation.loopMode = .loop
                ch3_animation.play()
            }
            if avatar_4 == true{
                ch4_animation.isHidden = false
                ch4_animation.contentMode = .scaleAspectFill
                ch4_animation.loopMode = .loop
                ch4_animation.play()
            }
        }else if avatar == "Avatar 3"{
            ch3_animation.isHidden = false
            ch3_animation.animation = Animation.named("ch3_join")
            ch3_animation.contentMode = .scaleAspectFill
            ch3_animation.loopMode = .playOnce
            ch3_animation.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.85) { // Change `2.0` to the desired number of seconds.
                self.ch3_animation.animation = Animation.named("ch3_blink")
                self.ch3_animation.loopMode = .loop
                self.ch3_animation.play()
            }
            ch3_animation.isHidden = false
            self.animate(character: "ch3", animation: "ch3_join", default_animation: "ch3_blink")
            if avatar_1 == true{
                ch1_animation.isHidden = false
                ch1_animation.contentMode = .scaleAspectFill
                ch1_animation.loopMode = .loop
                ch1_animation.play()
            }
            if avatar_2 == true{
                ch2_animation.isHidden = false
                ch2_animation.contentMode = .scaleAspectFill
                ch2_animation.loopMode = .loop
                ch2_animation.play()
            }
            if avatar_4 == true{
                ch4_animation.isHidden = false
                ch4_animation.contentMode = .scaleAspectFill
                ch4_animation.loopMode = .loop
                ch4_animation.play()
            }
        }else if avatar == "Avatar 4"{
            ch4_animation.isHidden = false
            ch4_animation.animation = Animation.named("ch4_join")
            ch4_animation.contentMode = .scaleAspectFill
            ch4_animation.loopMode = .playOnce
            ch4_animation.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.85) { // Change `2.0` to the desired number of seconds.
                self.ch4_animation.animation = Animation.named("ch4_blink")
                self.ch4_animation.loopMode = .loop
                self.ch4_animation.play()
            }
//            ch4_animation.isHidden = false
//            self.animate(character: "ch4", animation: "ch4_join", default_animation: "ch4_blink")
            if avatar_1 == true{
                ch1_animation.isHidden = false
                ch1_animation.contentMode = .scaleAspectFill
                ch1_animation.loopMode = .loop
                ch1_animation.play()
            }
            if avatar_2 == true{
                ch2_animation.isHidden = false
                ch2_animation.contentMode = .scaleAspectFill
                ch2_animation.loopMode = .loop
                ch2_animation.play()
            }
            if avatar_3 == true{
                ch3_animation.isHidden = false
                ch3_animation.contentMode = .scaleAspectFill
                ch3_animation.loopMode = .loop
                ch3_animation.play()
            }
        }
        

    }
        

    
    // MARK: - Custom messages handlers
    
    func animate(character: String, animation:String, default_animation:String){
        if character == "ch1"{

            ch1_animation.isHidden = false
            ch1_animation.animation = Animation.named(animation)
            ch1_animation.contentMode = .scaleAspectFill
            ch1_animation.loopMode = .playOnce
            ch1_animation.play()
                { (Success) in
                if Success{
                    self.ch1_animation.animation = Animation.named(default_animation)
                    self.ch1_animation.loopMode = .loop
                    self.ch1_animation.play()
                }
            }
        } else if character == "ch2"{
            ch2_animation.isHidden = false
            ch2_animation.animation = Animation.named(animation)
            ch2_animation.contentMode = .scaleAspectFill
            ch2_animation.loopMode = .playOnce
            ch2_animation.play()
                { (Success) in
                if Success{
                    self.ch2_animation.animation = Animation.named(default_animation)
                    self.ch2_animation.loopMode = .loop
                    self.ch2_animation.play()
                }
            }
        }
         else if character == "ch3"{
            ch3_animation.isHidden = false
            ch3_animation.animation = Animation.named(animation)
            ch3_animation.contentMode = .scaleAspectFill
            ch3_animation.loopMode = .playOnce
            ch3_animation.play()
                { (Success) in
                if Success{
                    self.ch3_animation.animation = Animation.named(default_animation)
                    self.ch3_animation.loopMode = .loop
                    self.ch3_animation.play()
                }
            }
        }else{
            ch4_animation.isHidden = false
            ch4_animation.animation = Animation.named(animation)
            ch4_animation.contentMode = .scaleAspectFill
            ch4_animation.loopMode = .playOnce
            ch4_animation.play()
                { (Success) in
                if Success{
                    self.ch4_animation.animation = Animation.named(default_animation)
                    self.ch4_animation.loopMode = .loop
                    self.ch4_animation.play()
            }
        }
    }
        
    }
    

    
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
    
    func newMemberAnim(){
        let currentRoomID = UserDefaults.standard.string(forKey: "currentRoomID")
        let docRef = self.db.collection("Post Images").document(currentRoomID!).collection("Members")
        docRef.addSnapshotListener { (QuerySnapshot, errpr) in
            if let query = QuerySnapshot{
            query.documentChanges.forEach { (DocumentChange) in
                if DocumentChange.type == .added {
                    print(self.count_join)
                    if self.count_join > 0{
                        let member_data = DocumentChange.document.data()
                        let avatar_joined = member_data["avatar"] as? String
                        if avatar_joined == "Avatar 1"{
                            print("joineed 1")
                            self.animate(character: "ch1", animation: "ch1_join", default_animation: "ch1_blink")
                        } else if avatar_joined == "Avatar 2"{
                            print("joineed 2")
                            self.animate(character: "ch2", animation: "ch2_join", default_animation: "ch2_blink")
                        } else if avatar_joined == "Avatar 3"{
                            self.animate(character: "ch3", animation: "ch3_join", default_animation: "ch3_blink")
                        } else{
                            self.animate(character: "ch4", animation: "ch4_join", default_animation: "ch4_blink")
                        }
                        
                    }
                    
                } else if DocumentChange.type == .removed{
                    let member_data = DocumentChange.document.data()
                    let avatar_left = member_data["avatar"] as? String
                    if avatar_left == "Avatar 1"{
                        self.ch1_animation.isHidden = true
                    } else if avatar_left == "Avatar 2"{
                        self.ch2_animation.isHidden = true
                    } else if avatar_left == "Avatar 3"{
                        self.ch3_animation.isHidden = true
                    } else{
                        self.ch4_animation.isHidden = true
                    }
                }
                }
            
            }
            self.count_join += 1
            
        }
    }
    
    func loadChat() {
        
        //Fetch all the chats which has current user in it
        
//        db.collection("Users").document(currentUser.uid).getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data()
//                let currentRoomID = dataDescription?["Current RoomID"] as! String //self.currentRoomID
                let currentRoomID = UserDefaults.standard.string(forKey: "currentRoomID")
                let docRef = self.db.collection("Post Images").document(currentRoomID!)
                self.docReference = docRef
                
                docRef.collection("thread").order(by: "created", descending: false).addSnapshotListener { (QuerySnapshot, Error) in
                    if let query = QuerySnapshot{
                        query.documentChanges.forEach { (DocumentChange) in
                            if DocumentChange.type == .added {
                                let msg_data = DocumentChange.document.data()
                                let msg = Message(dictionary: msg_data)
                                self.messages.append(msg!)
                                if self.count > 0{
                                    let avatar_sent = msg_data["avatar"] as? String
                                    if avatar_sent == "Avatar 1"{
                                        self.animate(character: "ch1", animation: "ch1_talk", default_animation: "ch1_blink")
                                    } else if avatar_sent == "Avatar 2"{
                                        self.animate(character: "ch2", animation: "ch2_talk", default_animation: "ch2_blink")
                                    } else if avatar_sent == "Avatar 3"{
                                        self.animate(character: "ch3", animation: "ch3_talk", default_animation: "ch3_blink")
                                    } else{
                                        self.animate(character: "ch4", animation: "ch4_talk", default_animation: "ch4_blink")
                                    }
                                }
                                
                                  //print("Data: \(msg?.content ?? "No message found")")
                                                                                
                                self.messagesCollectionView.reloadData()
                                self.messagesCollectionView.scrollToBottom(animated: true)


                                }
                            
                        }
                        self.count += 1
                        return
                    }
                }
//            }
//            }
                               
//                            else {
//                               print("Document does not exist")
//                           }
                       //}
                           
//                docRef.collection("thread").order(by: "created", descending: false)
//                                            .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
//                                            if let error = error {
//                                                print("Error: \(error)")
//                                                return
//                                            } else {
//                                                //print(self.count)
//                                                self.messages.removeAll()
//                                                for message in threadQuery!.documents {
//
//                                                    let msg_data = message.data()
//                                                    print(msg_data["content"] as? String)
//                                                    let msg = Message(dictionary: msg_data)
//                                                    self.messages.append(msg!)
////                                                    let avatar_sent = msg_data["avatar"] as? String
////                                                    if avatar_sent == "Avatar 1"{
////                                                        print(1)
////                                                        self.animate_talk(animation: "ch1_talk", default_animation: "ch1_blink")
////                                                    } else if avatar_sent == "Avatar 2"{
////                                                        print(2)
////                                                        self.animate_talk(animation: "ch2_talk", default_animation: "ch2_blink")
////                                                    } else if avatar_sent == "Avatar 3"{
////                                                        print(3)
////                                                        self.animate_talk(animation: "ch1_talk", default_animation: "ch1_blink")
////                                                    } else{
////                                                        print(4)
////                                                        self.animate_talk(animation: "ch1_talk", default_animation: "ch1_blink")
////                                                    }
////                                                      print("Data: \(msg?.content ?? "No message found")")
//                                                }
//
//                                                self.messagesCollectionView.reloadData()
//                                                self.messagesCollectionView.scrollToBottom(animated: true)
//                                            }
//                                            })
               
    


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
        
        //messages.append(message)
        messagesCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    private func save(_ message: Message) {
        
        let avatar = UserDefaults.standard.string(forKey: "Avatar")
        let data: [String: Any] = [
            "content": message.content,
            "created": message.created,
            "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName,
            "avatar": avatar
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
        return isFromCurrentSender(message: message) ? .orange: .lightGray
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
        messageInputBar.padding.top = 10
        messageInputBar.padding.bottom = 10
        messageInputBar.inputTextView.textContainerInset.bottom = 5
        messageInputBar.inputTextView.placeholderLabelInsets.bottom = 5
        
    }
    
    private func configureInputBarItems() {
        messageInputBar.inputTextView.placeholderLabel.text = " Express yourself..."
        messageInputBar.setRightStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.sendButton.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        messageInputBar.sendButton.setSize(CGSize(width: 40, height: 40), animated: false)
        messageInputBar.sendButton.image = #imageLiteral(resourceName: "ic_send")
        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.imageView?.layer.cornerRadius = 16
//        let charCountButton = InputBarButtonItem()
//            .configure {
//                $0.title = "0/140"
//                $0.contentHorizontalAlignment = .right
//                $0.setTitleColor(UIColor(white: 0.6, alpha: 1), for: .normal)
//                $0.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
//                $0.setSize(CGSize(width: 50, height: 25), animated: false)
//            }.onTextViewDidChange { (item, textView) in
//                item.title = "\(textView.text.count)/140"
//                let isOverLimit = textView.text.count > 140
//                item.inputBarAccessoryView?.shouldManageSendButtonEnabledState = !isOverLimit // Disable automated management when over limit
//                if isOverLimit {
//                    item.inputBarAccessoryView?.sendButton.isEnabled = false
//                }
//                let color = isOverLimit ? .red : UIColor(white: 0.6, alpha: 1)
//                item.setTitleColor(color, for: .normal)
//        }
//        let bottomItems = [.flexibleSpace, charCountButton]
        
        configureInputBarPadding()
        
//        messageInputBar.setStackViewItems(bottomItems, forStack: .bottom, animated: false)

        // This just adds some more flare
        messageInputBar.sendButton
            .onEnabled { item in
                UIView.animate(withDuration: 0.3, animations: {
                    item.imageView?.backgroundColor = .green
                })
            }.onDisabled { item in
                UIView.animate(withDuration: 0.3, animations: {
                    item.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
                })
        }
    }
    
    func configureMessageInputBar() {
        messageInputBar.backgroundView.backgroundColor = UIColor(red: 0.055, green: 0.046, blue: 0.108, alpha: 1)
        messageInputBar.inputTextView.backgroundColor = .clear
//        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = false
        messageInputBar.inputTextView.textColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        messageInputBar.inputTextView.tintColor = UIColor(red: 0.076, green: 0.073, blue: 0.2, alpha: 1)
        messageInputBar.inputTextView.backgroundColor = UIColor(red: 0.16, green: 0.13, blue: 0.36, alpha: 1.00)
        messageInputBar.inputTextView.placeholderTextColor = UIColor(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)
        messageInputBar.inputTextView.layer.cornerRadius = 18
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        configureInputBarItems()
    }
    

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {

        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)

    }
    
    
}
