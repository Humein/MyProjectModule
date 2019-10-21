import UIKit

/*
 假如，我们有一个这样的应用，用户分为三个等级：匿名用户、普通用户、VIP用户，每种用户可获取到的应用数据是不一样的。整个应用内，又有很多地方需要获取不同的数据。
 */

enum UserType { case Anonymous, General, VIP }

class User {
    let type: UserType
    init(type: UserType) { self.type = type }
}

protocol UserDataFetcher: class {
    func fetchData1() -> String
    func fetchData2() -> String
    func accept(user: User) -> Bool
}

class AnonymousUserDataFetcher: UserDataFetcher {
    func fetchData1() -> String {
        return "Anonymous User Data1"
    }
    
    func fetchData2() -> String {
        return "Anonymous User Data2"
    }
    
    func accept(user: User) -> Bool {
        return user.type == .Anonymous
    }
}

class GeneralUserDataFetcher: UserDataFetcher {
    func fetchData1() -> String {
        return "General User Data1"
    }
    
    func fetchData2() -> String {
        return "General User Data2"
    }
    
    func accept(user: User) -> Bool {
        return user.type == .General
    }
}

class VIPUserDataFetcher: UserDataFetcher {
    func fetchData1() -> String {
        return "VIP User Data1"
    }
    
    func fetchData2() -> String {
        return "VIP User Data2"
    }
    
    func accept(user: User) -> Bool {
        return user.type == .VIP
    }
}

class UserDataManager: UserDataFetcher {
    private var fetchers = [UserDataFetcher]()
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func add(fetcher: UserDataFetcher) {
        fetchers.append(fetcher)
    }
    
    func remove(fetcher: UserDataFetcher) {
//        if let index = fetchers.indexOf({ $0 === fetcher }) {
//            fetchers.removeAtIndex(index)
//        }
    }
    
    func fetchData1() -> String {
        if let fetcher = fetchers.filter({ $0.accept(user: user) }).first {
            return fetcher.fetchData1()
        } else {
            return "error data"
        }
    }
    
    func fetchData2() -> String {
        if let fetcher = fetchers.filter({ $0.accept(user: user) }).first {
            return fetcher.fetchData2()
        } else {
            return "error data"
        }
    }
    
    func accept(user: User) -> Bool {
        return fetchers.contains { $0.accept(user: user) }
    }
}

// 使用如下
let user = User(type: .Anonymous)
let userDataManager = UserDataManager(user: user)

userDataManager.add(fetcher: AnonymousUserDataFetcher())
userDataManager.add(fetcher: GeneralUserDataFetcher())
userDataManager.add(fetcher: VIPUserDataFetcher())

// 获取数据
userDataManager.fetchData1()
userDataManager.fetchData2()
