//
//  FeedViewController.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 23.08.2021.
//

import UIKit
import MapKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "feed_vc_tabbar_title".localized(file: "Localizable_TabBar")
        locationManager.delegate = self
        
        view.addSubview(mapView)
        setupConstraints()
        configureMap()
        checkUserLocationPermission()
        createPin(title: "Custom Pin", coordinate: CLLocationCoordinate2D(latitude: 55.581705, longitude: 37.1046726))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAllPins))
       
        
    }

    // MARK: Свойства
    
    // Свойство для хранения координат пользователя
    private lazy var myCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    // Карта
    private lazy var mapView:MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        return mapView
    }()
    
    // LocationManager
    private lazy var locationManager = CLLocationManager()
    
    
    
    // MARK: Методы
    
    // Метод удаления всех пинов с карты
    @objc private func removeAllPins() {
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.removeOverlays(mapView.overlays)
    }
    
    // Метод построения маршрута
    private func addRoute(sourceLocation: CLLocationCoordinate2D, destinationLocation:CLLocationCoordinate2D) {
               
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirections.Request()
        
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { [self] (responce, error) in
            guard let directionsResponce = responce else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            let route = directionsResponce.routes[0]
            self.mapView.removeOverlays(mapView.overlays)
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    

    
    // Метод настройки внешнего вида карты
    private func configureMap() {
        // тип карты
        mapView.mapType = .standard
        addPinGesture()
    }
    
    // Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Метод, проверяющий уровень разрешения к геолокации пользователя
    private func checkUserLocationPermission() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = 10
        locationManager.startUpdatingLocation()
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .denied, .restricted:
            print("Необходимо изменить настройки")
        default:
            print("Неизвестный статус")
        }
    }
    
    // Метод, создающий пин на карте по координатам
    private func createPin(title: String, coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.title = title
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }

    // Метод, добавляющий пин на карту по длительному нажатию в нужное место
    private func addPinGesture() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(tapOnMap(gestureRecognizer:)))
        longTap.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longTap)
    }
    
    @objc private func tapOnMap(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: mapView)
        let coordinates = mapView.convert(point, toCoordinateFrom: mapView)
        
        let newPinAlertTitle = "new_pin_alert_title".localized(file: "Localizable_Map")
        let newPinAlertButton = "new_pin_alert_button".localized(file: "Localizable_Map")
        
        let alertVC = UIAlertController(title: newPinAlertTitle, message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: newPinAlertButton, style: .default) { _ in
            guard let title = alertVC.textFields?.first?.text else { return }
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = "\(title)"
            self.mapView.addAnnotation(annotation)
        }
        
        
        alertVC.addTextField()
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true)
    }
    
  
}

// MARK: Extensions

extension FeedViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationPermission()
    }
    
    // Метод, срабатывающий при обновлении геолокации более чем на 20 метров
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        manager.distanceFilter = 20
        
        self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true)
    
        self.myCoordinates = location.coordinate
    }
}

extension FeedViewController: MKMapViewDelegate {

    // Метод настройки внешнего вида маршрута
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .green
        renderer.lineWidth = 4
        return renderer
    }
    
    // Метод, срабатывающий при нажатии на пин
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let viewCoordinates = view.annotation?.coordinate else { return }
        addRoute(sourceLocation: self.myCoordinates, destinationLocation: viewCoordinates)
    }
}

 

