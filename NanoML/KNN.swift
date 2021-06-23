//
//  KNN.swift
//  NanoML
//
//  Created by Fernando de Lucas da Silva Gomes on 16/06/21.
//

import Foundation

/// An object that represents a K-Nearest Neightbours classifier.
///
/// K- Nearest Neightbours is a classifier method based on similarity. On KNN, we assume that the nearest data in a cartesian plane are more similar so as nearest as a new data is from a classified data, more probably they belong to the same class.
/// To use KNN classification, you need to provide classified data as ``KNNClass`` use the function ``Predict()``  and get the result using ``getNearest()``
class KNearestNeighbors {
    
    /// The classes that the database must have like
    private (set) var classes : [KNNClass]
    
    /// An array to keep the computed distances between the new data and the rest of the database
    private (set) var computedDistances : [Distance] = []
    
    /// The variable used in Minkowski metric, by default is 2.0.
    var p: Double = 2.0
    
    /// Creates a new KNN classifier
    ///
    /// - Parameters:
    ///  - clases: The previous classified data as KNNClass
    init(classes: [KNNClass]){
        self.classes = classes
    }
    
    /// Use to calculate the distance between the given point and the other points on database;
    ///
    /// - Parameters:
    ///  - data: The data you want ot classify
    ///  - metric: the metric you want to use to calculate the distances. By default is euclidean metric.
    func calculate(data: [Double], metric: DistanceMetric) {
        computedDistances = []
        switch metric {
        case .euclidean:
            self.euclidean(data: data)
        case .manhatan:
            self.manhatan(data: data)
        case .chebyshev:
            self.chebyvesk(data: data)
        case .minkowski:
            self.minkowski(data: data)
        }
    }
    
    /// Get the K-Nearest neightbours for the previous given on `
    /// - Parameter K: The numbers of near neightbours you want to compare.
    /// - Returns: Returns an array containing the class identifier and the number of ocurrences in the k-nearest datas.
    func getNearest(K: Int) -> [String:Int] {
        self.computedDistances.sort()
        let nearestDistances = computedDistances.prefix(K)
        let counting = nearestDistances.reduce(into: [:]) { counts, distance in
            counts[distance.identifier, default: 0] += 1
        }
        return counting
    }
    
    /// Calculate the Euclidean distance for the given data
    ///
    /// - Parameter data: An array of double containg the geometric points of the data. This points must contain the same number of axis that the classes previous classified.
    private func euclidean(data: [Double]) {
        classes.forEach {
            let identifier = $0.identifier
            $0.points.forEach {
                var sum: Double = 0
                for i in 0..<$0.count{
                    sum += ($0[i] - data[i]).elevate()
                }
                let sqrt = sum.squareRoot()
                computedDistances.append(Distance(distance: sqrt, identifier: identifier))
            }
        }
    }
    
    /// Calculate the Manhatan distance for the given data
    ///
    /// - Parameter data: An array of double containg the geometric points of the data. This points must contain the same number of axis that the classes previous classified.
    private func manhatan(data: [Double]) {
        classes.forEach {
            let identifier = $0.identifier
            $0.points.forEach {
                var sum: Double = 0
                for i in 0..<$0.count{
                    sum += abs($0[i] - data[i])
                }
                computedDistances.append(Distance(distance: sum, identifier: identifier))
            }
        }
    }
    
    /// Calculate the Chebyvesk distance for the given data
    ///
    /// - Parameter data: An array of double containg the geometric points of the data. This points must contain the same number of axis that the classes previous classified.
    private func chebyvesk(data: [Double]) {
        classes.forEach {
            let identifier = $0.identifier
            $0.points.forEach {
                var sum: [Double] = []
                for i in 0..<$0.count{
                    sum.append(abs($0[i] - data[i]))
                }
                let max = sum.max() ?? 0
                computedDistances.append(Distance(distance: max, identifier: identifier))
            }
        }
    }
    
    /// Calculate the Minkowski distance for the given data
    ///
    /// - Parameter data: An array of double containg the geometric points of the data. This points must contain the same number of axis that the classes previous classified.
    private func minkowski(data: [Double]) {
        classes.forEach {
            let identifier = $0.identifier
            $0.points.forEach {
                var sum: Double = 0
                for i in 0..<$0.count{
                    sum += pow(($0[i]-data[i]), p)
                }
                let distance = sum.squareRoot()/p
                computedDistances.append(Distance(distance: distance, identifier: identifier))
            }
        }
    }
     
    /// An exponential operation to determine the base raised by the given power
    func pow <T: Numeric>(_ base: T, _ power: Double) -> T {
      var answer : T = 1
      for _ in 0..<Int(power) { answer *= base }
      return answer
    }
}

enum DistanceMetric {
    case euclidean, manhatan, chebyshev, minkowski
}


/// Represents an set of data previous classified.
struct KNNClass {
    var points: [[Double]]
    var identifier: String
    
    init(points: [[Double]], classIdentifier: String){
        self.points = points
        self.identifier = classIdentifier
    }
}

/// Represents the distance between a new data and one point and witch class that point belongs
struct Distance : Comparable {

    var distance: Double
    var identifier: String
}


extension Double {
    public func elevate() -> Double{
        return self * self
    }
}

extension Sequence where Element: Numeric {
    func sum() -> Element {reduce(0, +)}
}

extension Distance {
    static func < (lhs: Distance, rhs: Distance) -> Bool {
        return lhs.distance < rhs.distance
    }
}
