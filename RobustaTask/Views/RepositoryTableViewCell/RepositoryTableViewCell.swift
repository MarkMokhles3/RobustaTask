//
//  RepositoryTableViewCell.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 04/11/2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var imgRepoOwner: UIImageView!
    @IBOutlet weak var lblRepoNameValue: UILabel!
    @IBOutlet weak var lblCreationDateValue: UILabel!
    @IBOutlet weak var lblRepoOwnerNameValue: UILabel!
    @IBOutlet weak var viewContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func configureCell(with repository: Repository) {
        lblRepoNameValue.text = repository.repositoryName
        guard let owner = repository.owner else { return }
        lblRepoOwnerNameValue.text = owner.repositoryOwnerName
        guard let imageURL = owner.ownerImageURL else { return }
        imgRepoOwner.load(urlString: imageURL)
    }

    func setupView() {
        imgRepoOwner.setRoundCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 5)
        //Set corner and shadow to view
        viewContainer.setCornerRadius(radius: 5)
        viewContainer.setShadow(radius: 1, opacity: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
