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



final class unowned {
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

/**
行为模式：
 策略模式（Strategy）
 对象有某个行为，但是在不同的场景中，该行为有不同的实现算法。策略模式：
 * 定义了一族算法（业务规则）；
 * 封装了每个算法；
 * 这族的算法可互换代替（interchangeable）。
 
  */

struct DownLoadObj {
    let dToolsType: Int
    // ...
}

// protocol
protocol StrategyMethod: AnyObject {
    func testRealness(_ obj: DownLoadObj) -> Bool
    func down() -> Void
}

extension StrategyMethod{
    func down() -> Void {
        print("default play")
    }
}


// strategy Method 1
final class VoightKampffTest: StrategyMethod {
    func testRealness(_ obj: DownLoadObj) -> Bool {
        return obj.dToolsType == 0
    }
    
    func down() {
        print("AA down")
    }
}

// strategy Method 2
final class GeneticTest: StrategyMethod {
    func testRealness(_ obj: DownLoadObj) -> Bool {
        return obj.dToolsType == 0
    }
    
    func down() {
        print("BB down")
    }
}


// init Strategy
final class BladeRunner {
    
    private var strategy: StrategyMethod
    
    /// Usually, the Context accepts a strategy through the constructor, but
    /// also provides a setter to change it at runtime.
    init(strategy: StrategyMethod) {
        self.strategy = strategy
    }
    
    /// Usually, the Context allows replacing a Strategy object at runtime.
    func update(strategy: StrategyMethod) {
        self.strategy = strategy
    }
    
    func testIfAndroid(_ obj: DownLoadObj) -> Bool {
        return strategy.testRealness(obj)
    }
    
    func absDown() -> Void {
        strategy.down()
    }
}


// Usage
func testMethod() {
    let rachel = DownLoadObj.init(dToolsType: 0)

    // Deckard is using a traditional test
    let deckard = BladeRunner(strategy: VoightKampffTest())
    let isRachelAndroid = deckard.testIfAndroid(rachel)
    deckard.absDown()

    // Gaff is using a very precise method
    let gaff = BladeRunner(strategy: GeneticTest())
    let isDeckardAndroid = gaff.testIfAndroid(rachel)
    gaff.absDown()
    
    gaff.update(strategy: VoightKampffTest())
    gaff.absDown()


}
