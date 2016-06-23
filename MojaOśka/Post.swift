//
//  Post.swift
//  MojaOśka
//
//  Created by Kamil Wójcik on 05.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import Foundation

//za każdym razem kiedy chcemy archiwizować i odarchiwizować musimy do klasy którą archiwizujemy dołączyć dziedziczenie z nsobject i nscoding
class Post: NSObject, NSCoding {
    private var _tytuł: String!
    private var _ścieżkaObrazka: String!
    private var _opis: String!
    
    var tytuł: String {
        return _tytuł
    }
    var ścieżkaObrazka: String {
        return _ścieżkaObrazka
    }
    var opis: String {
        return _opis
    }
    
    
    init(__tytuł: String, __ścieżkaObrazka: String, __opis: String){
        self._tytuł = __tytuł
        self._ścieżkaObrazka = __ścieżkaObrazka
        self._opis = __opis
    }
    
    
    override init() {
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._ścieżkaObrazka = aDecoder.decodeObjectForKey("ścieżkaObrazka") as? String
        self._tytuł = aDecoder.decodeObjectForKey("tytuł") as? String
        self._opis = aDecoder.decodeObjectForKey("opis") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._ścieżkaObrazka, forKey: "ścieżkaObrazka")
        aCoder.encodeObject(self._tytuł, forKey: "tytuł")
        aCoder.encodeObject(self._opis, forKey: "opis")
    }
}