//
//  KNN.swift
//  NanoML
//
//  Created by Fernando de Lucas da Silva Gomes on 16/06/21.
//

import Foundation
class NearestNeighbors {
    private (set) var classes : [KNNClass]
    private (set) var computedDistances : [Distance] = []
    var p: Double = 2.0
    
    init(classes: [KNNClass]){
        self.classes = classes
    }
    
    func predict(data: [Double], metric: DistanceMetric) {
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
    
    func getNearest(k: Int) -> [String:Int] {
        self.computedDistances.sort()
        let nearestDistances = computedDistances.prefix(k)
        let counting = nearestDistances.reduce(into: [:]) { counts, distance in
            counts[distance.identifier, default: 0] += 1
        }
        print(counting)
        return counting
    }
    
    func euclidean(data: [Double]) {
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
    
    func manhatan(data: [Double]) {
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
    
    func chebyvesk(data: [Double]) {
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
    
    func minkowski(data: [Double]) {
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
    
    func pow <T: Numeric>(_ base: T, _ power: Double) -> T {
      var answer : T = 1
      for _ in 0..<Int(power) { answer *= base }
      return answer
    }
}

enum DistanceMetric {
    case euclidean, manhatan, chebyshev, minkowski
}

struct KNNClass {
    var points: [[Double]]
    var identifier: String
    
    init(points: [[Double]], classIdentifier: String){
        self.points = points
        self.identifier = classIdentifier
    }
}

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
