//
//  ViewControllerResultado.swift
//  CulturaVisual
//
//  Created by Maggie Jimenez Herrera on 11/1/19.
//  Copyright © 2019 Maggie Jimenez Herrera. All rights reserved.
//

import UIKit

class ViewControllerResultado: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let shapeLayer = CAShapeLayer()
    
    var preCorrectas : Int!
    var pulsatingLayer : CAShapeLayer!
    var gradientLayer : CAGradientLayer!
    
    var UserData: User!
    var strIdGroup: String!
    var strIdQuiz : String!
    var strIdTema : String!
    var percentage : CGFloat!
    var preTotales : Int!

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbCalificacion: UILabel!
    @IBOutlet weak var lbRes: UILabel!
    
    @IBOutlet weak var lbTop: UILabel!
    
    var top5 : [Grade] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = true
        setUpLayout()
        percentage = CGFloat(preCorrectas) / CGFloat(preTotales)
        postGrade()
        
        let center = CGPoint(x: self.view.bounds.midX, y: 260)
        
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 90, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //Animacion de pulso de fondo
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = #colorLiteral(red: 0.6328135729, green: 0.7647476196, blue: 0.9493692517, alpha: 1)
        pulsatingLayer.lineWidth = 10
        pulsatingLayer.fillColor = UIColor.clear.cgColor
        pulsatingLayer.lineCap = .round
        pulsatingLayer.position = center
        view.layer.addSublayer(pulsatingLayer)
        
        // Circulo de fondo
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 18
        trackLayer.fillColor = #colorLiteral(red: 0.9018729329, green: 0.9020258784, blue: 0.9875420928, alpha: 1)
        trackLayer.lineCap = .round
        trackLayer.position = center
        view.layer.addSublayer(trackLayer)
        
        animatedPulsatingLAyer()
        
        
        // Circulo animado
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.2619800568, green: 0.5278556943, blue: 0.8930467367, alpha: 1)
        shapeLayer.lineWidth = 18
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        shapeLayer.position = center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        lbCalificacion.text = "\(Int(percentage * 100))%"
        
        view.layer.addSublayer(shapeLayer)
        
        // Crea la animacion del circulo
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = percentage
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basic")
        
        view.addSubview(lbCalificacion)
        
        
       // Añade un tap para que regrese al inicio
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    //MARK:- Funcion de la animacion
    //===============================================
    func animatedPulsatingLAyer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.15
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    //Funcion que te regresa al root del navigation controller 
    @objc func handleTap() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func postGrade(){
        GradesAPI.shared.postGrade(
            strIdGroup: strIdGroup,
            strIdSubject: strIdTema,
            strIdQuiz: strIdQuiz,
            intGrade: Int(percentage * 100),
            user: UserData
        ) { (res) in
            switch res{
            case .failure(let err as NSError):
                //manejar errores
                var ErrorCode: String = "";
                var ErrorMessage: String = "";
                if(
                    //Client error
                    err.code >= 400 &&
                    err.code < 600
                    ){
                    ErrorCode = "\(err.code)"
                    ErrorMessage = err.userInfo["message"]! as! String
                } else {
                    ErrorMessage = err.localizedDescription;
                }
                
                self.showAlert(
                    strType: "Error",
                    strCode: ErrorCode,
                    strMessage: ErrorMessage
                )
            case .success(let res):
                //igual arreglo para desplegar tabla de grades
                print(res[0].strName)
                self.top5 = res
                self.tableView.reloadData()
            }
        }
        
    }
            
    

    func showAlert(
        strType: String,
        strCode: String,
        strMessage: String
    ) {
        let alert = UIAlertController(
            title: strType,
            message: strMessage,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: "Ok",
            style: .cancel,
            handler: nil
        )
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        top5.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        cell.textLabel?.text = top5[indexPath.row].strName
        cell.detailTextLabel?.text = top5[indexPath.row].intGrade
        
        return cell

    }
    

    // MARK:- Constrains
    //=============================
    func setUpLayout(){
        
        //
        lbRes.translatesAutoresizingMaskIntoConstraints = false
    lbCalificacion.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        lbTop.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Contrains label Resultado
        lbRes.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        lbRes.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Constrains label calificacion
        lbCalificacion.topAnchor.constraint(equalTo: lbRes.bottomAnchor, constant: 90).isActive = true
        lbCalificacion.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Constrains del tableview
        tableView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 90).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: 343).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        //Constrains del top5
        lbTop.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 0).isActive = true
        lbTop.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
