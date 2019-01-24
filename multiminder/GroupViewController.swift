//
//  GroupViewController.swift
//  multiminder
//
//  Created by Viktor Yamchinov on 23/01/2019.
//  Copyright © 2019 Viktor Yamchinov. All rights reserved.
//

import UIKit

class GroupViewController: UITableViewController {
    
    weak var delegate: ViewController?
    var group: ReminderGroup!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = group.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewReminder))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let reminder = group.items[indexPath.row]
        if reminder.isComplete {
            let attrs: [NSAttributedString.Key: Any] = [.strikethroughStyle: 1, .foregroundColor: UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)]
            let attributedString = NSAttributedString(string: reminder.title, attributes: attrs)
            cell.textLabel?.attributedText = attributedString
        } else {
            cell.textLabel?.text = reminder.title
        }
        return cell
    }
    
    func addReminder(named name: String) {
        // create new reminder
        let reminder = Reminder(title: name, isComplete: false)
        group.items.append(reminder)
        // add reminder to our table
        tableView.insertRows(at: [IndexPath(row: group.items.count - 1, section: 0)], with: .automatic)
        // make sure we update main view controller
        delegate?.update(group)
    }
    
    @objc func addNewReminder() {
        let ac = UIAlertController(title: "New Reminder", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            guard let text = ac.textFields?[0].text else { return }
            self.addReminder(named: text)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }

}
