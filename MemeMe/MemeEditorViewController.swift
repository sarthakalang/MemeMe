//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Sarthak on 1/2/17.
//  Copyright © 2017 Sarthak. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var sharebutton: UIBarButtonItem!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var ImagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    var memedImage=UIImage()
    
    func pickImage(type:String){
        let pickerview=UIImagePickerController()
        pickerview.delegate=self
        if(type=="Camera"){
            pickerview.sourceType = .camera
        }
        else if(type=="Library"){
           pickerview.sourceType = .photoLibrary
        }
        present(pickerview, animated: true, completion: nil)
    }
    func save(){
        let meme = Meme(topText: top.text!, bottomText: bottom.text!, originalImage: ImagePickerView.image!, memedImage: memedImage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        print("appended")
        print("main data count is ",appDelegate.memes.count)
    }
    
    func resetAll(){
        setTextFieldAttributes(top, text: "TOP")
        setTextFieldAttributes(bottom, text: "BOTTOM")
        sharebutton.isEnabled=false
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        ImagePickerView.image=nil
        resetAll()
    }
    func generateMemedImage() -> UIImage {
        
        toolbar.isHidden=true
        navbar.isHidden=true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        toolbar.isHidden=false
        navbar.isHidden=false
        return memedImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetAll()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setTextFieldAttributes(_ textField: UITextField,text: String){
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
            NSStrokeWidthAttributeName : -3.0,]
        
        textField.delegate=self
        textField.defaultTextAttributes=memeTextAttributes
        textField.textAlignment=NSTextAlignment.center
        textField.text=text
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottom.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ImagePickerView.contentMode=UIViewContentMode.scaleAspectFill
            ImagePickerView.image = image
            sharebutton.isEnabled=true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == top && textField.text! == "TOP" {
            textField.text = ""
        }
        if textField == bottom && textField.text! == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField==top||textField==bottom{
            view.endEditing(true)
        }
        return true
    }

    @IBAction func pickAnImage(_ sender: Any) {
        
        pickImage(type: "Library")
    }
    @IBAction func pickImageFromCamera(_ sender: Any) {
        pickImage(type: "Camera")
        
    }
    
    @IBAction func share(_ sender: Any) {
      memedImage=generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler={
            (activity, success, items, error) in
            if(success){
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
            else{
                print("user cancelled UIActivity")
            }
            
    }
        self.present(controller, animated: true, completion: nil)

}
}

