//
//  ViewControllerPregunta.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 11/1/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerPregunta: UIViewController {

    //Creacion de variables
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var bt3: UIButton!
    @IBOutlet weak var bt4: UIButton!
    @IBOutlet weak var lbNum: UILabel!
    @IBOutlet weak var lbPregunta: UILabel!
    var cont = 0
    var listaPreguntas : [String]!
    var listaRespuestas : [String]!
    var listaRespuestas2 : [String]!
    var res1 = 0
    var res2 = 1
    var res3 = 2
    var res4 = 3
    
    
    override func viewDidAppear(_ animated: Bool) {
        newQuestion()
    }
    
    
    //Funcion para que las respuestas esten en diferente orden
    func nombreBt() {
        
        //Agarra un elemento al azar y despues lo borra del arreglo para que no se repitan respuestas
        var randAnwser = listaRespuestas2.randomElement()
        bt1.setTitle(randAnwser, for: .normal)
        if let index = listaRespuestas2.firstIndex(of: randAnwser!){
            listaRespuestas2.remove(at: index)
        }
        randAnwser = listaRespuestas2.randomElement()
        bt2.setTitle(randAnwser, for: .normal)
        if let index = listaRespuestas2.firstIndex(of: randAnwser!){
            listaRespuestas2.remove(at: index)
        }
        randAnwser = listaRespuestas2.randomElement()
        bt3.setTitle(randAnwser, for: .normal)
        if let index = listaRespuestas2.firstIndex(of: randAnwser!){
                   listaRespuestas2.remove(at: index)
        }
        bt4.setTitle(listaRespuestas2[0], for: .normal)
    }

    @IBAction func seleccionar(_ sender: Any) {
        let respuestabt = bt2.currentTitle
        var resCorrecta : String!
        
        //Checa cual es la respuesta correcta de la pregunta
        switch cont {
        case 0:
            resCorrecta = listaRespuestas[res1]
            break;
        case 1:
            resCorrecta = listaRespuestas[res2]
            break;
        case 2:
            resCorrecta = listaRespuestas[res3]
            break;
        default:
            resCorrecta = listaRespuestas[res4]
            break;
        }
        //Compara la respuesta del boton seleccionado con la respuesta correcta
        if respuestabt == resCorrecta{
            bt2.layer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        else{
            bt2.layer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
        cont += 1
        print("Antes")
        //Delay para mostrar la siguiente pregunta
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            print("Despues de 5 seg")
            if self.cont < 4 {
                self.newQuestion()
            }
        }
    }
    
    @IBAction func seleccionar2(_ sender: Any) {
        let respuestabt = bt1.currentTitle
        var resCorrecta : String!
        switch cont {
        case 0:
            resCorrecta = listaRespuestas[res1]
            break;
        case 1:
            resCorrecta = listaRespuestas[res2]
            break;
        case 2:
            resCorrecta = listaRespuestas[res3]
            break;
        default:
            resCorrecta = listaRespuestas[res4]
            break;
        }
        
        print(resCorrecta!)
        print(respuestabt!)
        
        if respuestabt == resCorrecta{
            bt1.layer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        else{
            bt1.layer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
        cont += 1
        
        print("Antes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            print("Despues de 5 seg")
            if self.cont < 4 {
                self.newQuestion()
            }
        }
    }
    
    
    @IBAction func seleccionar3(_ sender: Any) {
        let respuestabt = bt3.currentTitle
        var resCorrecta : String!
        switch cont {
        case 0:
            resCorrecta = listaRespuestas[res1]
            break;
        case 1:
            resCorrecta = listaRespuestas[res2]
            break;
        case 2:
            resCorrecta = listaRespuestas[res3]
            break;
        default:
            resCorrecta = listaRespuestas[res4]
            break;
        }
        
        print(resCorrecta!)
        print(respuestabt!)
        
        if respuestabt == resCorrecta{
            bt3.layer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        else{
            bt3.layer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
        print("Antes")
        cont += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            print("Despues de 5 seg")
            if self.cont < 4 {
                self.newQuestion()
            }
        }
    }
    
    @IBAction func seleccionar4(_ sender: Any) {
        let respuestabt = bt4.currentTitle
        var resCorrecta : String!
        switch cont {
        case 0:
            resCorrecta = listaRespuestas[res1]
            break;
        case 1:
            resCorrecta = listaRespuestas[res2]
            break;
        case 2:
            resCorrecta = listaRespuestas[res3]
            break;
        default:
            resCorrecta = listaRespuestas[res4]
            break;
        }
        
        print(resCorrecta!)
        print(respuestabt!)
        
        if respuestabt == resCorrecta{
            bt4.layer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        else{
            bt4.layer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
        print("Antes")
        cont += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            print("Despues de 2.5 seg")
            if self.cont < 4 {
                self.newQuestion()
            }
        }
    }
    
    func newQuestion(){
        listaPreguntas = ["Cuanto es 2 + 2", "Cuanto es 3 + 3?", "Cuanto es 4 * 4?", "Cuanto es 5 - 3?"]
        listaRespuestas = ["4", "6", "16", "2"]
        listaRespuestas2 = ["4", "6", "16", "2"]
        lbPregunta.text = listaPreguntas[cont]
        lbNum.text = "\(cont + 1)"
        nombreBt()
        bt1.layer.backgroundColor = UIColor.clear.cgColor
        bt2.layer.backgroundColor = UIColor.clear.cgColor
        bt3.layer.backgroundColor = UIColor.clear.cgColor
        bt4.layer.backgroundColor = UIColor.clear.cgColor
        bt1.layer.cornerRadius = 5
        bt1.layer.borderWidth = 3
        bt1.layer.borderColor = UIColor.black.cgColor
        bt2.layer.cornerRadius = 5
        bt2.layer.borderWidth = 3
        bt2.layer.borderColor = UIColor.black.cgColor
        bt3.layer.cornerRadius = 5
        bt3.layer.borderWidth = 3
        bt3.layer.borderColor = UIColor.black.cgColor
        bt4.layer.cornerRadius = 5
        bt4.layer.borderWidth = 3
        bt4.layer.borderColor = UIColor.black.cgColor
        
    }
    
    //Checa que no haga el segue si aun no pasan todas las preguntas
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if cont < 3{
            return false
        }
            return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
