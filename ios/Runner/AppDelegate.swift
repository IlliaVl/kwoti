import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
            let shareWhatsAppChannel = FlutterMethodChannel(name: "com.example.kwoti/share_whats_app",
                                                            binaryMessenger: controller.binaryMessenger)
            shareWhatsAppChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                
                guard call.method == "shareToWhatsApp" else {
                    result(FlutterMethodNotImplemented)
                    return
                }
                
                let args = call.arguments as? Dictionary<String,Any>
                self.shareWhatsApp(message: args!["msg"] as! String, result: result)
            })
            
            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
    
    func shareWhatsApp(message:String, result: @escaping FlutterResult)  {
        let whatsURL = "whatsapp://send?text=\(message)"
        
        var characterSet = CharacterSet.urlQueryAllowed
        characterSet.insert(charactersIn: "?&")
        let whatsAppURL  = NSURL(string: whatsURL.addingPercentEncoding(withAllowedCharacters: characterSet)!)
        if UIApplication.shared.canOpenURL(whatsAppURL! as URL)
        {
            if let url = URL(string: "\(String(describing: whatsAppURL))"), !url.absoluteString.isEmpty {
                result("Sucess");
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        else
        {
            result(FlutterError(code: "Not found", message: "WhatsApp is not found", details: "WhatsApp not intalled or Check url scheme."));
        }
    }
    
}
