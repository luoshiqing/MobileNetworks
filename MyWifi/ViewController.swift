//
//  ViewController.swift
//  MyWifi
//
//  Created by sqluo on 2017/1/11.
//  Copyright © 2017年 sqluo. All rights reserved.
//

import UIKit

import SystemConfiguration
import CoreTelephony

/**
 1.https://developer.apple.com/library/content/samplecode/Reachability/Introduction/Intro.html#//apple_ref/doc/uid/DTS40007324-Intro-DontLinkElementID_2  下载demo
 2.把里边的 Reachability.h 跟 Reachability.m 导入工程
 3.导入类  #import "Reachability.h"
 4.导入 
    oc版:
        #import <CoreTelephony/CTCarrier.h>
        #import <CoreTelephony/CTTelephonyNetworkInfo.h>
    swift版:
        import SystemConfiguration
        import CoreTelephony
 5.把 NetworkConnectType 导入至工程
 6.调用 let type = NetworkConnectType.type
*/

class NetworkConnectType {
    
    public class var type: String{
        return NetworkConnectType.getNetconnType().str
    }
    fileprivate enum NetconnType {
        case none   //没有网络
        case wifi   //wifi
        //自带网络
        case gps    //GPS
        case g2     //2G
        case g3     //3G
        case g35    //3.5G
        case hrpd   //HRPD
        case g4     //4G
        
        var str:String{
            switch self {
            case .none: return "没有网络"
            case .wifi: return "wifi"
            case .gps:  return "GPS"
            case .g2:   return "2G"
            case .g3:   return "3G"
            case .g35:  return "3.5G"
            case .hrpd: return "HRPD"
            case .g4:   return "4G"
            }
        }
    }
    fileprivate class func getNetconnType() ->NetconnType{
        let reach = Reachability(hostName: "www.apple.com")
        switch reach!.currentReachabilityStatus() {
        case NetworkStatus(rawValue: 0): return .none
        case NetworkStatus(rawValue: 1): return .wifi
        case NetworkStatus(rawValue: 2):
            let info = CTTelephonyNetworkInfo()
            if let currentStatus = info.currentRadioAccessTechnology{
                switch currentStatus {
                case CTRadioAccessTechnologyGPRS:   return .gps
                case CTRadioAccessTechnologyEdge:   return .g2
                case CTRadioAccessTechnologyWCDMA:  return .g3
                case CTRadioAccessTechnologyHSDPA:  return .g35
                case CTRadioAccessTechnologyHSUPA:  return .g35
                case CTRadioAccessTechnologyCDMA1x: return .g2
                case CTRadioAccessTechnologyCDMAEVDORevB,CTRadioAccessTechnologyCDMAEVDORev0,CTRadioAccessTechnologyCDMAEVDORevB:
                                                    return .g3
                case CTRadioAccessTechnologyeHRPD:  return .hrpd
                case CTRadioAccessTechnologyLTE:    return .g4
                default:                            return .none
                }
            }
        default:
            break
        }
        return .none
    }
}



//调用
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        let type = NetworkConnectType.type
        print(type)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

