//
//  time.swift
//  first_build_mongmong
//
//  Created by HyokJun Won on 2021/09/09.
//

import Foundation

struct Time {
    var ns: Int
    var sec: Int
    var min: Int
    var hr: Int
    
    func secAngle() -> Double {
        return Double(sec) * 6 + Double(ns) * 6/1000000000
    }
    
    func minAngle() -> Double {
        return Double(min) * 6 + Double(sec)*0.1 + Double(ns) * 0.1/1000000000
    }
    
    func absMinAngle() -> Double {
        return Double(min) * 6
    }
    
    func hrAngle() -> Double {
        return Double(hr) * 30 + Double(min) * 0.5 + Double(sec) * 0.5/60 + Double(ns) * 0.5/60000000000
    }
    
    func secondInMili() -> Int {
        return sec * 1000 + ns / 1000000
    }
}
