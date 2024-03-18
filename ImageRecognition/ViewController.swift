//
//  ViewController.swift
//  ImageRecognition
//
//  Created by Eray İnal on 17.03.2024.
//

import UIKit
import CoreML
import Vision

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
        //...4 Burada yapacağımız iki tane işlem var. 1) Request 2)Requesti handle etmek(handler)
        //....4 Bunu yapmadan önce 'Vision' import edelim
        
        resultLabel.text = "Finding ..."
                
        if let model = try? VNCoreMLModel(for: MobileNetV2().model) {
            let request = VNCoreMLRequest(model: model) { (vnrequest, error) in
                
                if let results = vnrequest.results as? [VNClassificationObservation] {
                    if results.count > 0 {
                        
                        let topResult = results.first
                        
                        DispatchQueue.main.async {
                            //
                            let confidenceLevel = (topResult?.confidence ?? 0) * 100
                            
                            let rounded = Int (confidenceLevel * 100) / 100
                            
                            self.resultLabel.text = "\(rounded)% it's \(topResult!.identifier)"
                            
                        }
                    }
                }
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    try handler.perform([request])
                } catch {
                    print("error")
                }
            }
        }
        
    }
  
    
    
}

