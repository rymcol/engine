/*
 SMTP Makes use of multiple RFC specs
 
 ESMTP
 https://tools.ietf.org/html/rfc1869#section-4.3
 SMTP
 https://tools.ietf.org/html/rfc5321#section-4.5.3.2
 
 AUTH
 https://tools.ietf.org/html/rfc821#page-4
 GREAT UNOFFICIAL AUTH
 http://www.fehcom.de/qmail/smtpauth.html

 LEGACY - DO NOT SUPPORT
 https://tools.ietf.org/html/rfc821#page-4
 */

import Base
print("\0test\0testpass".bytes.base64String)
print()

import Foundation

struct RFC1123 {
    static func now() -> String {
        return Date().rfc1123
    }

    static let shared = RFC1123()
    var formatter: DateFormatter

    init() {
        formatter = DateFormatter()
        formatter.locale = Locale(localeIdentifier: "en_US")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'"
    }
}

extension Date {
    public var rfc1123: String {
        return RFC1123.shared.formatter.string(from: self)
    }
}


//print(RFC1123.now())
//print("")

//import Engine
//
//struct Email {
//    let sender: String
//    let recipients: [String]
//}
//
import Engine
//let sssstream = try FoundationStream(host: "smtp.gmail.com", port: 587, securityLayer: .none)
//let cccconnection = try sssstream.connect()
//// 220 service ready greeting
////print(try cccconnection.receive(max: 5000).string)
///*
// 220 smtp.gmail.com ESMTP p39sm303264qtp.14 - gsmtp
// */
//try cccconnection.send("EHLO localhost \r\n")
//
///*
// https://tools.ietf.org/html/rfc5321#section-4.1.1.1
//
// 250-smtp.gmail.com at your service, [209.6.42.158]
// 250-SIZE 35882577
// 250-8BITMIME
// 250-AUTH LOGIN PLAIN XOAUTH2 PLAIN-CLIENTTOKEN OAUTHBEARER XOAUTH
// 250-ENHANCEDSTATUSCODES
// 250-PIPELINING
// 250-CHUNKING
// 250 SMTPUTF8
// 
// FINAL LINE IS `250` w/ NO `-`
// */
//print(try cccconnection.receive(max: 5000).string)
//
//try cccconnection.send("AUTH LOGIN\r\n")
//print(try cccconnection.receive(max: 5000).string)
//try cccconnection.send("vapor.smtptest@gmail.com".bytes.base64String + "\r\n")
//print(try cccconnection.receive(max: 5000).string)
//try cccconnection.send("vapor.test".bytes.base64String + "\r\n")
//print(try cccconnection.receive(max: 5000).string)
//try cccconnection.send("MAIL FROM:<vapor.smtptest@gmail.com> BODY=8BITMIME\r\n")
//print(try cccconnection.receive(max: 5000).string)
//try cccconnection.send("RCPT TO:<logan@qutheory.io> \r\n")
//print(try cccconnection.receive(max: 5000).string)
//try cccconnection.send("DATA\r\n")
//print(try cccconnection.receive(max: 5000).string)
///*
// C: Date: Thu, 21 May 1998 05:33:22 -0700
// C: From: John Q. Public <JQP@bar.com>
// C: Subject:  The Next Meeting of the Board
// C: To: Jones@xyz.com
// */
//try cccconnection.send("Subject: SMTP Subject Test\r\n")
//try cccconnection.send("Hello from smtp")
//try cccconnection.send("\r\n.\r\n")
//print(try cccconnection.receive(max: 5000).string)
//try cccconnection.send("QUIT\r\n")
//print(try cccconnection.receive(max: 5000).string)
//print("SMTP")

import Engine

import Foundation

extension NSUUID {
    static var smtpMessageId: String {
        return NSUUID().uuidString.components(separatedBy: "-").joined(separator: "")
    }
}

//struct InternetMessage {
//    /*
//     to /
//     cc /
//     bcc /
//     message-id /
//     in-reply-to /
//     references /
//     subject /
//     comments /
//     keywords /
//     optional-field)
//     */
//    let to: String
//    let from: String
//    let cc: [String]?
//    let bcc: [String]?
//    let id: String
//    let replyToId: String?
//
//}

