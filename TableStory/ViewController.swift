//
//  ViewController.swift
//  TableStory
//
//  Created by Wyatt Denham on 3/27/24.
//

import UIKit
// include this below the import UIKit statement
import MapKit
//array objects of our data.
let data = [
    Item(name: "Zilker Botanical Garden", type: "Outdoor", desc: "Zilker Botanical Garden is one of the top outdoor destinations in the downtown Austin area. With a huge number of gardens featuring local plants and artwork, this relaxing space would be the perfect place to take some pictures in the flowers.", lat: 30.26976167470999, long:  -97.77228659087537, imageName: "botanical"),
    Item(name: "Toy Joy", type: "Shopping", desc: "This unique toy store has an equally unique paintjob both inside and out! On every neon green and pink surface you can find toys, games, collectibles, and more. Come try their icecream and specialty sodas for a deliciously fun sweet treat!", lat: 30.330679293405723, long: -97.73940329860007, imageName: "yummi"),
    Item(name: "Pickett Trail", type: "Outdoor", desc: "As one of the most hidden trails in Georgetown, Pickett Trail is a one way in and out trail of moderate difficulty. Following the San Gabriel River from Blue Hole Park, Pickett Trail features stunning views and river access points to make taking a swim while hiking easy. Come check out this unique and isolated trail when looking for an active date!", lat: 30.64048818183633, long: -97.68284387368278, imageName: "pickett"),
    Item(name: "Pavements", type: "Shopping", desc: "Located in the thrift district on Guadalupe Street, Pavements is directly next to Buffalo Exchange and Flamingos and features an assortment of quirky affordable clothing and accessories!. ", lat: 30.296995030984885, long: -97.74209309157521, imageName: "pavement"),
    Item(name: "Blue Bonnet Cafe", type: "Food", desc: "When driving through the Hill Country, make sure to pay a visit to Blue Bonnet Cafe in Marble Falls. With a menu that includes Texas-sized comfort food and delicious southern classics, this cafe is a beloved eatery for both locals and tourists in the area. Make sure to try their award-winning pie!", lat: 30.57079911210365, long: -98.2760207025191, imageName: "bluebonnet")
   
]

struct Item {
    var name: String
    var type: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
         let item = data[indexPath.row]
         cell?.textLabel?.text = item.name

         //Add image references
         let image = UIImage(named: item.imageName)
         cell?.imageView?.image = image
         cell?.imageView?.layer.cornerRadius = 10
         cell?.imageView?.layer.borderWidth = 5
         cell?.imageView?.layer.borderColor = UIColor.white.cgColor
         
         return cell!
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set center, zoom level and region of the map
              let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
              let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
              mapView.setRegion(region, animated: true)
              
           // loop through the items in the dataset and place them on the map
               for item in data {
                  let annotation = MKPointAnnotation()
                  let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                  annotation.coordinate = eachCoordinate
                      annotation.title = item.name
                      mapView.addAnnotation(annotation)
                      }

            
        // Add this
        theTable.delegate = self
        theTable.dataSource = self
        // Do any additional setup after loading the view.
    }

    // add this function to original ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDetailSegue" {
          if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
              // Pass the selected item to the detail view controller
              detailViewController.item = selectedItem
          }
      }
  }
}

