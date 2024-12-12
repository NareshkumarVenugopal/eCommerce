//
//  CartViewController.swift
//  iKart
//
//  Created by Jasmin Infotech Private Limited on 28/11/24.
//

import UIKit

class CartViewController: UIViewController {
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var placeOrderBtn: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    
    var cartItems: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: "CartIdentifier")
        cartItems = CartManager.shared.getCartItems()
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.reloadData()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func placeOrderBtnPressed(_ sender: Any) {
        CartManager.shared.cartCount = 0
        CartManager.shared.clearCart()
        cartItems.removeAll()  
        productTableView.reloadData()
        let alert = UIAlertController(title: "Order Placed", message: "Your order has been placed successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let homeViewObj = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController{
                self.navigationController?.pushViewController(homeViewObj, animated: true)
            }
        }))
            
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint("Cart Items: \(cartItems.count)")
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartIdentifier", for: indexPath) as! CartTableViewCell
        let product = cartItems[indexPath.row]
        cell.productName.text = product.title
        if let imageUrl = URL(string: product.images.first ?? "") {
            URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.productImage.image = image
                    }
                }
            }.resume()
        }
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
