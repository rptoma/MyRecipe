//
//  RecipeTableViewCell.swift
//  MyRecipe
//
//  Created by Toma Radu-Petrescu on 17/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var uid: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func loadImage(from imgUrl: String?) {
        if let imgUrl = imgUrl {
            RequestManager().requestImage(for: imgUrl, completionHandler: { (image) in
                if let image = image {
                    self.backgroundImageView.image = image
                }
                else {
                    self.backgroundImageView.image = UIImage(named: Base.DEFAULT_IMAGE_PATH)
                }
            })
        }
        else {
            backgroundImageView.image = UIImage(named: Base.DEFAULT_IMAGE_PATH)
        }
    }
    
    public func loadRecipePreview(recipe: Recipe) {
        nameLabel.text = recipe.name
        durationLabel.text = "~" + TimeConverter.getTime(from: recipe.duration ?? 0)
        difficultyLabel.text = recipe.difficulty
        uid = recipe.uid
        loadImage(from: recipe.icon_image)
    }
    
}
