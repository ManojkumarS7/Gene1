//
//  HomePage.swift
//  Gene
//
//  Created by manoj on 02/02/24.
//

import UIKit


class HomePage : UIViewController ,  UITableViewDataSource {
    
    
    let openVC = cameraViewController()
    
   let Names  = ["gene", "gene", "gene"]
    
   
   let  tableView = UITableView()
 
    
   var imageUrl: [String] = []
    var images : [UIImage?] = []
    
    
    override func viewDidLoad() {
        
        
        
        
        let cameraImage = UIImage(systemName: "livephoto")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        let cameraButton = UIButton()
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.setImage(cameraImage, for: .normal)
        cameraButton.transform = CGAffineTransform(scaleX: 3, y: 3)
        cameraButton.addTarget(self, action: #selector(openCamera(_:)), for: .touchUpInside)
        view.addSubview(cameraButton)
            
               
               NSLayoutConstraint.activate([
                   cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   cameraButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                   cameraButton.widthAnchor.constraint(equalToConstant: 40),
                   cameraButton.heightAnchor.constraint(equalTo: cameraButton.widthAnchor),
                   
         
                   
                   
                   
                   
               ])

        
        view.backgroundColor = .white
        tableView.frame = view.bounds
        self.tableView.register(CustomImageCell.self, forCellReuseIdentifier: CustomImageCell.reuseIdentifier)
        
        
      //  tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
       //    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           tableView.rowHeight = UITableView.automaticDimension
           tableView.estimatedRowHeight = 50 // Set an estimated row height
           view.addSubview(tableView)
           fetchData()
    }
    
    
    @objc func openCamera(_ sender: UIButton) {
        
        _ = openVC
   
      
        navigationController?.pushViewController(openVC, animated: true)
        
    }
    
    func fetchData() {
       
        let apiUrl = "http://10.10.101.92:8000/api/gettemplate"
        
       
        URLSession.shared.dataTask(with: URL(string: apiUrl)!) {[weak self ] data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
 
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let geneData = try decoder.decode(geneData.self, from: data)
                    let geneUserData = geneData.data
                    
                    self?.imageUrl = geneUserData.map { $0.thumpnail_url}
                    self?.images = Array(repeating: nil, count: geneData.data.count)
                    
                    
                    DispatchQueue.main.async {
                        self? .tableView.reloadData()
                        //   self!.processFetchedData(geneData)
                        //  self!.refreshControl.endRefreshing()
                    }
                    guard !(self?.imageUrl.isEmpty)! else {
                        
                        return
                    }
                    
                    for (index, url) in self?.imageUrl.enumerated() ?? [].enumerated() {
                        
                        self?.downloadImage(from : url, at: index)
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func downloadImage(from urlString: String, at index: Int) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else { return }
            
            let image = UIImage(data: data)
            self?.images[index] = image
            
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: index, section: 0)
                self?.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }.resume()
        
        
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // Set the desired height for each cell
//        return 80  // Adjust the value based on your preference
//    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomImageCell.reuseIdentifier, for: indexPath) as? CustomImageCell else {
            
            fatalError("failed to dequse customImageCell")
        }
        
        cell.configure(with: images[indexPath.row])

return cell
    }
}
  
extension HomePage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = images[indexPath.row] else {
            return UITableView.automaticDimension
        }

        // Adjust the cell height based on the image height
        return image.size.height
    }
}
