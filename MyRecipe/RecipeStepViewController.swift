//
//  RecipeStepViewController.swift
//  MyRecipe
//
//  Created by Alexandru Radu on 22/04/2017.
//  Copyright © 2017 Toma Radu-Petrescu. All rights reserved.
//

import UIKit
import AVFoundation

class RecipeStepViewController: UIViewController {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskDescriptionView: UITextView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var taskCounter:Int = 0
    
    var recipeSteps:[RecipeStep] = [RecipeStep]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButtonOutlet.layer.cornerRadius = 10
        
        updateTask()
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        updateTask()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        readTaskDescription(enable: false)
        
    }
    
    func updateTask(){
        if taskCounter < recipeSteps.count {
            
            readTaskDescription(enable: false)
            if taskCounter == recipeSteps.count - 1 {
                nextButtonOutlet.setTitle("Finish", for: UIControlState.normal)
            }
            taskLabel.text = recipeSteps[taskCounter].task
            taskDescriptionView.text = recipeSteps[taskCounter].description
            readTaskDescription(enable: true)
            taskCounter += 1
            
        }
        else {
            finishMessageAlert()
        }
    }
    
    func finishMessageAlert(){
        let alert = UIAlertController(title: "Congratulations!", message: "You have cooked a dish.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.backToDetailView()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func readTaskDescription(enable:Bool){
        let speechUtterance = AVSpeechUtterance(string: taskDescriptionView.text)
        
        if enable == true{
            speechSynthesizer.speak(speechUtterance)
        }
        else {
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    
    func backToDetailView(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    
}
