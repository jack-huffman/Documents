//
//  DocumentCreatorViewController.swift
//  Documents
//
//  Created by Jack Huffman on 2/1/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class DocumentCreatorViewController: UIViewController {

    // Name of document
    @IBOutlet weak var name: UITextField!
    // Body of document
    @IBOutlet weak var body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveDocument(_ sender: UIBarButtonItem) {
        if name.text == nil {
            let alert = UIAlertController(title: "Name missing from note!", message: "Please give your note a name before saving.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        else {
            // save document
            let filemgr = FileManager.default
            let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
            let docsDir = dirPaths[0].path
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
