//
//  StrategyMethod.swift
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/7/23.
//  Copyright © 2019 xinxin. All rights reserved.
//
/*
   本科来 多种试卷请求 用的
 */

/*
struct RequestParam{
    var studentId: NSNumber
    var ordDetailId: NSNumber
    var subjectId: NSNumber
    var paperCode: NSNumber
    var recordId: NSNumber
    var lastLevelNodeId: NSNumber
    var resetFlag: NSNumber
    var answerList: NSArray
}

var recordId = NSNumber()


typealias successBlock = (Any) -> (Void)

protocol ExamRequestStrategy {
    
    
    func getExerciseData(param: RequestParam, successBlock: @escaping successBlock, andFailure failureBlock: (Any) -> ())
    func submitExerciseData(param: RequestParam, successBlock: @escaping successBlock, andFailure failureBlock: (Any) -> ())
    
    
}


final class realExamGetData :ExamRequestStrategy{
    func submitExerciseData(param: RequestParam, successBlock: @escaping successBlock, andFailure failureBlock: (Any) -> ()) {
        let url = "http://exercise.sunlands.com/tiku/realExamExercise/submitRealExamExercise"
        let paramDics = ["studentId": param.studentId, "recordId":param.recordId, "answerList":param.answerList] as [String : Any]
        ApiManager.submitRealExamExercise(paramDics, withUrl: url) { (success :Bool?, responseData: Any?, error :NetworkError?) in
            successBlock(param.recordId)
        }
        
    }
    
    
    func getExerciseData(param: RequestParam, successBlock: @escaping (Any) -> (Void), andFailure failureBlock: (Any) -> (Void)) {
        let practiceRequst = PracticeRequsetManeger()
        practiceRequst.questionOpStyle = NSStringFromClass(HomeworkPaperOpTableViewCell.classForCoder());
        let url = "http://exercise.sunlands.com/tiku/realExamExercise/queryRealExamPaperContentByCondition"
        let number = NumberFormatter.init()
        let stringZf = number.string(from: param.paperCode)
        let paramDics = ["studentId": param.studentId, "paperCode":stringZf ?? "", "recordId":param.recordId] as [String : Any]
        practiceRequst.requetQuest(withParam: paramDics, withUrl: url) { (sucessData :Any) in
            let model = sucessData as!BKPracticeModel
            recordId = NSNumber.init(value: model.recordId)
            successBlock(model)
        }
        
        failureBlock(NSError.init())
    }
}


final class simulateExamGetData :ExamRequestStrategy{
    func submitExerciseData(param: RequestParam, successBlock: @escaping successBlock, andFailure failureBlock: (Any) -> ()) {
        let url = "http://exercise.sunlands.com/tiku/mockExamination/submitMockExamination"
        let paramDics = ["studentId": param.studentId, "recordId":param.recordId, "answerList":param.answerList] as [String : Any]
        ApiManager.submitRealExamExercise(paramDics, withUrl: url) { (success :Bool?, responseData: Any?, error :NetworkError?) in
            successBlock(param.recordId)
        }
        
    }
    
    
    func getExerciseData(param: RequestParam, successBlock: @escaping (Any) -> (Void), andFailure failureBlock: (Any) -> (Void)) {
        let practiceRequst = PracticeRequsetManeger()
        practiceRequst.questionOpStyle = NSStringFromClass(HomeworkPaperOpTableViewCell.classForCoder());
        let url = "http://exercise.sunlands.com/tiku/mockExamination/queryMockExaminationPaperContent"
        let number = NumberFormatter.init()
        let stringZf = number.string(from: param.paperCode)
        let paramDics = ["studentId": param.studentId, "paperCode":stringZf ?? "", "recordId":param.recordId] as [String : Any]
        practiceRequst.requetQuest(withParam: paramDics, withUrl: url) { (sucessData :Any) in
            let model = sucessData as!BKPracticeModel
            recordId = NSNumber.init(value: model.recordId)
            successBlock(model)
        }
        
        failureBlock(NSError.init())
    }
}

final class chaperExamGetData :ExamRequestStrategy{
    func getExerciseData(param: RequestParam, successBlock: @escaping successBlock, andFailure failureBlock: (Any) -> ()) {
        let practiceRequst = PracticeRequsetManeger()
        practiceRequst.questionOpStyle = NSStringFromClass(HomeworkPaperOpTableViewCell.classForCoder());
        let url = "http://exercise.sunlands.com/tiku/chapterExerciseV3/getLastNodeQuestions"
        let paramDics = ["studentId": param.studentId, "lastLevelNodeId":param.lastLevelNodeId, "resetFlag": param.resetFlag] as [String : Any]
        practiceRequst.requetQuest(withParam: paramDics, withUrl: url) { (sucessData :Any) in
            let model = sucessData as!BKPracticeModel
            recordId = NSNumber.init(value: model.recordId)
            successBlock(model)
        }
    }
    
    func submitExerciseData(param: RequestParam, successBlock: @escaping successBlock, andFailure failureBlock: (Any) -> ()) {
        let url = "http://exercise.sunlands.com/tiku/chapterExerciseV3/submitExercise"
        //MARK: Debug
        let paramDics = ["studentId": param.studentId, "lastLevelNodeId":param.lastLevelNodeId,"recordId":param.recordId,"status":"PARTIAL" ,"answerList":param.answerList] as [String : Any]
        ApiManager.submitRealExamExercise(paramDics, withUrl: url) { (success :Bool?, responseData: Any?, error :NetworkError?) in
            successBlock(param.lastLevelNodeId)
        }
        
    }
    
    
}



final class StrategyManager {
    private let strategy: ExamRequestStrategy
    init(param: ExamRequestStrategy) {
        self.strategy = param
    }
    
    func getExamData(param: RequestParam, successBlock: @escaping (Any) -> (Void), andFailure failureBlock: (Any) -> ()){
        strategy.getExerciseData(param: param, successBlock: { (successData :Any) -> (Void) in
            successBlock(successData)
        }) { (failureDate :Any) in
            failureBlock(failureDate)
        }
    }
    
    func submitExamData(param: RequestParam, successBlock: @escaping (Any) -> (Void), andFailure failureBlock: (Any) -> ()){
        strategy.submitExerciseData(param: param, successBlock: { (successData :Any) -> (Void) in
            successBlock(successData)
        }) { (failureDate :Any) in
            failureBlock(failureDate)
        }
    }
    
}

*/

/// 比OC 方便多了


struct TestSubject {
    let pupilDiameter: Double
    let blushResponse: Double
    let isOrganic: Bool
}

// protocol
protocol StrategyMethod: AnyObject {
    func testRealness(_ testSubject: TestSubject) -> Bool
    func play() -> Void
}

extension StrategyMethod{
    
    func play() -> Void {
        print("default play")
    }
}


// strategy Method 1
final class VoightKampffTest: StrategyMethod {
    func testRealness(_ testSubject: TestSubject) -> Bool {
        return testSubject.pupilDiameter < 30.0 || testSubject.blushResponse == 0.0
    }
    
    func play() {
        print("VoightKampffTest play")
    }
}

// strategy Method 2
final class GeneticTest: StrategyMethod {
    func testRealness(_ testSubject: TestSubject) -> Bool {
        return testSubject.isOrganic
    }
}


// init Strategy
final class BladeRunner {
    
    private let strategy: StrategyMethod
    
    init(test: StrategyMethod) {
        self.strategy = test
    }
    
    func testIfAndroid(_ testSubject: TestSubject) -> Bool {
        return !strategy.testRealness(testSubject)
    }
    
    func videoPlay() -> Void {
        strategy.play()
    }
}




