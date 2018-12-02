//
//  ViewController.swift
//  Pantry Parooser
//
//  Created by Pranav Suby on 12/1/18.
//  Copyright © 2018 popolok11. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textField: UITextField!
    var ingredient = Array<String>()
    var labels = Array<UILabel>()
    var amount = Array<Int>()
    var numLabelAmount = Array<UILabel>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func enterBtnPressed(_ sender: Any) {
        if textField.text != "" {
            var item = textField.text!
            ingredient.append(item)
            item = ""
            let itemNum = ingredient.count - 1
            textField.text = ""
            addList(yVal: itemNum)
        }
        
    }
    func addList(yVal: Int) {
        let width = Int(scrollView.frame.width)
        let image = UIImage(named: "redX") as UIImage?
        let minusImage = UIImage(named: "minus") as UIImage?
        let plusImage = UIImage(named: "plus") as UIImage?
        let label = UILabel(frame: CGRect(x: 50, y: yVal*20, width: 100, height: 20))
        label.textColor = .black
        label.text = ingredient[yVal]
        labels.append(label)
        let labelX = Int(label.frame.maxX)
        //Button
        let button = UIButton(frame: CGRect(x: labelX + 10, y: yVal*20, width: 20, height: 20))
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //Other Label
        let numLabel = UILabel(frame: CGRect(x: width-50, y: yVal*20, width: 20, height: 20))
        numLabel.textColor = .black
        amount.append(1)
        numLabel.text = String(amount[yVal])
        numLabelAmount.append(label)
        //Other Buttons
        let minus = UIButton(frame: CGRect (x: width - 80, y: yVal*20, width: 20, height: 20))
        minus.setImage(minusImage, for: .normal)
        minus.addTarget(self, action: #selector(minusPressed), for: .touchUpInside)
        let plus = UIButton(frame: CGRect (x: width - 110, y: yVal*20, width: 20, height: 20))
        plus.setImage(plusImage, for: .normal)
        plus.addTarget(self, action: #selector(plusPressed), for: .touchUpInside)
        self.scrollView.addSubview(numLabel)
        self.scrollView.addSubview(label)
        self.scrollView.addSubview(button)
        self.scrollView.addSubview(minus)
        self.scrollView.addSubview(plus)
    }
    @objc func buttonAction(sender: UIButton!) {
        let valOfIndex = Int(sender.frame.minY/20)
        let label = labels[valOfIndex]
        ingredient.remove(at: valOfIndex)
        labels.remove(at: valOfIndex)
        label.removeFromSuperview()
        sender.removeFromSuperview()
        redoList()
    }
    
    @objc func minusPressed(sender: UIButton!) {
        let valOfIndex = Int(sender.frame.minY/20)
        var valOfItem = amount[valOfIndex]
        valOfItem = valOfItem - 1
        amount[valOfIndex] = valOfItem
        if valOfItem == 0 {
            let label = labels[valOfIndex]
            ingredient.remove(at: valOfIndex)
            labels.remove(at: valOfIndex)
            numLabelAmount.remove(at: valOfIndex)
            label.removeFromSuperview()
            sender.removeFromSuperview()
            redoList()
        } else {
            redoList()
        }
        
    }
    
    @objc func plusPressed(sender: UIButton!) {
        let valOfIndex = Int(sender.frame.minY/20)
        var valOfItem = amount[valOfIndex]
        valOfItem = valOfItem + 1
        amount[valOfIndex] = valOfItem
        redoList()
    }
    
    func redoList() {
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        for i in 0..<ingredient.count {
            let width = Int(scrollView.frame.width)
            let image = UIImage(named: "redX") as UIImage?
            let minusImage = UIImage(named: "minus") as UIImage?
            let plusImage = UIImage(named: "plus") as UIImage?
            let label = UILabel(frame: CGRect(x: 50, y: i*20, width: 100, height: 20))
            label.textColor = .black
            label.text = ingredient[i]
            labels.append(label)
            let labelX = Int(label.frame.maxX)
            let button = UIButton(frame: CGRect(x: labelX + 10, y: i*20, width: 20, height: 20))
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.scrollView.addSubview(label)
            self.scrollView.addSubview(button)
            let numLabel = UILabel(frame: CGRect(x: width-50, y: i*20, width: 20, height: 20))
            numLabel.textColor = .black
            amount.append(1)
            numLabel.text = String(amount[i])
            self.scrollView.addSubview(numLabel)
            //Other Buttons
            let minus = UIButton(frame: CGRect (x: width - 80, y: i*20, width: 20, height: 20))
            minus.setImage(minusImage, for: .normal)
            minus.addTarget(self, action: #selector(minusPressed), for: .touchUpInside)
            let plus = UIButton(frame: CGRect (x: width - 110, y: i*20, width: 20, height: 20))
            plus.setImage(plusImage, for: .normal)
            plus.addTarget(self, action: #selector(plusPressed), for: .touchUpInside)
            self.scrollView.addSubview(minus)
            self.scrollView.addSubview(plus)
        }
    }
    
}

