import Foundation
import Glibc

protocol CheckListElementProtocol{
    var czyDaSieWykonac:Bool {get set}
    func pokazCzyDaSieWykonac()
}

protocol CommunicationProtocol{
    func wydrukujElementy()
}

class CheckListElement: CheckListElementProtocol{
    var poleTekstowe:String
    var czyWykonany:Bool
    var dzienTygodnia:String
    var czyDaSieWykonac:Bool = false
    var delegate:CommunicationProtocol?
    
    
    
    init(){
        poleTekstowe = ""
        czyWykonany = false
        dzienTygodnia = ""
    }
    
    init(_ nrDniaTygodnia:Int, _ poleTekstowe:String, _ czyWykonany:Bool){
        self.poleTekstowe = poleTekstowe
        self.czyWykonany = czyWykonany
        let tydzien = ["Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota", "Niedziela"]
        self.dzienTygodnia = tydzien[nrDniaTygodnia-1]
    }
    func pokazCzyDaSieWykonac(){
        if czyWykonany == true{
            czyDaSieWykonac = true
            print("da się wykonać")
        }
        else{
            czyDaSieWykonac = false
            print("niewiadomo, czy da się wykonać")
        }
    }
    func zmienCzyWykonany(){
        delegate?.wydrukujElementy()
        var holder:Bool?
        holder = czyWykonany
        if holder == true {
            czyWykonany = false
        }
        else{
            czyWykonany = true
        }
    }
}
   
extension CheckListElement: CustomStringConvertible{
    var description: String {
        var tekstCzyWykonany = ""
        if czyWykonany == false {
            tekstCzyWykonany = "Do Wykonania"
        }
        else{
            tekstCzyWykonany = "Gotowe"
        }
        return "\(dzienTygodnia) \(poleTekstowe) -> \(tekstCzyWykonany)"
    }   
}

class CheckList: CommunicationProtocol{
    var arrayCheckList:[CheckListElement]?
    
    init(_ arrayCheckList:[CheckListElement]){
        self.arrayCheckList = arrayCheckList
    }
    
    func wydrukujElementy(){
        for element in arrayCheckList!{
            print(element)
        }
    }
    func wydrukujCoTrzeciElement(){
        let coTrzeci = 3
        for element in stride(from: 2, to: arrayCheckList!.count, by: coTrzeci){
            print(arrayCheckList![element])
        }
    }
}


var a = CheckListElement(1, "Wyjść z psem", true)
var b = CheckListElement(2, "Wyjść na spacer", false)
var c = CheckListElement(3, "Iść do szkoły", true)
var d = CheckListElement(4, "Zrobić zadanie domowe", false)
var e = CheckListElement(5, "Zjeść obiad", false)
var f = CheckListElement(6, "Posprzątać pokój", false)
var g = CheckListElement(7, "Pójść do fryzjera", false)
var h = CheckListElement(1, "Naprawić kran", false)
var i = CheckListElement(4, "Wziąć prysznic", false)

var checkListElementArray = [a,b,c,d,e,f,g,h,i]
var test = CheckList(checkListElementArray)
a.delegate = test
b.delegate = test
c.delegate = test
d.delegate = test
e.delegate = test
f.delegate = test
g.delegate = test
h.delegate = test
i.delegate = test
a.zmienCzyWykonany()
test.wydrukujCoTrzeciElement()









