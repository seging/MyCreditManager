//
//  main.swift
//  MyCreditManager
//
//  Created by 이승기 on 2022/11/18.
//

import Foundation

private var students:[Student] = []

while true {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    input(readLine())
}

private func input(_ inputCase:String?) {
    
    guard let inputCase = inputCase else {
        showInputCaseErr()
        return
    }
        
    switch InputCase(rawValue: inputCase) {
    case .학생추가:
        print("추가할 학생의 이름을 입력해주세요")
        addStudent(readLine())
        break
    case .학생삭제:
        print("삭제할 학생의 이름을 입력해주세요")
        deleteStudent(readLine())
        break
    case .성적추가변경:
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄워쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        addStudentGradeBySubject(readLine())
        break
    case .성적삭제:
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        removeStudentGradeBySubject(readLine())
        break
    case .평점보기:
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        showStudentAverage(readLine())
        break
    case .종료:
        print("프로그램을 종료합니다...")
        exit(0)
    default:
        showInputCaseErr()
        break
    }
}

private func addStudent(_ name:String?) {
    if checkEng(name),let name = name,name.count > 0 {
        if checkStudentNameIsEmpty(name) {
            students.append(Student(name: name))
            print("\(name) 학생을 추가했습니다.")
        }
        else {
            print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        }
    }
    else {
        showInputErr()
    }
}

private func deleteStudent(_ name:String?) {
    if let name = name,name.count > 0 {
        if checkStudentNameIsEmpty(name) {
            print("\(name) 학생을 찾지 못했습니다.")
        }
        else {
            students.removeAll { student in
                student.name == name
            }
            print("\(name) 학생을 삭제하였습니다.")
        }
    }
    else {
        showInputErr()
    }
}

private func addStudentGradeBySubject(_ studentGradeBySubject:String?) {
    guard let studentGradeBySubject = studentGradeBySubject else {
        showInputErr()
        return
    }
    
    let studentSubjectInfo = studentGradeBySubject.components(separatedBy: " ")
    if studentSubjectInfo.count == 3 {
        let name = studentSubjectInfo[0] // 이름
        if checkStudentNameIsEmpty(name) {
            showInputErr()
            return
        }
        let subject = studentSubjectInfo[1] // 과목
        if checkEng(subject) == false {
            showInputErr()
            return
        }
        let grade = studentSubjectInfo[2] // 성적
        guard let grade = Grades(rawValue: grade) else {
            showInputErr()
            return
        }
        students = students.map { student in
            if student.name == name {
                student.setGradeBySubject(subject, grade: grade.rawValue)
                return student
            }
            return student
        }
        print("\(name) 학생의 \(subject) 과목이 \(grade.rawValue)로 추가(변경)되었습니다.")
    }
    else {
        showInputErr()
    }
}

private func removeStudentGradeBySubject(_ studentGradeBySubject:String?) {
    guard let studentGradeBySubject = studentGradeBySubject else {
        showInputErr()
        return
    }
    
    let studentSubjectInfo = studentGradeBySubject.components(separatedBy: " ")
    if studentSubjectInfo.count == 2 {
        let name = studentSubjectInfo[0] // 이름
        if checkStudentNameIsEmpty(name) {
            print("\(name) 학생을 찾지 못했습니다.")
            return
        }
        let subject = studentSubjectInfo[1] // 과목
        if checkEng(subject) == false {
            showInputErr()
            return
        }
        
        students = students.map { student in
            if student.name == name {
                student.removeSubject(subject)
                return student
            }
            return student
        }
        print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
    }
    else {
        showInputErr()
    }
}

private func showStudentAverage(_ name:String?) {
    guard let name = name else {
        showInputErr()
        return
    }
    
    if checkStudentNameIsEmpty(name) {
        print("\(name) 학생을 찾지 못했습니다.")
        return
    }
    else {
        students = students.map { student in
            if student.name == name {
                student.showSubjectAverage()
                return student
            }
            return student
        }
    }
}

private func checkStudentNameIsEmpty(_ name:String) -> Bool {
    students.filter { student in
        student.name == name
    }.count == 0
}

private func checkEng(_ input:String?) -> Bool {
    guard let input = input else { return false }
    let engEx = "^[A-Za-z]*$"
    return input.range(of: engEx, options: .regularExpression) != nil
}


private func showInputCaseErr() {
    print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 x를 입력해주세요.")
}

private func showInputErr() {
    print("입력이 잘못되었습니다. 다시 확인해주세요.")
}
