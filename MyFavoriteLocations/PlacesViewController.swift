//
//  PlacesViewController.swift
//  MyFavoriteLocations
//
//  Created by Dan DeAngelis on 6/13/18.
//  Copyright © 2018 deangelisLogic. All rights reserved.
//

import UIKit
import MapKit
class PlacesViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // ignore user while searching
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicatior
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        //Hide Search Bar/keyboard
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        //start search based on the user search request
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents() //Stop the loading wheel, allow user interaction
            if response == nil{
                print("Error")
            }
            else {
                //Remove annotations CHECK THIS AGAIN MIGHT NOT WANT TO DO THIS
                /*
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotation(annotations)
                */
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create Annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                //Zoom in on Search
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.3, 0.3)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    
    @IBAction func mapToMain(_ sender: UIButton) {
        //Go from map screen back to main screen
        self.performSegue(withIdentifier: "backToMain", sender: self)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
