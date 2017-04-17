//
//  GraphicsUtilities.swift
//  MyRecipe
//
//  Created by Alexandru Radu on 18/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//


import Foundation
import UIKit


class GraphicsUtilities{
    
    func applyBlurEffect(image: UIImage) -> UIImage{
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        let resultImage = blurfilter!.value(forKey: "outputImage") as! CIImage
        let blurredImage = UIImage(ciImage: resultImage)
        return blurredImage
    }
    
}
