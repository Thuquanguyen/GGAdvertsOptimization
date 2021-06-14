//
//  GMSMapView+Extension.swift
//  TetViet
//
//  Created by QuangLH on 12/18/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import Foundation
import GoogleMaps
import MapKit
import SwiftyJSON

extension GMSMapView {
    func getCenterCoordinate() -> CLLocationCoordinate2D {
        let centerPoint = self.center
        let centerCoordinate = self.projection.coordinate(for: centerPoint)
        return centerCoordinate
    }
    
    func getTopCenterCoordinate() -> CLLocationCoordinate2D {
        // to get coordinate from CGPoint of your map
        let topCenterCoor = self.convert(CGPoint(x: self.frame.size.width, y: 0), from: self)
        let point = self.projection.coordinate(for: topCenterCoor)
        return point
    }
    
    func getRadius() -> CLLocationDistance {
        let centerCoordinate = getCenterCoordinate()
        let centerLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        let topCenterCoordinate = self.getTopCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        let radius = CLLocationDistance(centerLocation.distance(from: topCenterLocation))
        return round(radius)
    }
    
    func addPath(_ path: GMSPath, strokeColor: UIColor? = nil, strokeWidth: CGFloat? = nil, geodesic: Bool? = nil, spans: [GMSStyleSpan]? = nil) {
        let line = GMSPolyline(path: path)
        line.strokeColor = strokeColor ?? line.strokeColor
        line.strokeWidth = strokeWidth ?? line.strokeWidth
        line.geodesic = geodesic ?? line.geodesic
        line.spans = spans ?? line.spans
        line.map = self
    }
    
    func drawMapBound(forResource: String) {
        let pathMap = GMSMutablePath()
        if let path = Bundle.main.path(forResource: forResource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSON(data:  data)
                if let arrayLocation =  jsonResult["geometries"][0]["coordinates"][0][0].array  {
                    for item in arrayLocation {
                        let obj =  CLLocationCoordinate2D(latitude: item[1].doubleValue , longitude: item[0].doubleValue)
                        pathMap.add(obj)
                    }
                }
                
            } catch {
                // handle error
            }
        }
        self.addPath(pathMap, strokeColor: UIColor.red, strokeWidth: 2.0, geodesic: nil, spans: nil)
    }
    
    func animateToFitCircleOn(center: CLLocationCoordinate2D, kmRadius: CLLocationDistance, circleRatio: Double) {
        let centerPoint = projection.point(for: center)
        // Tính w
        let halfWidth = (kmRadius * 1000) / circleRatio
        // Tính h
        let halfHeight = halfWidth / Double(self.bounds.width / self.bounds.height)
        // Tính c
        let halfCross = sqrt(halfWidth * halfWidth + halfHeight * halfHeight)
        let radiusInView = projection.points(forMeters: halfCross, at: center)
        // Tính góc alpha, beta
        let beta = atan(halfHeight / halfWidth)
        let alpha = beta - .pi
        var topLeftPoint = CGPoint()
        var bottomRightPoint = CGPoint()
        // Tính toạ độ top left, bottom right: CGPoint
        topLeftPoint.x = centerPoint.x + radiusInView * CGFloat(cos(alpha))
        topLeftPoint.y = centerPoint.y + radiusInView * CGFloat(sin(alpha))
        bottomRightPoint.x = centerPoint.x + radiusInView * CGFloat(cos(beta))
        bottomRightPoint.y = centerPoint.y + radiusInView * CGFloat(sin(beta))
        // Convert sang toạ độ latitude, longitude
        let topLeft = projection.coordinate(for: topLeftPoint)
        let bottomRight = projection.coordinate(for: bottomRightPoint)
        let bounds = GMSCoordinateBounds(coordinate: topLeft, coordinate: bottomRight)
        let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 0.0)
        animate(with: cameraUpdate)
    }
}
