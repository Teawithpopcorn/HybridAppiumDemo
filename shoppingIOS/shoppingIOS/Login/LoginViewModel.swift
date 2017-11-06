class LoginViewModel {
    enum LoginValidateError: String {
        case none
        case noUserName = "请输入用户名"
        case noPassword = "请输入密码"
    }
    
    var userName: String?
    var password: String?
    
    func validate() -> LoginValidateError {
        guard let userName = userName, !userName.isEmpty else {
            return .noUserName
        }
        
        guard let password = password, !password.isEmpty else  {
            return .noPassword
        }
        
        return .none
    }
}
