# Chat Service Documentation

## Service Overview

The Chat Service provides real-time messaging, video calling, and communication features for the JLOV dating platform. It handles WebSocket connections, message sending/receiving, conversation management, typing indicators, message reactions, and video call functionality. The service supports both public user interactions and private administrative operations.

## Service Details

- **Runtime**: Node.js 22.x
- **Authentication**: AWS Cognito User Pools
- **Real-time Communication**: WebSocket API Gateway
- **Video Calls**: Integration with video calling services
- **Database**: Chat and conversation database

## Lambda Functions

### WebSocket Management Functions

#### websocketHandler
**Purpose**: Handles WebSocket connections and real-time communication
- **Handler**: `src/functions/chat/websocket/handleWebSocket.handleWebSocketHandler`
- **Trigger**: WebSocket API Gateway
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `event.requestContext.connectionId` - WebSocket connection ID
  - `event.requestContext.authorizer` - User authentication data
  - `event.body` - WebSocket message payload
- **Returns**: WebSocket response or broadcast message

### Message Management Functions

#### sendMessage
**Purpose**: Sends a message in a conversation
- **Handler**: `src/functions/chat/sendMessage.sendMessageHandler`
- **Path**: `/messages`
- **Method**: POST
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.conversationId` - ID of the conversation
  - `body.message` - Message content
  - `body.messageType` (optional) - Type of message (text, image, etc.)
  - `body.attachments` (optional) - Message attachments
- **Returns**:
  - `201` - Message sent successfully
  - `400` - Invalid message data
  - `401` - Unauthorized
  - `404` - Conversation not found
  - `500` - Server error

#### sendMessageAdmin
**Purpose**: Sends a message as an administrator (private function)
- **Handler**: `src/functions/chat/sendMessage.sendMessageAdminHandler`
- **Path**: `/private/messages`
- **Method**: POST
- **CORS**: true
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.conversationId` - ID of the conversation
  - `body.message` - Message content
  - `body.senderId` - Admin sender ID
  - `body.messageType` (optional) - Type of message
- **Returns**:
  - `201` - Message sent successfully
  - `400` - Invalid message data
  - `401` - Unauthorized
  - `404` - Conversation not found
  - `500` - Server error

#### getHistoryMessagesPage
**Purpose**: Retrieves message history for a conversation with pagination
- **Handler**: `src/functions/chat/getHistoryMessagesPage.getHistoryMessagesPageHandler`
- **Path**: `/conversations/{conversationId}/messages/history`
- **Method**: GET
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.conversationId` - ID of the conversation
  - `queryStringParameters.limit` (optional) - Number of messages to retrieve
  - `queryStringParameters.before` (optional) - Get messages before this timestamp
  - `queryStringParameters.after` (optional) - Get messages after this timestamp
- **Returns**:
  - `200` - Messages retrieved successfully
  - `401` - Unauthorized
  - `404` - Conversation not found
  - `500` - Server error

#### getUnreadMessages
**Purpose**: Retrieves unread messages for a conversation
- **Handler**: `src/functions/chat/getUnreadMessages.getUnreadMessagesHandler`
- **Path**: `/conversations/{conversationId}/messages/unread`
- **Method**: GET
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.conversationId` - ID of the conversation
- **Returns**:
  - `200` - Unread messages retrieved successfully
  - `401` - Unauthorized
  - `404` - Conversation not found
  - `500` - Server error

#### markLastReadMessage
**Purpose**: Marks the last read message in a conversation
- **Handler**: `src/functions/chat/markLastReadMessage.markLastReadMessageHandler`
- **Path**: `/messages/{messageId}/read`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.messageId` - ID of the message to mark as read
- **Returns**:
  - `200` - Message marked as read successfully
  - `401` - Unauthorized
  - `404` - Message not found
  - `500` - Server error

#### markMessageAsDeleted
**Purpose**: Marks a message as deleted
- **Handler**: `src/functions/chat/markMessageAsDeleted.markMessageAsDeletedHandler`
- **Path**: `/messages/{messageId}`
- **Method**: DELETE
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.messageId` - ID of the message to delete
- **Returns**:
  - `200` - Message marked as deleted successfully
  - `401` - Unauthorized
  - `404` - Message not found
  - `500` - Server error

