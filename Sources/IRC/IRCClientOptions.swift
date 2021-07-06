//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-nio-irc open source project
//
// Copyright (c) 2018 ZeeZide GmbH. and the swift-nio-irc project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftNIOIRC project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import protocol NIO.EventLoopGroup
import class    NIO.MultiThreadedEventLoopGroup

fileprivate let onDemandSharedEventLoopGroup =
MultiThreadedEventLoopGroup(numberOfThreads: 1)

/// Configuration options for the socket connects
open class ConnectOptions : CustomStringConvertible {
    
    public var eventLoopGroup  : EventLoopGroup
    public var hostname        : String?
    public var port            : Int
    public var securityOptions : IRCClientSecurityOptions
    
    public init(hostname: String? = "localhost", port: Int = 80, securityOptions: IRCClientSecurityOptions = IRCClientSecurityOptions(useSecure: false),
                eventLoopGroup: EventLoopGroup? = nil)
    {
        self.hostname = hostname
        self.port     = port
        self.securityOptions = securityOptions
        self.eventLoopGroup = eventLoopGroup
        ?? MultiThreadedEventLoopGroup.currentEventLoop
        ?? onDemandSharedEventLoopGroup
    }
    
    public var description: String {
        var ms = "<\(type(of: self)):"
        appendToDescription(&ms)
        ms += ">"
        return ms
    }
    
    open func appendToDescription(_ ms: inout String) {
        if let hostname = hostname { ms += " \(hostname):\(port)" }
        else { ms += " \(port)" }
    }
    
}


import NIOIRC

public let DefaultIRCPort = 6667

/// Configuration options for the IRC client object
open class IRCClientOptions : ConnectOptions {
    
    open var password      : String?
    open var nickname      : IRCNickName
    open var userInfo      : IRCUserInfo
    open var retryStrategy : IRCRetryStrategyCB?
    
    public convenience init(nick: String) {
        self.init(nickname: IRCNickName(nick)!)
    }
    
    public init(port            : Int                      = DefaultIRCPort,
                host            : String                   = "localhost",
                securityOptions : IRCClientSecurityOptions = defaultSecurityOptions,
                password        : String?                  = nil,
                nickname        : IRCNickName,
                userInfo        : IRCUserInfo?             = nil,
                eventLoopGroup  : EventLoopGroup?          = nil)
    {
        self.password      = password
        self.nickname      = nickname
        self.retryStrategy = nil
        
        self.userInfo = userInfo ?? IRCUserInfo(username: nickname.stringValue,
                                                hostname: host, servername: host,
                                                realname: "NIO IRC User")
        
        super.init(hostname: host, port: port, securityOptions: securityOptions, eventLoopGroup: eventLoopGroup)
    }
    
    override open func appendToDescription(_ ms: inout String) {
        super.appendToDescription(&ms)
        ms += " \(nickname)"
        ms += " \(userInfo)"
        if password      != nil { ms += " pwd"                  }
        if retryStrategy != nil { ms += " has-retryStrategy-cb" }
    }
}

public let defaultSecurityOptions = IRCClientSecurityOptions()

/// Client Security Options
open class IRCClientSecurityOptions {
    open var useSecure: Bool
    open var verficationMode: CertificateVerificationMode?
    
    public init(useSecure: Bool = false, vertificationMode: CertificateVerificationMode? = .strict) {
        self.useSecure = useSecure
        self.verficationMode = vertificationMode
    }
    
    public enum CertificateVerificationMode {
        case strict
        case lax
        case noChecks
    }
}
