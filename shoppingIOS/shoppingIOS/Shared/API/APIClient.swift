
import Alamofire
import PromiseKit

typealias Promise = PromiseKit.Promise

protocol DataRequestPromise {
    func responseModel<T: Decodable>(type: T.Type) -> Promise<T>
    func responseVoid() -> Promise<Void>
}

public class APIClient {
    let baseURLString: String
    init(baseUrl: String) {
        self.baseURLString = baseUrl
    }
    
    func get(endpoint: String, parameters: Parameters? = nil) -> DataRequestPromise {
        return request(endpoint,
                       method: .get,
                       parameters: parameters)
    }
    
    func post(endpoint: String, parameters: Parameters? = nil) -> DataRequestPromise {
        return request(endpoint,
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default)
    }
    
    func patch(endpoint: String, parameters: Parameters? = nil) -> DataRequestPromise {
        return request(endpoint,
                       method: .patch,
                       parameters: parameters,
                       encoding: JSONEncoding.default)
    }
    
    private func request(_ endpoint: String,
                         method: HTTPMethod,
                         parameters: Parameters? = nil,
                         encoding: ParameterEncoding = URLEncoding.default) -> DataRequestPromise {
        
        let finalUrl = "\(baseURLString)\(endpoint)"
        let defaultHeaders = ["Content-Type": "application/json"]
    
        return Alamofire
            .request(finalUrl, method: method, parameters: parameters, encoding: encoding, headers: defaultHeaders)
            .validate(self.validate)
    }
    
    private func validate(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Request.ValidationResult {
        let acceptableStatusCodes = 200..<300
        if acceptableStatusCodes.contains(response.statusCode) {
            return .success
        }
        
        let statusCode = response.statusCode
        let failureReason = "Error code: \(statusCode)"
        return .failure(NSError.error(statusCode, failureReason: failureReason))
    }
}

let ShoppingAPIClient = APIClient(baseUrl: "https://tw-shopping.herokuapp.com")

extension Alamofire.DataRequest : DataRequestPromise {
    func responseVoid() -> Promise<Void> {
        return response().then { _ -> Void in }
    }
    
    func responseModel<T: Decodable>(type: T.Type) -> Promise<T> {
        return responseData()
            .then { (data) -> T in
                self.printErrorResponse(responseData: data)
                return try! JSONDecoder().decode(type, from: data)
        }
    }
    
    private func printErrorResponse(responseData: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
            print("The raw reponse is:")
            print("\(json)\n")
        } catch {}
    }
}

extension NSError {
    static func error(_ domain: String, code: Int, failureReason: String) -> NSError {
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
    

    static func error(_ code: Int = -9999, failureReason: String) -> NSError {
        return error("com.shopping.error", code: code, failureReason: failureReason)
    }
}


