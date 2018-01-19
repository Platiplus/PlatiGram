//
//  UsersTableViewController.swift
//  PlatiGram
//
//  Created by Platiplus on 18/01/18.
//  Copyright © 2018 Platiplus. All rights reserved.
//

import UIKit
import Firebase

class UsersTableViewController: UITableViewController{
       
    var user = [User]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUsers()
    }
    
    func retrieveUsers(){
        let dbRef = Database.database().reference()
        
        dbRef.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
            
            let users = snapshot.value as! [String:AnyObject]
            self.user.removeAll()
            
            for (_, value) in users {
                if let uid = value["uid"] as? String {
                    if uid != Auth.auth().currentUser!.uid {
                        var userToShow = User()
                        if let username = value["username"] as? String, let imagePath = value["urlToImage"] as? String {
                            userToShow.username = username
                            userToShow.imagePath = imagePath
                            userToShow.userID = uid
                            
                            self.user.append(userToShow)
                        }
                    }
                }
            }
            self.tableView.reloadData()
        })
        dbRef.removeAllObservers()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return user.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell

        cell.usernameLabel.text = self.user[indexPath.row].username
        cell.userID = self.user[indexPath.row].userID
        cell.profileImageView.downloadImage(from: user[indexPath.row].imagePath!)
        
        
        if isfollowed == true { cell.followButton.backgroundColor = .blue
            cell.followButton.setTitleColor(.white, for: .selected)
        }
        
        if isfollowed == false {
            cell.followButton.backgroundColor = .white
            cell.followButton.setTitleColor(.blue, for: .normal)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let uid = Auth.auth().currentUser?.uid
        let dbRef = Database.database().reference()
        let key = dbRef.child("users").childByAutoId().key
        
        var isfollower = false
        
        dbRef.child("users").child(uid!).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
            if let following = snapshot.value as? [String:AnyObject]{
                for (key, value) in following {
                    if value as? String == self.user[indexPath.row].userID {
                        isfollower = true
                        
                        dbRef.child("users").child(uid!).child("following?/\(key)").removeValue()
                        dbRef.child("users").child(self.user[indexPath.row].userID!).child("followers/\(key)").removeValue()
                                                                    
                    }
                }
            }
            //Follow as user has no followers
            if !isfollower {
                let following = ["following/\(key)" : self.user[indexPath.row].userID]
                let followers = ["followers/\(key)" : uid]
                
                dbRef.child("users").child(uid!).updateChildValues(following)
                dbRef.child("users").child(self.user[indexPath.row].userID!).updateChildValues(followers)
            }
        })
        
        dbRef.removeAllObservers()
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView{
    
    func downloadImage(from imageURL: String!){
        let url = URLRequest(url: URL(string: imageURL)!)
        
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async{
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
    
}









