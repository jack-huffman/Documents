//
//  DocumentTableViewController.swift
//  Documents
//
//  Created by Jack Huffman on 1/31/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class DocumentTableViewController: UITableViewController {
    
    //Nav bar button
    @IBOutlet weak var newDocumentBtn: UIBarButtonItem!
    
    // Documents array
    var documents: [Document] = []
    
    // Documents location
    let documentsLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    // Date formatter
    var dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        documents = loadDocs()
        self.tableView.reloadData()

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return documents.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "documentCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let cell = cell as? DocumentTableViewCell {
            
            let doc = documents[indexPath.row]
            cell.titleLabel.text = doc.title
            cell.modifiedLabel.text = "Modified: " + dateFormatter.string(from: doc.dateModified)
            cell.sizeLabel.text = "Size: \(doc.size)"
        
        }
        return cell
    }

    func loadDocs() -> [Document] {
        var foundDocs = [Document]()
        
        do {
            let files = try FileManager.default.contentsOfDirectory(at: documentsLocation, includingPropertiesForKeys: nil)
            
            for file in files {
                let fileName = documentsLocation.appendingPathComponent(file.lastPathComponent)
                if let date = file.modificationDate {
                    let size = file.size
                    do {
                        let data = try Data(contentsOf: fileName, options: .mappedIfSafe)
                        let decoder = JSONDecoder()
                        let document = try decoder.decode(Document.self, from: data)
                    
                        foundDocs.append(Document(title: document.title, body: document.body, dateModified: date, size: size))
                    } catch let err {
                        print("Could not read documents", err)
                    }
                }
                
            }
        } catch {
            print("Error while enumerating files \(documentsLocation.path): \(error.localizedDescription)")
        }
        
        return foundDocs
    }
    
    @IBAction func newDocBtn(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "openDocument", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "openDocument", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prep code here
        if let destination = segue.destination as? DocumentCreatorViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let row = indexPath.row
                let selectedDoc = self.documents[row]
                destination.currentDoc = selectedDoc
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try FileManager.default.removeItem(at: documentsLocation.appendingPathComponent("\(documents[indexPath.row].title).json"))
            } catch let err {
                print("Could not delete file", err)
            }
            documents.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