#### reactMessage
**Purpose**: Adds or updates a reaction to a message
- **Handler**: `src/functions/chat/reactMessage.reactMessageHandler`
- **Path**: `/messages/{messageId}/reaction/{reaction}`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.messageId` - ID of the message
  - `pathParameters.reaction` - Reaction type (like, love, etc.)
- **Returns**:
  - `200` - Reaction added/updated successfully
  - `400` - Invalid reaction type
  - `401` - Unauthorized
  - `404` - Message not found
  - `500` - Server error

### Conversation Management Functions

#### getConversations
**Purpose**: Retrieves conversations for the authenticated user
- **Handler**: `src/functions/getConversations.getConversationsHandler`
- **Path**: `/conversations`
- **Method**: GET
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.limit` (optional) - Number of conversations to retrieve
  - `queryStringParameters.offset` (optional) - Pagination offset
  - `queryStringParameters.status` (optional) - Filter by conversation status
- **Returns**:
  - `200` - Conversations retrieved successfully
  - `401` - Unauthorized
  - `500` - Server error

#### adminGetConversations
**Purpose**: Retrieves conversations for a specific user (administrative function)
- **Handler**: `src/functions/private/adminGetConversations.adminGetConversationsHandler`
- **Path**: `/private/users/{userId}/conversations`
- **Method**: PUT
- **CORS**: true
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.userId` - ID of the user
  - `queryStringParameters.limit` (optional) - Number of conversations to retrieve
  - `queryStringParameters.offset` (optional) - Pagination offset
- **Returns**:
  - `200` - Conversations retrieved successfully
  - `401` - Unauthorized
  - `404` - User not found
  - `500` - Server error

#### adminCloseConversation
**Purpose**: Closes a conversation (administrative function)
- **Handler**: `src/functions/private/closeConversation.closeConversationHandler`
- **Path**: `/private/conversations/{conversationId}`
- **Method**: DELETE
- **CORS**: true
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.conversationId` - ID of the conversation to close
  - `body.reason` (optional) - Reason for closing the conversation
- **Returns**:
  - `200` - Conversation closed successfully
  - `401` - Unauthorized
  - `404` - Conversation not found
  - `500` - Server error

#### adminGetQuietChats
**Purpose**: Finds conversations with low activity (administrative function)
- **Handler**: `src/functions/private/findQuietChats.findQuietChatsHandler`
- **Path**: `/private/conversations/quietChats`
- **Method**: GET
- **Timeout**: 60 seconds
- **CORS**: true
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.daysInactive` (optional) - Number of days of inactivity
  - `queryStringParameters.limit` (optional) - Maximum number of results
- **Returns**:
  - `200` - Quiet chats retrieved successfully
  - `401` - Unauthorized
  - `500` - Server error

#### snoozeConversation
**Purpose**: Snoozes a conversation (administrative function)
- **Handler**: `src/functions/private/snoozeConversation.snoozeConversationHandler`
- **Path**: `/private/conversations/{conversationId}/snooze`
- **Method**: PUT
- **CORS**: true
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.conversationId` - ID of the conversation to snooze
  - `body.duration` (optional) - Snooze duration in hours
  - `body.reason` (optional) - Reason for snoozing
- **Returns**:
  - `200` - Conversation snoozed successfully
  - `401` - Unauthorized
  - `404` - Conversation not found
  - `500` - Server error

### Real-time Communication Functions

