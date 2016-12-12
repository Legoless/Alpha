//
//  ALPHABonjourServer.h
//  Alpha
//
//  Created by Dal Rupnik on 12/12/2016.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

//
// This file is ported from DTBonjour library, by Oliver Drobnik
//


#import "ALPHABonjourDataConnection.h"

@class ALPHABonjourServer;

/**
 The delegate protocol by which the ALPHABonjourServer communicates about events
 */
@protocol ALPHABonjourServerDelegate <NSObject>
@optional

/**
 Called when a new incoming connection was accepted by the server.
 @param server The server
 @param connection The connection that was accepted
 */
- (void)bonjourServer:(ALPHABonjourServer *)server didAcceptConnection:(ALPHABonjourDataConnection *)connection;

/**
 Called when a client connection was closed.
 @param server The server
 @param connection The connection that was closed
 */
- (void)bonjourServer:(ALPHABonjourServer *)server didCloseConnection:(ALPHABonjourDataConnection *)connection;

/**
 Called when the server received a new object on a given connection
 @param server The server
 @param object The decoded object that was received
 @param connection The individual connection that it was received on
 */
- (void)bonjourServer:(ALPHABonjourServer *)server didReceiveObject:(id)object onConnection:(ALPHABonjourDataConnection *)connection;
@end

/**
 This class represents a service that clients can connect to. It owns its inbound connections and thus you should never modify the delegate of the individual data connections.
 
 On iOS the server is automatically stopped if the app enters the background and restarted when the app comes back into the foreground.
 */
@interface ALPHABonjourServer : NSObject <ALPHABonjourDataConnectionDelegate>

/**
 @name Creating a Server
 */

/**
 Creates a server instances with the given bonjour type, e.g. "_servicename._tcp"
 @param bonjourType The full service type string
 */
- (id)initWithBonjourType:(NSString *)bonjourType;

/**
 @name Server Lifetime
 */

/**
 Starts up the server, prepares it to be connected to and publishes the service via Bonjour
 @returns `YES` if the startup was successful
 */
- (BOOL)start;

/**
 Stops the service
 */
- (void)stop;

/**
 @name Sending Objects
 */

/**
 Sends the object to all currently connected clients.
 
 Note: any errors will be ignored. If you require finer-grained control then you should iterate over the individual connections.
 @param object The object that will be encoded and sent to all clients
 */
- (void)broadcastObject:(id)object;

/**
 @name Getting Information
 */

/**
 The delegate that will be informed about activities happening on the server.
 */
@property (nonatomic, weak) id <ALPHABonjourServerDelegate> delegate;

/**
 The actual port bound to, valid after -start
 */
@property (nonatomic, assign, readonly ) NSUInteger port;

/**
 The currently connected inbound ALPHABonjourDataConnection instances.
 */
@property (nonatomic, readonly) NSSet *connections;

/**
 The TXT Record attached to the Bonjour service.
 
 Updating this property while the server is running will update the broadcast TXTRecord. The server has its own instance of the TXTRecord so that it can be set even before calling start.
 */
@property (nonatomic, strong) NSDictionary *TXTRecord;

@end
