//
//  ReviewsViewController.swift
//  iKart
//
//  Created by Jasmin Infotech Private Limited on 28/11/24.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    var reviews: [Review] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
        reviewTableView.register(nib, forCellReuseIdentifier: "ReviewIdentifier")
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.reloadData()
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewIdentifier", for: indexPath) as! ReviewsTableViewCell
        let review = reviews[indexPath.row]
        cell.ratingLabel.text = "Rating: \(review.rating)"
        cell.commentLabel.text = review.comment
        cell.nameLabel.text = review.reviewerName
        cell.dateLabel.text = review.date
        cell.emailLabel.text = review.reviewerEmail
        
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
