//
//  ViewController.swift
//  ImageRecognition
//
//  Created by Eray İnal on 15.03.2024.
//

//1 Machine Learning nedir?
//.1 'developer.apple.com/machine-learning/models/' bu link üzerinden farklı modelleri görebiliriz. Biz 'MobileNetV2' kullanıcaz

import UIKit
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var chosenImage = CIImage()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func changeButtonClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self      //2 bunların yazınca hata verecek bu yüzden 'UlImagePickerControllerDelegate, UINavigationControllerDelegate' implement etmemiz gerekiyor.
        
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
        //3 Son olarak da bu fotoğraf seçildikten sonra ne yapıcaz onu yazmamız lazım bunun için hemen aşağıda didFinishPickingMediaWithInfo methodunu yazalım
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: false, completion: nil)
        
        //.3 Şimdi 'developer.apple.com/machine-learning/models/' linki üzerinden 'MobileNetV2'ye tıklayalım ve 24mb ve 32bit olanı indirelim. İndirdikten sonra bu projeye sürükleyerek 'Info' altına bırakalım.
        //4 CoreML'i ve Vision'ı import edelim ve ardından recognizeImage adında bir method yazalım ve method içerisinde çağıralım: ama öncesinde birkaç kod yazmamız lazım
        if let ciImage = CIImage(image: imageView.image!){
            //..4 Burada yazdığımız ciImage'ı 'recognizeImage' methodu içerisinde kullanabilmek için class'ın başında 'chosenImage' adında bir variable tanımlayalım. Ve şimdi 'chosenImage' içerisne gidip kodu yazalım
            chosenImage = ciImage
        }
        recognizeImage(image: chosenImage)
        
    }
    
    
    //.4:
    func recognizeImage(image:CIImage){
        //...4:
        
    }
    
    
    
}