/*
 Field           Min number      Max number      Notes

 trace           0               unlimited       Block prepended - see
 3.6.7

 resent-date     0*              unlimited*      One per block, required
 if other resent fields
 present - see 3.6.6

 resent-from     0               unlimited*      One per block - see
 3.6.6

 resent-sender   0*              unlimited*      One per block, MUST
 occur with multi-address
 resent-from - see 3.6.6

 resent-to       0               unlimited*      One per block - see
 3.6.6

 resent-cc       0               unlimited*      One per block - see
 3.6.6

 resent-bcc      0               unlimited*      One per block - see
 3.6.6

 resent-msg-id   0               unlimited*      One per block - see
 3.6.6

 orig-date       1               1

 from            1               1               See sender and 3.6.2



 Resnick                     Standards Track                    [Page 19]

 RFC 2822                Internet Message Format               April 2001


 sender          0*              1               MUST occur with multi-
 address from - see 3.6.2

 reply-to        0               1

 to              0               1

 cc              0               1

 bcc             0               1

 message-id      0*              1               SHOULD be present - see
 3.6.4

 in-reply-to     0*              1               SHOULD occur in some
 replies - see 3.6.4

 references      0*              1               SHOULD occur in some
 replies - see 3.6.4

 subject         0               1

 comments        0               unlimited

 keywords        0               unlimited

 optional-field  0               unlimited
 */



/*
 There are two limits that this standard places on the number of
 characters in a line. Each line of characters MUST be no more than
 998 characters, and SHOULD be no more than 78 characters, excluding
 the CRLF.

 The 998 character limit is due to limitations in many implementations
 which send, receive, or store Internet Message Format messages that
 simply cannot handle more than 998 characters on a line. Receiving
 implementations would do well to handle an arbitrarily large number
 of characters in a line for robustness sake. However, there are so
 many implementations which (in compliance with the transport
 requirements of [RFC2821]) do not accept messages containing more
 than 1000 character including the CR and LF per line, it is important
 for implementations not to create such messages.

 The more conservative 78 character recommendation is to accommodate
 the many implementations of user interfaces that display these
 messages which may truncate, or disastrously wrap, the display of
 more than 78 characters per line, in spite of the fact that such
 implementations are non-conformant to the intent of this
 specification (and that of [RFC2821] if they actually cause
 information to be lost). Again, even though this limitation is put on
 messages, it is encumbant upon implementations which display messages





 Resnick                     Standards Track                     [Page 6]

 RFC 2822                Internet Message Format               April 2001


 to handle an arbitrarily large number of characters in a line
 (certainly at least up to the 998 character limit) for the sake of
 robustness.
 */

//DispatchQueue.global(attributes: .qosBackground).after(when: DispatchTime(30), execute: { })

// TODO: MUST TIMEOUT
/*
 
 // TODO: MUST TIMEOUT
 
 4.5.3.2.  Timeouts

 An SMTP client MUST provide a timeout mechanism.  It MUST use per-
 command timeouts rather than somehow trying to time the entire mail
 transaction.  Timeouts SHOULD be easily reconfigurable, preferably
 without recompiling the SMTP code.  To implement this, a timer is set
 for each SMTP command and for each buffer of the data transfer.  The
 latter means that the overall timeout is inherently proportional to
 the size of the message.

 Based on extensive experience with busy mail-relay hosts, the minimum
 per-command timeout values SHOULD be as follows:
 
 */

extension DispatchTime {

    static var fiveMinutes: DispatchTime {
        // TODO: Currently can only set distant future or now :( fix when foundation updates
        return DispatchTime.distantFuture
    }
}


final class TimeoutOperation {
    typealias Timeout = (TimeoutOperation) -> Void

    let label: String
    private var timeout: Timeout?

    init(label: String, duration: DispatchTime, timeout: Timeout, queue: DispatchQueue = DispatchQueue.global(attributes: .qosBackground)) {
        self.label = label
        self.timeout = timeout

        queue.after(when: duration) { [weak self] in
            guard let welf = self, let timeout = welf.timeout else {
                // cancelled -- ok
                return
            }
            timeout(welf)
        }
    }

    func cancel() {
        timeout = nil
    }
}

enum TimeoutError: ErrorProtocol {
    case timedOut
}

import Base
//
//func timingOut<T>(_ time: Double, operation: () throws -> T) throws -> T {
//    Promise<T>.async(timingOut: <#T##DispatchTime#>, <#T##handler: (Promise<T>) throws -> Void##(Promise<T>) throws -> Void#>)
////    DispatchQueue.global(attributes: .qosBackground)
//}


