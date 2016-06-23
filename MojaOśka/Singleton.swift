//
//  Singleton.swift
//  MojaOśka
//
//  Created by Kamil Wójcik on 06.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import Foundation
import UIKit

//używam singletona ponieważ chcemy mieć globalne zmienne aby dostać się do nich z dodajpostvc do vc itd moglibysmy to zrobic w kodzie jakos się odwołując ale byłoby więcej niepotrzebnego kodu, jednak WAŻNE singleton nie zostaje czyszczony z pamięci jak np. stringi inti itd dlatego ciągle ją zappycha i nie jest to dobre rozwiązanie na dłuższą metę, trzeba używać rozsądnie

class Singleton {
    static let dzielony = Singleton()
    
    private var _ładowanePosty = [Post]()
    
    let key_posts = "posty"
    
    var ładowanePosty: [Post]{
        return _ładowanePosty
    }
    
    func zapisujPostyNaDysku() {
        let danePostów = NSKeyedArchiver.archivedDataWithRootObject(_ładowanePosty)//bierzemy nasze posty i zamieniamy je w dane
        NSUserDefaults.standardUserDefaults().setObject(danePostów, forKey: key_posts)//bierzemy cały array naszych postów zamieniamy na dane, potem bierzemy standarduserdefaults który jest mechanizmem zapisującym i zapisujemy obiekt za pomocą klucza, coś jak słowniki (dicstionaries)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    func ładujPostyZDysku() {
        //tutaj robimy odwrotną rzecz niż wcześniej, bierzemy teraz nasze zapisane posty i mówimy że chcemy obiekt dla tego klucza, potem musimy je jeszcze zamienić na array
        if let danePostów = NSUserDefaults.standardUserDefaults().objectForKey(key_posts) as? NSData {
            if let arrayPostów = NSKeyedUnarchiver.unarchiveObjectWithData(danePostów) as? [Post]{
                _ładowanePosty = arrayPostów
            }
        }
        //niżej tworzymy powiadomienia żeby powiadamiało ludzi o tym że wsadziliśmy posta, składnia niżej i w postnotification tworzymy nową notyfikacje dajemy jej imie
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "załadowanePosty", object: nil)) //potem będziemy się odwoływać do naszych obserwatorów
        
    }
    
    
    func zapisujObrazkiIStwórzŚcieżkę(obrazek: UIImage) -> String{
        let daneObrazka = UIImagePNGRepresentation(obrazek) //za każdym razem kiedy użytkownik wybierze zdjęcie z galerii, my je zamienimy na dane(data)
        let ścieżkaObrazka = "obraz\(NSDate.timeIntervalSinceReferenceDate())" //obrazek będzie miał datę
        let pełnaŚcieżka = ścieżkaDokumentówDlaNaszegoPliku(ścieżkaObrazka) //wpisujemy ścieżke do dokumentu
        daneObrazka?.writeToFile(pełnaŚcieżka, atomically: true) //zapisujemy, atomically oznacza bezpieczny sposób na zapisywanie
        return ścieżkaObrazka //zapisuje i musimy oddać ścieżkę bo program nie będzie wiedział skąd pobrać dane, dlatego ścieżka musi być gdzieś składowana
    }
    
    func obrazekDlaŚcieżki(ścieżka: String) -> UIImage? {
        let pełnaŚcieżka = ścieżkaDokumentówDlaNaszegoPliku(ścieżka)
        let obrazek = UIImage(named: pełnaŚcieżka)
        return obrazek
    }
    
    func dodajPost(post: Post){
        _ładowanePosty.append(post)
        zapisujPostyNaDysku()
        ładujPostyZDysku()
    }
    
    func ścieżkaDokumentówDlaNaszegoPliku(nazwaPliku: String) -> String {
        let ścieżka = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let pełnaŚcieżka = ścieżka[0] as NSString
        return pełnaŚcieżka.stringByAppendingPathComponent(nazwaPliku)
        //wyjaśnienie: wsadzasz nazwę pliku np. mójobrazek.png, potem bierzemy ścieżkę do dokumentów,a potem dodajemy nazwę naszego pliku czyli mójobrazek.png do tej ścieżki żeby zapisało czyli /documents/mójobrazek.png
    }
    
}
