//
//  ViewController.swift
//  test-162
//
//  Created by Likens, Dustin on 8/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        userDefaults.set(self.usernameTextField.text, forKey: "username")
    }
    
    private func downloadThumbnail(for imageName: String, complete:@escaping () -> Void) {
            let imageUrl = String.assetUrl(imageName: imageName, descriptor: "thumbnail")
            if let url = URL(string: imageUrl) {
                URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                    if (error != nil) { print("Error downloading thumbnail:", error!) }
                    if let data = data, let responseType = response?.mimeType {
                        if responseType.contains("image"), let _ = UIImage(data: data) {
                            let writePath = documentsPath.appendingPathComponent("thumbnail" + imageName)
                            NSData(data: data).write(toFile: writePath, atomically: true)
                            complete()
                        }
                    }
                }).resume()
            }
        }
    
}