extension Promise {
    static func timeout(_ timingOut: DispatchTime, operation: () throws -> T) throws -> T {
        // TODO: async is locked, it needs to be something like `block` or `lockForAsync`
        return try Promise<T>.async(timingOut: timingOut) { promise in
            let value = try operation()
            promise.resolve(with: value)
        }
    }
}

/*
 https://tools.ietf.org/html/rfc1869#section-4.3

 4.3.  Successful response

 If the server SMTP implements and is able to perform the EHLO
 command, it will return code 250.  This indicates that both the
 server and client SMTP are in the initial state, that is, there is no
 transaction in progress and all state tables and buffers are cleared.

 Normally, this response will be a multiline reply. Each line of the
 response contains a keyword and, optionally, one or more parameters.
 The syntax for a positive response, using the ABNF notation of [2],
 is:

 ehlo-ok-rsp  ::=      "250"    domain [ SP greeting ] CR LF
 / (    "250-"   domain [ SP greeting ] CR LF
 *( "250-"      ehlo-line           CR LF )
 "250"    SP ehlo-line           CR LF   )

 ; the usual HELO chit-chat
 greeting     ::= 1*<any character other than CR or LF>

 ehlo-line    ::= ehlo-keyword *( SP ehlo-param )

 ehlo-keyword ::= (ALPHA / DIGIT) *(ALPHA / DIGIT / "-")

 ; syntax and values depend on ehlo-keyword
 ehlo-param   ::= 1*<any CHAR excluding SP and all
 control characters (US ASCII 0-31
 inclusive)>

 ALPHA        ::= <any one of the 52 alphabetic characters
 (A through Z in upper case, and,
 a through z in lower case)>
 DIGIT        ::= <any one of the 10 numeric characters
 (0 through 9)>

 CR           ::= <the carriage-return character
 (ASCII decimal code 13)>
 LF           ::= <the line-feed character
 (ASCII decimal code 10)>
 */
extension String {
    var int: Int? {
        return Int(self)
    }
}

extension Collection {
    public subscript(safe idx: Index) -> Iterator.Element? {
        guard startIndex <= idx else { return nil }
        // NOT >=, endIndex is "past the end"
        guard endIndex > idx else { return nil }
        return self[idx]
    }
}

enum SMTPClientError: ErrorProtocol {
    case initializationFailed(code: Int, greeting: String)
    case initializationFailed554(reason: String)
    case invalidMultilineReplyCode(expected: Int, got: Int)
    case invalidEhloHeader
}

extension String: ErrorProtocol {}
import Base

private let crlf: Bytes = [.carriageReturn, .newLine]

struct SMTPExtension {

}

struct EmailAddress {
    let name: String?
    let address: String
}

//    /*
//     to /
//     cc /
//     bcc /
//     message-id /
//     in-reply-to /
//     references /
//     subject /
//     comments /
//     keywords /
//     optional-field)
//     */
struct EmailMessage {
    let from: EmailAddress
    let to: [EmailAddress]

    // TODO:
    //    var cc: [EmailAddress] = []
    //    var bcc: [EmailAddress] = []

    let id: String = NSUUID().uuidString.components(separatedBy: "-").joined(separator: "")
    // TODO:
    //    let inReplyTo: String? = nil

    let subject: String

    // TODO:
    //    var comments: [String] = []
    //    var keywords: [String] = []

    let date: String = RFC1123.now()

    // TODO:
    //    var extendedFields: [String: String] = [:]

    var body: Bytes

    init(from: EmailAddressRepresentable, to: EmailAddressRepresentable..., subject: String, message: String) {
        self.from = from.emailAddress
        self.to = to.map { $0.emailAddress }
        self.subject = subject
        self.body = message.bytes
    }
}

extension Sequence where Iterator.Element == EmailAddress {
    func smtpFormatted() -> String {
        return self.map { $0.smtpLongFormatted } .joined(separator: ", ")
    }
}

protocol EmailAddressRepresentable {
    var emailAddress: EmailAddress { get }
}

extension EmailAddress: EmailAddressRepresentable {
    var emailAddress: EmailAddress {
        return self
    }
}

extension String: EmailAddressRepresentable {
    var emailAddress: EmailAddress {
        return EmailAddress(name: nil, address: self)
    }
}

