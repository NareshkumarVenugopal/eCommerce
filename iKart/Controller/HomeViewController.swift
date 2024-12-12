//
//  ViewController.swift
//  iKart
//
//  Created by Jasmin Infotech Private Limited on 27/11/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var productListTableView: UITableView!
    @IBOutlet weak var cartIcon: UIImageView!
    @IBOutlet weak var cartIconBtn: UIButton!
    
    let searchImageIcon = UIImage(named: "search_icon")
    var products = [Product]()
    let productViewModel = ProductViewModel.instance
    var cartSubscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        fetchProducts()
        debugPrint("Product count: \(products.count)")
        cartSubscription = CartManager.shared.$cartCount
            .sink { [weak self] count in
                self?.updateCartBadge(count: count)
            }
    }
    
    deinit {
        cartSubscription?.cancel()
    }
    
    func initView(){
        setupTextField()
        setupTableViewCell()
        updateCartBadge(count: CartManager.shared.cartCount)

    }
    
    func updateCartBadge(count: Int) {
         if let cartBadge = cartIcon.subviews.first(where: { $0 is UILabel }) as? UILabel {
             cartBadge.text = "\(count)"
         } else {
             let cartBadge = UILabel()
             cartBadge.frame = CGRect(x: cartIcon.frame.width - 20, y: 0, width: 20, height: 20)
             cartBadge.text = "\(count)"
             cartBadge.textColor = .white
             cartBadge.textAlignment = .center
             cartBadge.backgroundColor = .red
             cartBadge.layer.cornerRadius = 10
             cartBadge.clipsToBounds = true
             cartIcon.addSubview(cartBadge)
         }
     }
    
    func setupTableViewCell(){
        let nib = UINib(nibName: "ProductListTableViewCell", bundle: nil)
        productListTableView.register(nib, forCellReuseIdentifier: "ProductListIdentifier")
        productListTableView.delegate = self
        productListTableView.dataSource = self
    }
    
    func setupTextField() {
        let imageView = UIImageView(image: searchImageIcon)
        imageView.contentMode = .scaleAspectFit
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: searchTextField.frame.height))
        imageView.frame = CGRect(x: 10, y: (leftPaddingView.frame.height - 20) / 2, width: 20, height: 20)
        leftPaddingView.addSubview(imageView)
        searchTextField.leftView = leftPaddingView
        searchTextField.leftViewMode = .always
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.borderColor = UIColor.black.cgColor
        searchTextField.layer.cornerRadius = 8.0
        searchTextField.layer.shadowColor = UIColor.black.cgColor
        searchTextField.layer.shadowOpacity = 0.1
        searchTextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchTextField.layer.shadowRadius = 4
    }
    
    func fetchProducts() {
        productViewModel.fetchProducts { [weak self] in
            self?.products = self?.productViewModel.products ?? []
            self?.productListTableView.reloadData()
            debugPrint("Product count: \(self?.products.count ?? 0)")
        }
    }
    
    @IBAction func cartIconBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let cartScreenObj = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController{
            navigationController?.pushViewController(cartScreenObj, animated: true)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListIdentifier", for: indexPath) as! ProductListTableViewCell
        let product = products[indexPath.row]
        cell.productIdLabel.text = "Product ID: \(product.id)"
        cell.productNameLabel.text = product.title
        if let imageUrl = URL(string: product.images.first ?? "") {
            URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.productImage.image = image
                    }
                }
            }.resume()
        }
        
        cell.viewDetailsBtn.layer.cornerRadius = 5.0
        cell.viewDetailsBtn.layer.borderWidth = 1.0
        cell.viewDetailsBtn.layer.masksToBounds = true
        cell.viewDetailsBtn.layer.borderColor = UIColor.black.cgColor
        cell.viewDetailsBtn.backgroundColor = UIColor.systemOrange
        cell.viewDetailsBtn.tag = product.id
        cell.viewDetailsBtn.addTarget(self, action: #selector(viewDetailsButtonTapped(_:)), for: .touchUpInside)
        
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
    

    @objc func viewDetailsButtonTapped(_ sender: UIButton){
        let productId = sender.tag
        if let product = products.first(where: { $0.id == productId }) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewProductObj = storyboard.instantiateViewController(identifier: "ViewDetailsViewController") as? ViewDetailsViewController {
                viewProductObj.productId = product.id
                viewProductObj.product = product
                navigationController?.pushViewController(viewProductObj, animated: true)
            }
        }
    }
}