#### sendTypingSignal
**Purpose**: Sends typing indicator to conversation participants
- **Handler**: `src/functions/chat/sendTypingSignal.sendTypingSignalHandler`
- **Path**: `/messages/typing/{isTyping}`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.isTyping` - Boolean indicating if user is typing
  - `body.conversationId` - ID of the conversation
- **Returns**:
  - `200` - Typing signal sent successfully
  - `400` - Invalid conversation ID
  - `401` - Unauthorized
  - `404` - Conversation not found
  - `500` - Server error

### Video Call Functions

#### getVideoAccessToken
**Purpose**: Generates access token for video calls
- **Handler**: `src/functions/getVideoAccessToken.getVideoAccessTokenHandler`
- **Path**: `/video/{interactionId}/token`
- **Method**: GET
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.interactionId` - ID of the interaction/call
- **Returns**:
  - `200` - Video access token generated successfully
  - `401` - Unauthorized
  - `404` - Interaction not found
  - `500` - Server error

#### getActiveCall
**Purpose**: Retrieves active call information for a user
- **Handler**: `src/functions/calls/getActiveCall.getActiveCallHandler`
- **Path**: `/calls/active`
- **Method**: GET
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**: None (uses authenticated user context)
- **Returns**:
  - `200` - Active call information retrieved successfully
  - `401` - Unauthorized
  - `404` - No active call found
  - `500` - Server error

#### callPartner
**Purpose**: Initiates a call with a partner
- **Handler**: `src/functions/calls/callPartner.callPartnerHandler`
- **Path**: `/calls`
- **Method**: POST
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.partnerId` - ID of the partner to call
  - `body.callType` (optional) - Type of call (audio, video)
- **Returns**:
  - `201` - Call initiated successfully
  - `400` - Invalid partner ID
  - `401` - Unauthorized
  - `404` - Partner not found
  - `500` - Server error

#### acceptCall
**Purpose**: Accepts an incoming call
- **Handler**: `src/functions/calls/acceptCall.acceptCallHandler`
- **Path**: `/calls/accept`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.callId` - ID of the call to accept
- **Returns**:
  - `200` - Call accepted successfully
  - `400` - Invalid call ID
  - `401` - Unauthorized
  - `404` - Call not found
  - `500` - Server error

#### endCall
**Purpose**: Ends an active call
- **Handler**: `src/functions/calls/endCall.endCallHandler`
- **Path**: `/calls/end`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.callId` - ID of the call to end
  - `body.reason` (optional) - Reason for ending the call
- **Returns**:
  - `200` - Call ended successfully
  - `400` - Invalid call ID
  - `401` - Unauthorized
  - `404` - Call not found
  - `500` - Server error

### Encryption Key Management Functions

#### saveIdentityKey
**Purpose**: Saves user's identity key for end-to-end encryption
- **Handler**: `src/functions/keys/saveIdentityKey.saveIdentityKeyHandler`
- **Path**: `/keys/identityKey`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.identityKey` - User's identity key
  - `body.keyId` - Key identifier
- **Returns**:
  - `200` - Identity key saved successfully
  - `400` - Invalid key data
  - `401` - Unauthorized
  - `500` - Server error

#### saveSignedPreKey
**Purpose**: Saves user's signed pre-key for encryption
- **Handler**: `src/functions/keys/saveSignedPreKey.saveSignedPreKeyHandler`
- **Path**: `/keys/signedPreKey`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.signedPreKey` - User's signed pre-key
  - `body.keyId` - Key identifier
- **Returns**:
  - `200` - Signed pre-key saved successfully
  - `400` - Invalid key data
  - `401` - Unauthorized
  - `500` - Server error

#### savePreKeys
**Purpose**: Saves user's pre-keys for encryption
- **Handler**: `src/functions/keys/savePreKeys.savePreKeysHandler`
- **Path**: `/keys/preKeys`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.preKeys` - Array of pre-keys
- **Returns**:
  - `200` - Pre-keys saved successfully
  - `400` - Invalid key data
  - `401` - Unauthorized
  - `500` - Server error

