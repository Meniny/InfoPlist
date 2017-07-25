
#if os(OSX)
    import Cocoa
#else
    import Foundation
    import UIKit
#endif

/// Info.plist assistant.
public class InfoPlist {
    
    /// Info.plist as a dictionary objec
    public static var dictionary: [String: Any]? {
        return Bundle.main.infoDictionary
    }
    
    /// Getting string, could be empty
    ///
    /// - Parameter key: Key String
    /// - Returns: `String` object, could be empty
    public static func getStringValue(forKey key: String) -> String {
        return (getValue(forKey: key) as? String) ?? ""
    }
    
    /// Getting string, could be `nil`
    ///
    /// - Parameter key: Key String
    /// - Returns: `String?` object, could be `nil`
    public static func getString(forKey key: String) -> String? {
        return getValue(forKey: key) as? String
    }
    
    /// Getting Bool value
    ///
    /// - Parameter key: Key String
    /// - Returns: `Bool` value
    public static func getBool(forKey key: String) -> Bool {
        return (InfoPlist.getValue(forKey: key) as? Bool) ?? false
    }
    
    /// Getting value, could be `nil`
    ///
    /// - Parameter key: Key String
    /// - Returns: `Any?`, could be `nil`
    public static func getValue(forKey key: String) -> Any? {
        guard let infoDictionary = InfoPlist.dictionary else {
            return nil
        }
        return infoDictionary[key]
    }
}

// MARK: - Common
public extension InfoPlist {
    /// CFBundleDisplayName
    public static var bundleDisplayName: String = {
        return InfoPlist.getStringValue(forKey: "CFBundleDisplayName")
    }()
    
    /// CFBundleName
    public static var bundleName: String = {
        return InfoPlist.getStringValue(forKey: "CFBundleName")
        
    }()
    
    /// Return CFBundleDisplayName if not empty, otherwise return CFBundleName
    public static var name: String = {
        return !bundleDisplayName.isEmpty ? bundleDisplayName : bundleName
    }()
    
    /// CFBundleShortVersionString
    public static var version: String = {
        return InfoPlist.getStringValue(forKey: "CFBundleShortVersionString")
    }()
    
    /// CFBundleVersion
    public static var build: String = {
        return InfoPlist.getStringValue(forKey: "CFBundleVersion")
    }()
    
    /// CFBundleExecutable
    public static var executable: String = {
        return InfoPlist.getStringValue(forKey: "CFBundleExecutable")
    }()
    
    /// CFBundleIdentifier
    public static var bundleIndentifier: String = {
        return InfoPlist.getStringValue(forKey: "CFBundleIdentifier")
    }()
    
    /// CFBundleURLTypes.first[CFBundleURLSchemes]
    public static var schemes: [String] = {
        guard let urlTypes = InfoPlist.getValue(forKey: "CFBundleURLTypes") as? [AnyObject],
            let urlType = urlTypes.first as? [String : AnyObject],
            let urlSchemes = urlType["CFBundleURLSchemes"] as? [String] else {
                return []
        }
        
        return urlSchemes
    }()
    
    /// Main Scheme String, could be `nil`
    public static var mainScheme: String? = {
        return schemes.first
    }()
    
    /// if `zh-Hans` is one of the preferred languages
    public static var usingChinese: Bool {
        if let l = NSLocale.preferredLanguages.first {
            return l.contains("zh-Hans")
        }
        return false
    }
}

#if os(iOS)
// MARK: - iOS Only
public extension InfoPlist {
    
    /// UIFileSharingEnabled
    @available(iOS 7.0, *)
    public static var iTunesFileSharingEnabled: Bool = {
        return InfoPlist.getBool(forKey: "UIFileSharingEnabled")
    }()
    
    /// UIStatusBarHidden
    @available(iOS 7.0, *)
    public static var isStatusBarHidden: Bool = {
        return InfoPlist.getBool(forKey: "UIStatusBarHidden")
    }()
    
    /// UIStatusBarStyle
    @available(iOS 7.0, *)
    public static var statusBarStyleString: String? = {
        return InfoPlist.getString(forKey: "UIStatusBarStyle")
    }()
    
    /// UIStatusBarStyle
    @available(iOS 7.0, *)
    public static var statusBarStyle: UIStatusBarStyle? = {
        guard let style = InfoPlist.statusBarStyleString else {
            return nil
        }
        switch style {
        case "UIStatusBarStyleDefault":
            return UIStatusBarStyle.default
        case "UIStatusBarStyleLightContent":
            return UIStatusBarStyle.lightContent
        default:
            return nil
        }
    }()
    
    /// UIViewControllerBasedStatusBarAppearance
    @available(iOS 7.0, *)
    public static var viewControllerBasedStatusBarAppearance: Bool = {
        return InfoPlist.getBool(forKey: "UIViewControllerBasedStatusBarAppearance")
    }()
    
    /// UISupportedInterfaceOrientations
    @available(iOS 7.0, *)
    public static var iPhoneSupportedInterfaceOrientationStrings: [String] = {
        (InfoPlist.getValue(forKey: "UISupportedInterfaceOrientations") as? [String]) ?? []
    }()
    
