//
//  GetDeviceIP.swift
//  SXProject
//
//  Created by 王威 on 2024/4/11.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import NetworkExtension

class GetDeviceIP: NSObject {
 
  
   static func getCurrentWiFiIPAddress() -> String? {
        var ipAddress: String?
        
        if let interface = NEHotspotHelper.supportedNetworkInterfaces()?.first {
            let interfaceName = (interface as AnyObject).ssid
            
            var ifaddr: UnsafeMutablePointer<ifaddrs>?
            
            if getifaddrs(&ifaddr) == 0 {
                var ptr = ifaddr
                
                while ptr != nil {
                    defer { ptr = ptr?.pointee.ifa_next }
                    
                    guard let name = ptr?.pointee.ifa_name else { continue }
                    
                    let interfaceIndex = Int32((interfaceName?.utf8CString.first!)!)
                    let currentInterfaceIndex = Int32(name.pointee)
                    
                    if currentInterfaceIndex == interfaceIndex {
                        let addr = ptr?.pointee.ifa_addr.pointee
                        
                        if addr?.sa_family == UInt8(AF_INET) {
                            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                            
//                            if getnameinfo(addr, socklen_t((addr?.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0 {
//
//                            }
                            ipAddress = String(cString: hostname)
                        }
                    }
                }
                
                freeifaddrs(ifaddr)
            }
        }
        
        return ipAddress
    }

//    // Usage example
//    if let ipAddress = getCurrentWiFiIPAddress() {
//        print("Current Wi-Fi IP Address: \(ipAddress)")
//    } else {
//        print("Failed to retrieve Wi-Fi IP Address.")
//    }
    // 使用函数
//    if let ipAddress = getCurrentWiFiIPAddress() {
//        print("Current WiFi IP Address: \(ipAddress)")
//    } else {
//        print("Could not retrieve IP address.")
//    }
    
    
}