#### getIdentityKey
**Purpose**: Retrieves identity key for a partner user
- **Handler**: `src/functions/keys/getIdentityKey.getIdentityKeyHandler`
- **Path**: `/keys/users/{partnerUserId}/identityKey`
- **Method**: GET
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.partnerUserId` - ID of the partner user
- **Returns**:
  - `200` - Identity key retrieved successfully
  - `401` - Unauthorized
  - `404` - Key not found
  - `500` - Server error

#### getSignedPreKey
**Purpose**: Retrieves signed pre-key for a partner user
- **Handler**: `src/functions/keys/getSignedPreKey.getSignedPreKeyHandler`
- **Path**: `/keys/users/{partnerUserId}/signedPreKey`
- **Method**: GET
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.partnerUserId` - ID of the partner user
- **Returns**:
  - `200` - Signed pre-key retrieved successfully
  - `401` - Unauthorized
  - `404` - Key not found
  - `500` - Server error

#### getPreKey
**Purpose**: Retrieves a pre-key for a partner user
- **Handler**: `src/functions/keys/getPreKey.getPreKeyHandler`
- **Path**: `/keys/users/{partnerUserId}/preKey`
- **Method**: GET
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.partnerUserId` - ID of the partner user
- **Returns**:
  - `200` - Pre-key retrieved successfully
  - `401` - Unauthorized
  - `404` - Key not found
  - `500` - Server error

## Environment Variables

The service uses the following environment variables:

- `CX_REPORTING_STRATEGY` - Coralogix reporting strategy
- `CX_DOMAIN` - Coralogix domain
- `CX_APPLICATION_NAME` - Coralogix application name
- `CX_SUBSYSTEM_NAME` - Coralogix subsystem name
- `CX_API_KEY` - Coralogix API key (from SSM)
- `WSS_API_GATEWAY_ENDPOINT` - WebSocket API Gateway endpoint

## Chat Features

### Message Types
- **Text Messages**: Standard text communication
- **Image Messages**: Photo sharing
- **File Messages**: Document sharing
- **System Messages**: Platform notifications

### Conversation States
- **Active**: Normal conversation state
- **Archived**: Conversation archived by user
- **Closed**: Conversation closed by admin
- **Snoozed**: Conversation temporarily paused

### Real-time Features
- **Typing Indicators**: Shows when users are typing
- **Read Receipts**: Confirms message delivery and reading
- **Message Reactions**: Emoji reactions to messages
- **Online Status**: User online/offline indicators

### Video Call Features
- **Audio Calls**: Voice-only communication
- **Video Calls**: Face-to-face video communication
- **Call Recording**: Optional call recording (with consent)
- **Screen Sharing**: Share screen during calls

## Security Features

- **End-to-End Encryption**: Message encryption using Signal protocol
- **Authentication Required**: All endpoints require valid JWT tokens
- **Key Management**: Secure storage and exchange of encryption keys
- **Message Validation**: Input validation for all messages
- **Rate Limiting**: Protection against spam and abuse

## Error Handling

The service implements comprehensive error handling:

- **Validation Errors**: Invalid message or conversation data
- **Authentication Errors**: Invalid or expired tokens
- **Authorization Errors**: Insufficient permissions
- **Not Found Errors**: Messages or conversations not found
- **Connection Errors**: WebSocket connection issues
- **Service Errors**: External service failures

## Integration Points

- **WebSocket API Gateway**: Real-time communication
- **Video Calling Service**: External video call provider
- **Push Notifications**: Message delivery notifications
- **Database**: Message and conversation storage
- **Encryption Service**: Key management and encryption

## Monitoring and Logging

- **Coralogix Integration**: Centralized logging
- **WebSocket Monitoring**: Connection health tracking
- **Performance Monitoring**: CloudWatch metrics
- **Error Tracking**: Failed operations logging
- **Message Analytics**: Communication pattern analysis 