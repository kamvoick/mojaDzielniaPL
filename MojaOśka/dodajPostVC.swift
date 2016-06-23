//
//  dodajPostVC.swift
//  MojaOśka
//
//  Created by Kamil Wójcik on 06.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class dodajPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var zdjęcie: UIImageView!
    @IBOutlet weak var tytułField: UITextField!
    @IBOutlet weak var opisField: UITextField!

    var zbieraczZdjęć: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        zdjęcie.layer.cornerRadius = zdjęcie.frame.size.width/2
        zdjęcie.clipsToBounds = true
        zbieraczZdjęć = UIImagePickerController()
        zbieraczZdjęć.delegate = self // czyli hej zbieraczuzdjec to jest ta klasa która będzie słuchać czy działają powrotne funkcje
    }

    
    @IBAction func wyślijBtn(sender: AnyObject) {
        //w ifie pytamy że jeżeli te pola są wypełnione to wtedy może wysłać
        if let tytuł = tytułField.text, let opis = opisField.text, zdj = zdjęcie.image {
            
            
            let ścieżkaObrazka = Singleton.dzielony.zapisujObrazkiIStwórzŚcieżkę(zdj)
            
            
            let post = Post(__tytuł: tytuł , __ścieżkaObrazka: ścieżkaObrazka, __opis: opis)
            Singleton.dzielony.dodajPost(post)
            dismissViewControllerAnimated(true, completion: nil) //kiedy naciśniemy zrzuć górny vc
        }
    }

    @IBAction func anulujBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func dodajZdjęcieBtn(sender: UIButton!) {
        sender.setTitle("", forState: .Normal) //tutaj chcemy żeby po naciśnięciu zdjęcia i wgraniu go nasz tekst dodaj zdjęcie zniknął 
        presentViewController(zbieraczZdjęć, animated: true, completion: nil) //musimy zaimplementować wgrywanie zdjęć po naciśnięciu, czyli vc do pokazania będzie nasz zbieracz który przechowa zdj
        
    }
    
    //ta funkcja odpowiada za wybór zdjęcia
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        zbieraczZdjęć.dismissViewControllerAnimated(true, completion: nil) //czyli kiedy użytkownik wybirze zdjęcie chcemy ukryć zbieraczazdjęć
        zdjęcie.image = image //i teraz nowe zdjecie będzie się równać wybranemu
    }
        
    
}