    /// UISupportedInterfaceOrientations
    @available(iOS 7.0, *)
    public static var iPhoneSupportedInterfaceOrientations: [UIInterfaceOrientation] = {
        return InfoPlist.supportedInterfaceOrientations(of: InfoPlist.iPhoneSupportedInterfaceOrientationStrings)
    }()
    
    /// UISupportedInterfaceOrientations~ipad
    @available(iOS 7.0, *)
    public static var iPadSupportedInterfaceOrientationStrings: [String] = {
        return (InfoPlist.getValue(forKey: "UISupportedInterfaceOrientations~ipad") as? [String]) ?? []
    }()
    
    /// UISupportedInterfaceOrientations~ipad
    @available(iOS 7.0, *)
    public static var iPadSupportedInterfaceOrientations: [UIInterfaceOrientation] = {
        return InfoPlist.supportedInterfaceOrientations(of: InfoPlist.iPadSupportedInterfaceOrientationStrings)
    }()
    
    @available(iOS 7.0, *)
    private static func supportedInterfaceOrientations(of strings: [String]) -> [UIInterfaceOrientation] {
        var orientations = [UIInterfaceOrientation]()
        for str in strings {
            var o = UIInterfaceOrientation.unknown
            switch str {
            case "UIInterfaceOrientationPortrait":
                o = .portrait
                break
            case "UIInterfaceOrientationPortraitUpsideDown":
                o = .portraitUpsideDown
                break
            case "UIInterfaceOrientationLandscapeLeft":
                o = .landscapeLeft
                break
            case "UIInterfaceOrientationLandscapeRight":
                o = .landscapeRight
                break
            default:
                break
            }
            if !orientations.contains(o) {
                orientations.append(o)
            }
        }
        return orientations
    }
}
#endif

// MARK: - iOS 9 or macOS 10.11
public extension InfoPlist {
    
    @available(iOS 9.0, OSX 10.11, *)
    public static var appTransportSecurityConfiguration: [String: Any]? = {
        return InfoPlist.getValue(forKey: "NSAppTransportSecurity") as? [String: Any]
    }()
    
    @available(iOS 9.0, OSX 10.11, *)
    public static var allowsArbitraryLoads: Bool = {
        guard let infoDictionary = InfoPlist.appTransportSecurityConfiguration else {
            return false
        }
        return (infoDictionary["NSAllowsArbitraryLoads"] as? Bool) ?? false
    }()
    #if os(iOS)
    @available(iOS 9.0, *)
    public static var requiresFullScreen: Bool = {
        return InfoPlist.getBool(forKey: "UIRequiresFullScreen")
    }()
    #endif
}

// MARK: - Privacy
public extension InfoPlist {
    
    /// Privacy - NSBluetoothPeripheralUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var bluetoothPeripheralUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSBluetoothPeripheralUsageDescription")
    }()
    
    /// Privacy - NSCalendarsUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var calendarsUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSCalendarsUsageDescription")
    }()
    
    /// Privacy - NSCameraUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var cameraUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSCameraUsageDescription")
    }()
    
    /// Privacy - NSContactsUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var contactsUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSContactsUsageDescription")
    }()
    
    /// Privacy - NSHealthShareUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var healthShareUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSHealthShareUsageDescription")
    }()
    
    /// Privacy - NSHealthUpdateUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var healthUpdateUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSHealthUpdateUsageDescription")
    }()
    
    /// Privacy - NSHomeKitUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var homeKitUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSHomeKitUsageDescription")
    }()
    
    /// Privacy - NSLocationAlwaysUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var locationAlwaysUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSLocationAlwaysUsageDescription")
    }()
    
    /// Privacy - NSLocationUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var locationUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSLocationUsageDescription")
    }()
    
    /// Privacy - NSLocationWhenInUseUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var locationWhenInUseUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSLocationWhenInUseUsageDescription")
    }()
    
    /// Privacy - NSAppleMusicUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var appleMusicUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSAppleMusicUsageDescription")
    }()
    
    /// Privacy - NSMicrophoneUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var microphoneUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSMicrophoneUsageDescription")
    }()
    
    /// Privacy - NSMotionUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var motionUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSMotionUsageDescription")
    }()
    
    /// Privacy - NSPhotoLibraryUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var photoLibraryUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSPhotoLibraryUsageDescription")
    }()
    
    /// Privacy - NSRemindersUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var remindersUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSRemindersUsageDescription")
    }()
    
    /// Privacy - NSSiriUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var siriUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSSiriUsageDescription")
    }()
    
    /// Privacy - NSSpeechRecognitionUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var speechRecognitionUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSSpeechRecognitionUsageDescription")
    }()
    
    /// Privacy - NSVideoSubscriberAccountUsageDescription
    @available(iOS 10.0, OSX 10.12, *)
    public static var videoSubscriberAccountUsageDescription: String? = {
        return InfoPlist.getString(forKey: "NSVideoSubscriberAccountUsageDescription")
    }()
    
}