extension EmailAddress: StringLiteralConvertible {
    init(stringLiteral string: String) {
        self.init(name: nil, address: string)
    }

    init(extendedGraphemeClusterLiteral string: String){
        self.init(name: nil, address: string)
    }

    init(unicodeScalarLiteral string: String){
        self.init(name: nil, address: string)
    }
}

extension EmailAddress {
    var smtpLongFormatted: String {
        var formatted = ""

        if let name = self.name {
            formatted += name
            formatted += " "
        }
        formatted += "<\(address)>"
        return formatted
    }
}

struct SMTPHeader {
    let domain: String
    let greeting: String

    private init(_ line: String) throws {
        let split = line
            .bytes
            .split(separator: .space, maxSplits: 1)
            .map { $0.string }
        guard split.count >= 1 else { throw "must at least have domain" }
        domain = split[0]
        greeting = split[safe: 1] ?? ""
    }
}

/*
 ehlo-line    ::= ehlo-keyword *( SP ehlo-param )
 */
struct EHLOExtension {
    let keyword: String
    let params: [String]

    init(_ line: String) throws {
        let args = line.components(separatedBy: " ")
        guard let keyword = args.first else { throw "missing keyword" }
        self.keyword = keyword
        self.params = args.dropFirst().array // rm keyword
    }
}

extension String {
    func equals(caseInsensitive: String) -> Bool {
        return lowercased() == caseInsensitive.lowercased()
    }
}

enum SMTPAuthMethod {
    case plain
    case login
    // TODO: Support additional auth methods
}

struct SMTPAuth {
    let user: String
    let pass: String
}

extension Sequence where Iterator.Element == EHLOExtension {
    var authExtension: EHLOExtension? {
        return self.lazy.filter { $0.keyword.equals(caseInsensitive: "AUTH") } .first
    }
}


/*
 Specific sequences are:

 CONNECTION ESTABLISHMENT

 S: 220
 E: 554

 EHLO or HELO

 S: 250
 E: 504 (a conforming implementation could return this code only
 in fairly obscure cases), 550, 502 (permitted only with an old-
 style server that does not support EHLO)

 MAIL

 S: 250
 E: 552, 451, 452, 550, 553, 503, 455, 555

 RCPT

 S: 250, 251 (but see Section 3.4 for discussion of 251 and 551)
 E: 550, 551, 552, 553, 450, 451, 452, 503, 455, 555

 DATA

 I: 354 -> data -> S: 250

 E: 552, 554, 451, 452

 E: 450, 550 (rejections for policy reasons)

 E: 503, 554

 RSET

 S: 250

 VRFY

 S: 250, 251, 252
 E: 550, 551, 553, 502, 504

 EXPN

 S: 250, 252
 E: 550, 500, 502, 504

 HELP

 S: 211, 214
 E: 502, 504

 NOOP

 S: 250

 QUIT

 S: 221
*/

/*
 Timeouts - https://tools.ietf.org/html/rfc5321#section-4.5.3.2
 */
final class SMTPClient<ClientStreamType: ClientStream>: ProgramStream {
    let host: String
    let port: Int
    let securityLayer: SecurityLayer

    let stream: Engine.Stream

    init(host: String, port: Int, securityLayer: SecurityLayer) throws {
        self.host = host
        self.port = port
        self.securityLayer  = securityLayer

        let client = try ClientStreamType(host: host, port: port, securityLayer: securityLayer)
        self.stream = try client.connect()
    }

    deinit {
        if !stream.closed {
            _ = try? stream.close()
        }
    }

    // MARK: Initialization

    private func initializeSession(using auth: SMTPAuth) throws {
        // TODO: Timeouts
        try acceptGreeting()
        // TODO: Should default to localhost?
        let (_, extensions) = try initiate(fromDomain: "localhost")
        // TODO: Should upgrade to TLS here if STARTTLS command exists BEFORE authorizing
        try authorize(user: auth.user, pass: auth.pass, with: extensions)
    }

    private func authorize(user: String, pass: String, with extensions: [EHLOExtension]) throws {
        if let auth = extensions.authExtension {
            if auth.params.contains({ $0.equals(caseInsensitive: "LOGIN") }) {
                try authorize(method: .login, user: user, pass: pass)
            } else
                if auth.params.contains({ $0.equals(caseInsensitive: "PLAIN") }) {
                    try authorize(method: .plain, user: user, pass: pass)
                } else {
                    throw "no supported auth method"
            }
        } else {
            // no authorization required -- should we throw here?
            // I'm pretty sure classic SMTP is no login, aka, supah safe
            return
        }
    }

