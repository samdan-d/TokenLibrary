import Foundation

@available(iOS 11.0, *)
public struct TokenLibrary {
    public private(set) var text = "Hello, World!"

    private var accessToken: String?

    public init() {}

    let entityId = "mplus.mn"
    let token = "VnZCSkdIZWk4Q21XeWx3bw"
    let code = "BBE586D4EAE65BF7E0532A64A8C097BA"

    public func getAuthToken(callback: @escaping (_ data: GetAuthTokenResponse?, _ error: Response?) -> Void) {
        HpsHttpClient.post(url: "v2/auth/token", parameters: [
            "code": code,
            "client_secret": token,
            "redirect_uri": "",
            "client_id": entityId,
            "grant_type": "authorization_code",
        ]) { data, error in
            if let data = data {
                let result = try? JSONDecoder().decode(GetAuthTokenResponse.self, from: data)
                HpsHttpClient.setAccessToken(token: result?.access_token)
                callback(result, error)
            } else {
                callback(nil, error)
            }
        }
    }
}
