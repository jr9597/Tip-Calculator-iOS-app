//
//  ViewController.swift
//  KimJiryangHW4
//
//  Created by Jerrod Kim on 10/14/19.
//  Copyright © 2019 Jerrod Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var subTotalWithTipLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var segmentedControlTax: UISegmentedControl!
    @IBOutlet weak var switchButtonTaxForTip: UISwitch!
    @IBOutlet weak var sliderTip: UISlider!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var SliderTipLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var tipCalculatorLabel: UILabel!
    
    @IBOutlet weak var segmentedLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var staticSubtotalLabel: UILabel!
    @IBOutlet weak var includeTaxLabel: UILabel!
    @IBOutlet weak var evenSplitLabel: UILabel!
    @IBOutlet weak var staticTaxLabel: UILabel!
    @IBOutlet weak var staticTipLabel: UILabel!
    @IBOutlet weak var StaticTotalWithTip: UILabel!
    @IBOutlet weak var staticTotalPerPerson: UILabel!
    @IBOutlet weak var oneView: UIView!
    
    
    var billAmountNum: Double?
    var taxPercNum: Double?
    var tipPercNum: Int?
    var splitNum: Int?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        billAmount.returnKeyType = .done
        setDefaultValues()
        
        
        tipCalculatorLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipCalculaterLabel
        billLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.billLabel
        segmentedLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedLabel
        includeTaxLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxLabel
        evenSplitLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.evenSplitLabel
        staticTaxLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxLabel
        staticSubtotalLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalLabel
        staticTipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipLabel
        StaticTotalWithTip.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipLabel
        staticTotalPerPerson.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonLabel

        billAmount.accessibilityIdentifier = HW4AccessibilityIdentifiers.billTextField
        segmentedControlTax.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedTax
        switchButtonTaxForTip.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxSwitch
        sliderTip.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipSlider
        stepperOutlet.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitStepper
        resetButton.accessibilityIdentifier = HW4AccessibilityIdentifiers.resetButton
        
        taxLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxAmountLabel
        subtotalLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalAmountLabel
        tipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipAmountLabel
        subTotalWithTipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipAmountLabel
        totalPerPersonLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonAmountLabel
        SliderTipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.sliderLabel
        stepperLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitLabel
        oneView.accessibilityIdentifier = HW4AccessibilityIdentifiers.view
    }
    
    func setDefaultValues () {
        taxLabel.text = "$0.00"
        subtotalLabel.text = "$0.00"
        tipLabel.text = "$0.00"
        subTotalWithTipLabel.text = "$0.00"
        totalPerPersonLabel.text = "$0.00"
        stepperLabel.text = "1"
        sliderTip.value = 0
    }
    
    
    func reset() {
        billAmount.text = ""
        taxLabel.text = "$0.00"
        subtotalLabel.text = "$0.00"
        tipLabel.text = "$0.00"
        subTotalWithTipLabel.text = "$0.00"
        totalPerPersonLabel.text = "$0.00"
        segmentedControlTax.selectedSegmentIndex = 0
        sliderTip.value = 0
        SliderTipLabel.text = "0%"
        
        return
    }
    
    func updateUI() {
        
        tipPercNum = Int(sliderTip.value)
        
        splitNum = Int(stepperLabel.text ?? "1")
        
        if segmentedControlTax.selectedSegmentIndex == 0 {
            taxPercNum = 0.075
        }
        else if segmentedControlTax.selectedSegmentIndex == 1 {
            taxPercNum = 0.08
        }
        else if segmentedControlTax.selectedSegmentIndex == 2 {
            taxPercNum = 0.085
        }
        else if segmentedControlTax.selectedSegmentIndex == 3 {
            taxPercNum = 0.09
        }
        else if segmentedControlTax.selectedSegmentIndex == 4 {
            taxPercNum = 0.095
        }
        
        if let thisNum = billAmount.text {
            
            billAmountNum = Double(thisNum)
            guard let billamountdbl = billAmountNum, let taxPercdbl = taxPercNum else {

                return
            }
            let taxInNum = billamountdbl*taxPercdbl
            taxLabel.text = String(taxInNum)
//            let taxInNum = billamountdbl * taxPercNum

            
            if switchButtonTaxForTip.isOn {
                let taxSubtotalInNum = billamountdbl + taxInNum
                subtotalLabel.text = "$\(String(taxSubtotalInNum))"
                
                let sliderTipNum = Double(tipPercNum ?? 0)
                let tipInNum = taxSubtotalInNum * sliderTipNum/100
                tipLabel.text = "$\(String(format: "%.2f", tipInNum))"
                
                let subTotalWithTipLabelInNum = taxSubtotalInNum + tipInNum
                subTotalWithTipLabel.text = "$\(String(format: "%.2f", subTotalWithTipLabelInNum))"
                
                let totalPerPersonInNum = subTotalWithTipLabelInNum/Double(splitNum ?? 1)
                totalPerPersonLabel.text = "$\(String(format: "%.2f", totalPerPersonInNum))"
            }
            
            else if !switchButtonTaxForTip.isOn {
                subtotalLabel.text = thisNum
                
                let noTaxSubtotalInNum = Double(thisNum)
                let sliderTipInNum = Double(tipPercNum ?? 0)
                let tipInNum = (noTaxSubtotalInNum ?? 0) * sliderTipInNum/100
                tipLabel.text = "$\(String(format: "%.2f", tipInNum))"
                
                let subTotalWithTipLabelInNum = (noTaxSubtotalInNum ?? 0) + tipInNum + taxInNum
                subTotalWithTipLabel.text = "$\(String(format: "%.2f", subTotalWithTipLabelInNum))"
                
                let totalPerPersonInNum = subTotalWithTipLabelInNum/Double(splitNum ?? 0)
                totalPerPersonLabel.text = "$\(String(format: "%.2f", totalPerPersonInNum))"
            }
            
        }
        
        
    }
    
    @IBAction func taxAmountSelected(_ sender: UISegmentedControl) {
        billAmount.resignFirstResponder()
        updateUI()
//            switch sender.selectedSegmentIndex {
//            case 0: if let tax = billAmountMoney{
//                taxPercNum = 0.075
//                let taxOneValue = tax*(0.075)
//                taxLabel.text = String(taxOneValue)
//                }
//            case 1: if let tax = billAmountMoney{
//                taxPercNum = 0.08
//                let taxOneValue = tax*(0.08)
//                taxLabel.text = String(taxOneValue)
//                }
//            case 2: if let tax = billAmountMoney{
//                taxPercNum = 0.085
//                let taxOneValue = tax*(0.085)
//                taxLabel.text = String(taxOneValue)
//                }
//            case 3: if let tax = billAmountMoney{
//                taxPercNum = 0.09
//                let taxOneValue = tax*(0.09)
//                taxLabel.text = String(taxOneValue)
//                }
//            case 4: if let tax = billAmountMoney{
//                taxPercNum = 0.095
//                let taxOneValue = tax*(0.095)
//                taxLabel.text = String(taxOneValue)
//                }
//            default: break
//            }
        
    }
    
    @IBAction func taxForTipSwitched(_ sender: UISwitch) {
        updateUI()
    }
    
    @IBAction func tipAmountedSlided(_ sender: UISlider) {
        updateUI()
        SliderTipLabel.text = "\( String(Int(sliderTip.value)))%"
    }
    
    @IBAction func splitNumberStepped(_ sender: UIStepper) {
        stepperLabel.text = String(Int(sender.value))
        updateUI()
        
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {

        let alertController = UIAlertController(title: "Are you sure?",
        message: "Resetting will delete everything",
        preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let resetAction = UIAlertAction(title: "Reset", style: .destructive, handler:
        {(action) in self.reset()})
        
        alertController.addAction(cancelAction)
        alertController.addAction(resetAction)
        
        self.present(alertController, animated: true, completion: nil)
        
 
    }
    
    @IBAction func tappedBackground(_ sender: UITapGestureRecognizer) {
        billAmount.resignFirstResponder()
        updateUI()
    }
    
}

