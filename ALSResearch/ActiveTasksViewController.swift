//
//  ActiveTasksViewController.swift
//  HealthTechApp
//
//  Created by arpitsabherwal on 09/03/17.
//  Copyright © 2017 arpitsabherwal. All rights reserved.
//

import UIKit
import ResearchKit
import CoreData
import MessageUI


class ActiveTasksViewController: UITableViewController,ORKTaskViewControllerDelegate,MFMailComposeViewControllerDelegate {
   
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if ((indexPath as NSIndexPath).row == 0){
            let taskViewController = ORKTaskViewController(task: FingerTappingTask, taskRun: nil)
            taskViewController.delegate = self
            taskViewController.outputDirectory=NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] , isDirectory: true) as URL
            present(taskViewController, animated: true, completion: nil)
        }
        else if ((indexPath as NSIndexPath).row == 1){
            let vc : UIViewController! = self.storyboard!.instantiateViewController(withIdentifier: "StepCount")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if ((indexPath as NSIndexPath).row == 2){
            let vc : UIViewController! = self.storyboard!.instantiateViewController(withIdentifier: "StepCount")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        print(taskViewController.result)
        //print(taskViewController.outputDirectory.)
        print("Results ");
        saveData(step_result: taskViewController.result)
        
        taskViewController.dismiss(animated: true, completion: nil)
        
    }
    func saveData(step_result:ORKResult){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
                let managedContext =
            appDelegate.persistentContainer.viewContext
        
        
        let entity =
            NSEntityDescription.entity(forEntityName: "FingerTapping",
                                       in: managedContext)!
        
        let data_values = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        
        
        data_values.setValue(String(describing: step_result), forKeyPath: "result")
        
        
        do {
            try managedContext.save()
            print("Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

