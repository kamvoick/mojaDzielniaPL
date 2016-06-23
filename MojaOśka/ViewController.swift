//
//  ViewController.swift
//  MojaOśka
//
//  Created by Kamil Wójcik on 05.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

//wsadzamy dodatkowo delegacje i datasource do protokołów
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //stworzymy array i za każdym razem kiedy będzie nowy post dodamy go do arrayu
//    var posty = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //w skrócie, tableview szuka delegata a my musimy mu pokazać że naszym delegatem jest viewcontroller, podobnie jest w przypadku datasource
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.estimatedRowHeight = 87 <- jeżeli chcesz żeby twój tekst był większy bądź skórczony wpisujemy to zamiast funkcji height niżej
        
        Singleton.dzielony.ładujPostyZDysku()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "kiedyZaładująSięPosty:", name: "załadowanePosty", object: nil) //self bo to ta klasa nasłuchuje, selector oznacza funkcje jaką chcemy włączyć gdy zdarzyć się ta rzecz, dwukropek oznacza że będzie tam jakiś parametr, name to nazwa naszej notyfikacji z wcześniej, czyli kiedy posty są załadowane uruchom tą funkcje z selektora


    }

    //ile sekcji czyli jeżeli mamy np. kategorie powiedzmy samochodu - marki chcemy żeby były 4 marki i każda marka jeszcze miała możliwość wpisania komórek zwracamy liczbę tych marek
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //ta funkcja mówi o tym że za każdym razem kiedy będziemy chcieli wsadzić jakieś dane stwórz nową komórke (cell) w tableView, wsadz tam te dane i pokaż ją na ekranie
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = Singleton.dzielony.ładowanePosty[indexPath.row] // pokazujemy o którą komórkę nam chodzi z arrayu
        //w skrócie mówi do nas hej czy masz jakąś niepotrzebną zużytą komórke w której mogę zapisać dane? tak jasne, zaraz ci dam i zamienie na postcell, z tym że najpierw muszę ją wyczyścić i tutaj jeżeli komórka jest zużyta to
        if let komórka = tableView.dequeueReusableCellWithIdentifier("PostsCell") as? PostsCell {
            komórka.skonfigurujKomórkę(post)
            return komórka
        }else { //jeżeli ci nie da starej to tworzysz nową
            let komórka = PostsCell()
            komórka.skonfigurujKomórkę(post)
            return komórka
            
        }
    }
    
    //wysokość naszej komórki
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 87
    }
    
    //ile rzędów będzie w sekcji
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.dzielony.ładowanePosty.count
    }
    
    //
    func kiedyZaładująSięPosty(powiadom: AnyObject){
        tableView.reloadData()
    }


}