    // MARK: Quit

    private func quit() throws -> (code: Int, greeting: String) {
        try send(line: "QUIT")
        let (code, reply, isLast) = try acceptReplyLine()
        guard isLast && code == 221 else { throw "failed to quit \(code) \(reply)" }
        return (code, reply)
    }

    @discardableResult
    func send(_ email: EmailMessage, using auth: SMTPAuth) throws -> (code: Int, greeting: String) {
        // open
        try initializeSession(using: auth)

        // commands go here
        try send(email)

        // close
        return try quit()
    }

    private func send(_ email: EmailMessage) throws {
        try send(line: "MAIL FROM: <\(email.from.address)>", expectingReplyCode: 250)
        for to in email.to {
            try send(line: "RCPT TO: <\(to.address)>", expectingReplyCode: 250)
        }

        try transmitDATA(for: email)
    }

    private func transmitDATA(for email: EmailMessage) throws {
        // open data
        try send(line: "DATA", expectingReplyCode: 354)

        // Data Headers
        try send(line: "Date: \(RFC1123.now())")
        try send(line: "Message-id: \(email.id)")
        try send(line: "From: " + email.from.smtpLongFormatted)
        try send(line: "To:" + email.to.smtpFormatted())
        try send(line: "Subject: " + email.subject)
        try send(line: "") // empty line to start body
        // Data Headers End

        // Send Message
        try stream.send(email.body, flushing: true)
        // Message Done

        // TODO: Send Attachments

        // close data w/ data terminator
        try send(raw: "\r\n.\r\n", expectingCode: 250)
    }


    /*
     https://tools.ietf.org/html/rfc5321#section-3.1

     3.1.  Session Initiation

     An SMTP session is initiated when a client opens a connection to a
     server and the server responds with an opening message.

     SMTP server implementations MAY include identification of their
     software and version information in the connection greeting reply
     after the 220 code, a practice that permits more efficient isolation
     and repair of any problems.  Implementations MAY make provision for
     SMTP servers to disable the software and version announcement where
     it causes security concerns.  While some systems also identify their
     contact point for mail problems, this is not a substitute for
     maintaining the required "postmaster" address (see Section 4).

     The SMTP protocol allows a server to formally reject a mail session
     while still allowing the initial connection as follows: a 554
     response MAY be given in the initial connection opening message
     instead of the 220.  A server taking this approach MUST still wait
     for the client to send a QUIT (see Section 4.1.1.10) before closing
     the connection and SHOULD respond to any intervening commands with
     "503 bad sequence of commands".  Since an attempt to make an SMTP
     connection to such a system is probably in error, a server returning
     a 554 response on connection opening SHOULD provide enough
     information in the reply text to facilitate debugging of the sending
     system.

     */
    private func acceptGreeting() throws {
        // After connect, client receives from server first.
        let (replyCode, greeting, isLast) = try acceptReplyLine()
        // initialization should be single line w/ 220
        if isLast && replyCode == 220 { return }
        else {
            // quit
            _ = try? quit()
            throw SMTPClientError.initializationFailed(code: replyCode, greeting: greeting)
        }
    }

    /*
     https://tools.ietf.org/html/rfc5321#section-3.2

     3.2.  Client Initiation

     Once the server has sent the greeting (welcoming) message and the
     client has received it, the client normally sends the EHLO command to
     the server, indicating the client's identity.  In addition to opening
     the session, use of EHLO indicates that the client is able to process
     service extensions and requests that the server provide a list of the
     extensions it supports.  Older SMTP systems that are unable to
     support service extensions, and contemporary clients that do not
     require service extensions in the mail session being initiated, MAY
     use HELO instead of EHLO.  Servers MUST NOT return the extended EHLO-
     style response to a HELO command.  For a particular connection
     attempt, if the server returns a "command not recognized" response to
     EHLO, the client SHOULD be able to fall back and send HELO.

     In the EHLO command, the host sending the command identifies itself;
     the command may be interpreted as saying "Hello, I am <domain>" (and,
     in the case of EHLO, "and I support service extension requests").
     
     4.5.  Error responses from extended servers

     If the server SMTP recognizes the EHLO command, but the command
     argument is unacceptable, it will return code 501.

     If the server SMTP recognizes, but does not implement, the EHLO
     command, it will return code 502.

     If the server SMTP determines that the SMTP service is no longer
     available (e.g., due to imminent system shutdown), it will return
     code 421.

     In the case of any error response, the client SMTP should issue
     either the HELO or QUIT command.

     4.6.  Responses from servers without extensions

     A server SMTP that conforms to RFC 821 but does not support the
     extensions specified here will not recognize the EHLO command and
     will consequently return code 500, as specified in RFC 821.  The
     server SMTP should stay in the same state after returning this code
     (see section 4.1.1 of RFC 821).  The client SMTP may then issue
     either a HELO or a QUIT command.
     */


