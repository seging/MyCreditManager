//
//  Student.swift
//  MyCreditManager
//
//  Created by 이승기 on 2022/11/18.
//

import Foundation

class Student {
    
    let name:String
    var subjects:[String:String] = [String:String]()
    
    init(name:String) {
        self.name = name
    }
    
    func setGradeBySubject(_ subject:String, grade:String) {
        self.subjects[subject] = grade
    }
    
    func removeSubject(_ subject:String) {
        self.subjects.removeValue(forKey: subject)
    }
    
    func showSubjectAverage() {
        var sum:Float = 0.0
        
        self.subjects.forEach { subject,grade in
            print("\(subject): \(grade)")
            sum += self.getGradeValue(Grades(rawValue: grade)!)
        }
        let average = sum/Float(self.subjects.count)
        print("평점  :  \(average.isNaN ? "0.0":String(format: "%.2f", average))")
    }
    
    private func getGradeValue(_ grade:Grades) -> Float {
        switch grade {
        case .Aplus:
            return 4.5
        case .A:
            return 4.0
        case .Bplus:
            return 3.5
        case .B:
            return 3.0
        case .Cplus:
            return 2.5
        case .C:
            return 2.0
        case .Dplus:
            return 1.5
        case .D:
            return 1.0
        case .F:
            return 0
        }
    }
}
