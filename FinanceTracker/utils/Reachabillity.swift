import Foundation
import SystemConfiguration

public class Reachability {
    
    // Check if internet connection is available
    
    class func isConnectedToNetwork() -> Bool {
        
        var status:Bool = false
        
        let url = NSURL(string: "https://google.com")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response:URLResponse?
        let _ = URLSession.shared.dataTask(with: request as URLRequest) {data,iresponse,error in
            if let err = error {
                print(err.localizedDescription)
            }
            if let gotresponse = iresponse {
                response = gotresponse
            }
        }

        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                status = true
            }
        }
        return status
    }
}
