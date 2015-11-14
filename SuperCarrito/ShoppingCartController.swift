//
//  ShoppingCartController.swift
//  SuperCarrito
//
//  Created by Rodolfo Castillo on 14/11/15.
//  Copyright © 2015 Rodolfo Castillo. All rights reserved.
//

import UIKit


class ShoppingCartController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Mark: Variables
    let ShoppingList0 = ShoppingList()
    var sections = [Int]()
    let ScreenSize: CGRect = UIScreen.mainScreen().bounds
    var screenHeight: CGFloat!
    var screenWidth: CGFloat!
    let m = tinyBits()
    
    //Mark: Outlets
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var addProductButton: UIButton!
    @IBOutlet weak var Scanner: ReaderController!
    @IBOutlet weak var submitButton: UIButton!
    //Mark: Actions
    @IBAction func addProductButtonTapped(){
        if self.addProductButton.titleLabel?.text == "Cancel"{
            self.Scanner.captureSession.stopRunning()
            self.hideScanner()
            self.addProductButton.setTitle("Add", forState: UIControlState.Normal)

        } else {
            presentScanner()
            self.addProductButton.setTitle("Cancel", forState: UIControlState.Normal)
            self.Scanner.scannerDidLoad()
            self.Scanner.captureSession.startRunning()
        }
    }
    //Mark: Methods
    func getTotal()->Float{
        var total: Float = 0
        for i in self.ShoppingList0.list!{
            total += Float(i.precio)!
            print(total)
        }
        return total
    }
    func addItem(id: String){
        self.ShoppingList0.addItems("Another Product", price: "10", id: id)
        self.getTotal()
        self.productTable.reloadData()
        self.submitButton.setTitle( String(format: "Total: %.2f", getTotal()), forState: UIControlState.Normal)
    }
    func anItemWasAdded(){
        if Scanner.readData.text != "" {
            addItem(Scanner.readData.text!)
        } else {
            
        }
        self.Scanner.readData.text = ""
    }
    func presentScanner(){
        UIView.animateWithDuration(1/3, animations: {
            self.Scanner.transform = CGAffineTransformMakeTranslation(0, self.screenHeight)
        })
    }
    func hideScanner(){
        UIView.animateWithDuration(1/3, animations: {
            self.Scanner.transform = CGAffineTransformMakeTranslation(0, -self.screenHeight)
        })
        self.anItemWasAdded()
    }
    //Mark: View Methods 
    override func viewDidLoad(){
        self.sections = [ShoppingList0.list!.count]
        self.screenWidth = ScreenSize.width
        self.screenHeight = ScreenSize.height
        self.Scanner.center = CGPointMake(self.screenWidth/2, -self.screenHeight)
        self.ShoppingList0.addItems("RedBull", price: "49.50", id: "01")
        self.ShoppingList0.addItems("Amazon Girl", price: "700", id: "02")
        self.submitButton.setTitle( String(format: "Total: %.2f", getTotal()), forState: UIControlState.Normal)
        super.viewDidLoad()
        view.bringSubviewToFront(Scanner)
    }
    //Mark: TableViewMethods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ShoppingList0.list!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell54")! as! cellt
            cell.titleLabel?.text = "Precio total"
            cell.priceLabel.text = "Total: \(getTotal())"
            cell.idLabel.text = "Total ya con descuentos disponibles."
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell54")! as! cellt
            cell.titleLabel?.text = ShoppingList0.list![indexPath.row].nombre
            cell.priceLabel.text = String(format: "%.2f", (Float(ShoppingList0.list![indexPath.row].precio)!))
            cell.idLabel.text = ShoppingList0.list![indexPath.row].ID
            return cell
        }
        
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return "Articulos"
    }
    
    
    
}