    /*
     https://tools.ietf.org/html/rfc1869#section-4.3

     4.3.  Successful response

     If the server SMTP implements and is able to perform the EHLO
     command, it will return code 250.  This indicates that both the
     server and client SMTP are in the initial state, that is, there is no
     transaction in progress and all state tables and buffers are cleared.

     Normally, this response will be a multiline reply. Each line of the
     response contains a keyword and, optionally, one or more parameters.
     The syntax for a positive response, using the ABNF notation of [2],
     is:

     ehlo-ok-rsp  ::=      "250"    domain [ SP greeting ] CR LF
     / (    "250-"   domain [ SP greeting ] CR LF
     *( "250-"      ehlo-line           CR LF )
     "250"    SP ehlo-line           CR LF   )

     ; the usual HELO chit-chat
     greeting     ::= 1*<any character other than CR or LF>

     ehlo-line    ::= ehlo-keyword *( SP ehlo-param )

     ehlo-keyword ::= (ALPHA / DIGIT) *(ALPHA / DIGIT / "-")

     ; syntax and values depend on ehlo-keyword
     ehlo-param   ::= 1*<any CHAR excluding SP and all
     control characters (US ASCII 0-31
     inclusive)>

     ALPHA        ::= <any one of the 52 alphabetic characters
     (A through Z in upper case, and,
     a through z in lower case)>
     DIGIT        ::= <any one of the 10 numeric characters
     (0 through 9)>
     
     CR           ::= <the carriage-return character
     (ASCII decimal code 13)>
     LF           ::= <the line-feed character
     (ASCII decimal code 10)>
     */
    private func initiate(fromDomain: String = "localhost") throws -> (header: SMTPHeader, extensions: [EHLOExtension]) {
        try send(line: "EHLO \(fromDomain)")
        var (code, replies) = try acceptReply()

        /*
         The 500 response indicates that the server SMTP does
         not implement thse extensions specified here.  The
         client would normally send a HELO command and proceed
         as specified in RFC 821.   See section 4.7 for
         additional discussion.
         */
        if code == 500 {
            try send(line: "HELO \(fromDomain)")
            (code, replies) = try acceptReply()
        }

        guard code == 250 else {
            /*
             In the case of any error response, the client SMTP should issue
             either the HELO or QUIT command.
             
             ^ we already tried HELO -- now we quit
             */
            _ = try? quit()
            throw "error initiating \(code)"
        }

        /*
            First line is header, subsequent lines are ehlo extensions
        */
        guard let header = try replies.first.flatMap(SMTPHeader.init) else { throw "response should have at least one line -- even in SMTP original" }
        let extensions = try replies.dropFirst().map(EHLOExtension.init)
        return (header, extensions)
    }

}

// MARK: Authorization

extension SMTPClient {
    private func authorize(method: SMTPAuthMethod, user: String, pass: String) throws {
        switch method {
        case .login:
            try authorizeLogin(user: user, pass: pass)
        case .plain:
            try authorizePlain(user: user, pass: pass)
        }
    }

    private func authorizeLogin(user: String, pass: String) throws {
        func handleUsername() throws {
            let (code, reply, isLast) = try acceptReplyLine()
            guard isLast else { throw "invalid username reply \(code) \(reply)" }
            guard code == 334 && reply.base64DecodedString.equals(caseInsensitive: "Username:") else { throw " invalid login reply \(code) \(reply)" }
            try send(line: user.bytes.base64String)
        }

        func handlePass() throws {
            let (code, reply, isLast) = try acceptReplyLine()
            guard isLast else { throw "invalid password reply \(code) \(reply)" }
            guard code == 334 && reply.base64DecodedString.equals(caseInsensitive: "Password:") else { throw " invalid login reply \(code) \(reply)" }
            try send(line: pass.bytes.base64String)
        }

        try send(line: "AUTH LOGIN")
        try handleUsername()
        try handlePass()

        let (code, reply, isLast) = try acceptReplyLine()
        guard isLast else { throw "unexpected authorization reply \(code) \(reply)" }
        guard code == 235 else { throw "authorization failed w/ \(code) \(reply)" }

        return // logged in successful
    }

