//
//  ViewDetailsViewController.swift
//  iKart
//
//  Created by Jasmin Infotech Private Limited on 28/11/24.
//

import UIKit
import Combine

class ViewDetailsViewController: UIViewController {
    
    var productId: Int?
    var product: Product?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var stockView: UIView!
    @IBOutlet weak var tagsView: UIView!
    @IBOutlet weak var skuView: UIView!
    @IBOutlet weak var weightView: UIView!
    @IBOutlet weak var dimensionsView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var warrentyInfoLabel: UILabel!
    @IBOutlet weak var shippingInfoLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var cartIcon: UIImageView!
    @IBOutlet weak var cartIconBtn: UIButton!
    
    
    var cartSubscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let productId = productId {
            print("Received product ID: \(productId)")
        }
        cartSubscription = CartManager.shared.$cartCount
            .sink { [weak self] count in
                self?.updateCartIcon(count: count)
            }
        initView()
        updateLabelUI()
    }
    
    deinit {
        cartSubscription?.cancel()
    }
    
    func initView(){
        
        discountView.layer.cornerRadius = 5.0
        discountView.layer.borderWidth = 1.0
        discountView.layer.borderColor = UIColor.black.cgColor
        discountView.layer.masksToBounds = true
        discountView.backgroundColor = UIColor.systemYellow
        
        ratingView.layer.cornerRadius = 5.0
        ratingView.layer.borderWidth = 1.0
        ratingView.layer.borderColor = UIColor.black.cgColor
        ratingView.layer.masksToBounds = true
        ratingView.backgroundColor = UIColor.systemYellow
        
        stockView.layer.cornerRadius = 5.0
        stockView.layer.borderWidth = 1.0
        stockView.layer.borderColor = UIColor.black.cgColor
        stockView.layer.masksToBounds = true
        stockView.backgroundColor = UIColor.systemYellow
        
        tagsView.layer.cornerRadius = 5.0
        tagsView.layer.borderWidth = 1.0
        tagsView.layer.borderColor = UIColor.black.cgColor
        tagsView.layer.masksToBounds = true
        tagsView.backgroundColor = UIColor.systemYellow
        
        skuView.layer.cornerRadius = 5.0
        skuView.layer.borderWidth = 1.0
        skuView.layer.borderColor = UIColor.black.cgColor
        skuView.layer.masksToBounds = true
        skuView.backgroundColor = UIColor.systemYellow
        
        weightView.layer.cornerRadius = 5.0
        weightView.layer.borderWidth = 1.0
        weightView.layer.borderColor = UIColor.black.cgColor
        weightView.layer.masksToBounds = true
        weightView.backgroundColor = UIColor.systemYellow
        
        dimensionsView.layer.cornerRadius = 5.0
        dimensionsView.layer.borderWidth = 1.0
        dimensionsView.layer.borderColor = UIColor.black.cgColor
        dimensionsView.layer.masksToBounds = true
        dimensionsView.backgroundColor = UIColor.systemYellow
        
        reviewBtn.layer.cornerRadius = 5.0
        reviewBtn.layer.borderWidth = 1.0
        reviewBtn.layer.masksToBounds = true
        reviewBtn.layer.borderColor = UIColor.black.cgColor
        reviewBtn.backgroundColor = UIColor.systemOrange
        
        addToCartBtn.layer.cornerRadius = 5.0
        addToCartBtn.layer.borderWidth = 1.0
        addToCartBtn.layer.masksToBounds = true
        addToCartBtn.layer.borderColor = UIColor.black.cgColor
        addToCartBtn.backgroundColor = UIColor.systemYellow
        
    }
    func updateLabelUI(){
        if let product = product {
            productIdLabel.text = "Product ID: \(product.id)"
            productNameLabel.text = "\(product.title)"
            if let imageUrl = URL(string: product.images.first ?? "") {
                URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.productImageView.image = image
                        }
                    }
                }.resume()
            }
            descriptionLabel.text = "\(product.description)"
            categoryLabel.text = "Category: \(product.category)"
            priceLabel.text = "Price: $\(product.price)"
            discountLabel.text = "\(product.discountPercentage)%"
            ratingLabel.text = "\(product.rating)"
            stockLabel.text = "\(product.stock)"
            tagsLabel.text = "\(product.formattedTags)"
            skuLabel.text = "\(product.sku)"
            weightLabel.text = "\(product.weight)"
            dimensionsLabel.text = "\(product.dimensions.formattedDimensions)"
            warrentyInfoLabel.text = "\(product.warrentyInformation ?? "No Information Available")"
            shippingInfoLabel.text = "\(product.shippingInformation ?? "No Information Available")"
            availabilityLabel.text = "\(product.availabilityStatus ?? "No Information Available")"
        }
    }
    
    func updateCartIcon(count: Int) {
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
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToCartBtnPressed(_ sender: Any) {
        CartManager.shared.addToCart(product: product!)
    }
    
    @IBAction func reviewBtnPressed(_ sender: Any) {
        
        if let product = product {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let reviewScreenObj = storyboard.instantiateViewController(identifier: "ReviewsViewController") as? ReviewsViewController{
                debugPrint("Product Reviews: \(product.reviews)")
                reviewScreenObj.reviews = product.reviews
                navigationController?.pushViewController(reviewScreenObj, animated: true)
            }
        }
        
    }
    
    @IBAction func cartIconBtnPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let cartScreenObj = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController{
            navigationController?.pushViewController(cartScreenObj, animated: true)
        }
    }
    
}










