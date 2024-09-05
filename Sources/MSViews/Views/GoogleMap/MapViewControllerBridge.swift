////
////  MapViewControllerBridge.swift
////  VisionDimensions
////
////  Created by Corptia 02 on 21/08/2023.
////
//
//import Foundation
//import SwiftUI
//import msViews
//import GoogleMaps
//
//struct GoogleMapView: UIViewRepresentable {
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    let marker : GMSMarker = GMSMarker()
//    @EnvironmentObject var customLocationManager : CustomLocationManager
//    @State var location : CLLocation? = nil
//    @Binding var mission : WorkMission
//    @Binding var hasMap : Bool
//
//    /// Creates a `UIView` instance to be presented.
//    func makeUIView(context: Self.Context) -> GMSMapView {
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        location = customLocationManager.location
//        let camera = GMSCameraPosition.camera(withLatitude: location?.coordinate.latitude ?? 31.0, longitude: location?.coordinate.longitude ?? 31.0 , zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView.delegate = context.coordinator
//
//        return mapView
//    }
//
//    /// Updates the presented `UIView` (and coordinator) to the latest
//    /// configuration.
//    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
//        // Creates a marker in the center of the map.
//        marker.position = location?.coordinate ?? CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        //        marker.title = "Sydney"
//        //        marker.snippet = "Australia"
//        marker.map = mapView
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//        UserLocationButtonPadding(mapView:mapView)
//
//        //        if(location != nil) {
//        //            geocoder.reverseGeocodeCoordinate(location!.coordinate) { response, error in
//        //                guard
//        //                    let address = response?.firstResult(),
//        //                    let lines = address.lines
//        //                else {
//        //                    return
//        //                }
//        //                print("TEST GEOCODING \(lines.joined(separator: "\n"))")
//        //            }
//        //        }
//
//    }
//
//    func UserLocationButtonPadding(mapView:GMSMapView) {
//        let buttonHeight : CGFloat = 62
//        let topInset = mapView.safeAreaInsets.top
//        mapView
//            .padding = UIEdgeInsets(
//            top: topInset,
//            left: 0,
//            bottom: buttonHeight,
//            right: 0)
//    }
//    class Coordinator: NSObject, GMSMapViewDelegate {
//
//        var parent: GoogleMapView
//
//        init(_ parent: GoogleMapView) {
//            self.parent = parent
//        }
//
//        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//            // Custom logic here
//            mapView.clear()
//            let marker = GMSMarker()
//            marker.position = coordinate
//            marker.snippet = ""
//    //        marker.icon = UIImage(named: "mapmarker")
//            marker.map = mapView
//
//            parent.mission.lat = coordinate.latitude
//            parent.mission.lng = coordinate.longitude
//
//            parent.mission.location = "\(parent.mission.lat) , \(parent.mission.lng)"
//
//            let geocoder = GMSGeocoder()
//
////            geocoder.reverseGeocodeCoordinate(coordinate) { [self] response, error in
////                guard
////                    let address = response?.firstResult(),
////                    let lines = address.lines
////                else {
////                    return
////                }
////
////                parent.UserLocationButtonPadding(mapView: mapView)
////                parent.mission.location = lines.joined(separator: "\n")
////                tagPrint("selectedAddress:D \(selectedAddress!)")
////                self.searchResultTextField.text = mission.location
////                marker.title = parent.mission.location
////            }
//
//            parent.hasMap = false
//        }
//    }
//
//}
//
//
//