    /*
     http://www.fehcom.de/qmail/smtpauth.html

     bash-2.05b$ printf "test" | base64 -e
     dGVzdA==
     bash-2.05b$ printf "testpass" | base64 -e
     dGVzdHBhc3M=
     bash-2.05b$ printf "\0test\0testpass" | base64 -e
     AHRlc3QAdGVzdHBhc3M=
     */
    private func authorizePlain(user: String, pass: String) throws {
        let plainAuth = "\0\(user)\0\(pass)".bytes.base64String
        try send(line: "AUTH PLAIN \(plainAuth)")
        let (code, reply, isLast) = try acceptReplyLine()
        // 235 == authorization successful
        guard isLast && code == 235 else { throw "invalid reply \(code) \(reply)" }

        // authorization successful
        return
    }
}

// MARK: Sending

extension SMTPClient {
    private func send(line: String) throws {
        try stream.send(line)
        try stream.send(crlf)
        try stream.flush()
    }

    private func send(raw: String) throws {
        try stream.send(raw)
        try stream.flush()
    }

    private func send(line: String, expectingReplyCode: Int) throws {
        try send(line: line)
        let (code, replies) = try acceptReply()
        guard code == expectingReplyCode else { throw "unexpected response to \(line) received \(code) \(replies) expected \(expectingReplyCode)" }
    }

    private func send(raw: String, expectingCode: Int) throws {
        try send(raw: raw)
        let (code, replies) = try acceptReply()
        guard code == expectingCode else { throw "unexpected response to \(raw) received \(code) \(replies) expected \(expectingCode)" }
    }
}

// MARK: Accept

extension SMTPClient {

    /*
     The format for multiline replies requires that every line, except the
     last, begin with the reply code, followed immediately by a hyphen,
     "-" (also known as minus), followed by text.  The last line will
     begin with the reply code, followed immediately by <SP>, optionally
     some text, and <CRLF>.  As noted above, servers SHOULD send the <SP>
     if subsequent text is not sent, but clients MUST be prepared for it
     to be omitted.

     For example:

     250-First line
     250-Second line
     250-234 Text beginning with numbers
     250 The last line

     In a multiline reply, the reply code on each of the lines MUST be the
     same.  It is reasonable for the client to rely on this, so it can
     make processing decisions based on the code in any line, assuming
     that all others will be the same.  In a few cases, there is important
     data for the client in the reply "text".  The client will be able to
     identify these cases from the current context.
     */
    private func acceptReply() throws -> (replyCode: Int, replies: [String]) {
        // first
        let (replyCode, initialReply, isLast) = try acceptReplyLine()
        var finished = isLast

        var replies: [String] = [initialReply]
        while !finished {
            let (code, reply, done) = try acceptReplyLine()
            guard code == replyCode else { throw SMTPClientError.invalidMultilineReplyCode(expected: replyCode, got: code) }
            replies.append(reply)
            finished = done
        }

        return (replyCode, replies)
    }

    private func acceptReplyLine() throws -> (replyCode: Int, reply: String, isLast: Bool) {
        let line = try stream.receiveLine()
        let replyCode = line.prefix(3).string.int ?? -1
        let token = line[safe: 3] // 0,1,2 == Status Code 3 is hyphen if should continue
        let reply = line.dropFirst(4).string
        // hyphen indicates continue, SHOULD send space, but doesn't have to
        // any NON-hyphen == last
        return (replyCode, reply, token != .hyphen)
    }
}

// MARK: Demo

let client = try SMTPClient<FoundationStream>(host: "smtp.sendgrid.net", port: 465, securityLayer: .tls)
let email = EmailMessage(from: "logan.william.wright@gmail.com",
                         to: "logan@qutheory.io",
                         subject: "smtp logins",
                         message: "it's all working!")
let auth = SMTPAuth(user: "smtp.test", pass: "smtp.pass1")
try client.send(email, using: auth)
print("")

//try originalWorkingSave()
