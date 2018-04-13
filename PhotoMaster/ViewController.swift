//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 張翔 on 2018/04/11.
//  Copyright © 2018年 sho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cameraButton(){
        presentPickerController(sourceType: .camera)
        
    }

    @IBAction func albumButton(){
        presentPickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func textButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawText(imgae: photoImageView.image!)
        }else{
            print("画像がありません")
        }
    }
    
    @IBAction func illustButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
    }
    
    @IBAction func uploadButton(){
        if photoImageView.image != nil{
            let activityViewController = UIActivityViewController(activityItems: [photoImageView.image!, "#PhotoMaster"], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }else{
            print("画像がありません")
        }
    }
    
    func presentPickerController(sourceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func drawText(imgae: UIImage) -> UIImage{
        let text = "LifeisTech!"
        
        let textFontAttributes = [
            NSAttributedStringKey.font: UIFont(name: "Arial", size: 120),
            NSAttributedStringKey.foregroundColor: UIColor.red
        ]
        
        UIGraphicsBeginImageContext(imgae.size)

        imgae.draw(in: CGRect(x: 0, y: 0, width: imgae.size.width, height: imgae.size.height))
        
        let margin: CGFloat = 5.0
        let textRect = CGRect(x: margin, y: margin, width: imgae.size.width - margin, height: imgae.size.height - margin)
        
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func drawMaskImage(image: UIImage) -> UIImage{
        let maskImage = UIImage(named: "duck")!
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin, y: image.size.height - maskImage.size.height - margin, width: maskImage.size.width, height: maskImage.size.height)
        
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

