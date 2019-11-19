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
    
    var pulsatingLayer : CAShapeLayer!

    @IBOutlet weak var lbCali: UILabel!
    
    var top5 = ["Ana", "Maggie", "Angel", "Noe", "Mariana"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = CGPoint(x: self.view.bounds.midX, y: 250)
        
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //Animacion de pulso de fondo
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = #colorLiteral(red: 0.9808917642, green: 0.614590168, blue: 0.6713882089, alpha: 1)
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
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 18
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        shapeLayer.position = center
        
        view.layer.addSublayer(shapeLayer)
        
        // Crea la animacion del circulo
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.9
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basic")
        
        view.addSubview(lbCali)
       // Añade un tap para que regrese al inicio
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        top5.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        cell.textLabel?.text = top5[indexPath.row]
        
        
        return cell

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
