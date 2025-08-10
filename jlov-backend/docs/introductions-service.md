# Introductions Service Documentation

## Service Overview

The Introductions Service manages the core matchmaking functionality of the JLOV dating platform. It handles user introductions, match suggestions, profile matching algorithms, introduction lifecycle management, and administrative operations. The service is responsible for creating meaningful connections between users based on compatibility algorithms and user preferences.

## Service Details

- **Runtime**: Node.js 22.x
- **Authentication**: AWS Cognito User Pools
- **Matchmaking Algorithms**: Compatibility scoring and filtering
- **Database**: Introductions and matches database

## Lambda Functions

### Match Discovery Functions

#### findMatches
**Purpose**: Finds potential matches for a user based on compatibility criteria
- **Handler**: `src/functions/findMatches.findMatchesHandler`
- **Path**: `/matches`
- **Method**: GET
- **Timeout**: 30 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.limit` (optional) - Number of matches to retrieve
  - `queryStringParameters.offset` (optional) - Pagination offset
  - `queryStringParameters.filters` (optional) - Additional filtering criteria
- **Returns**:
  - `200` - Matches found successfully
  - `401` - Unauthorized
  - `500` - Server error

#### makeRawSuggestions
**Purpose**: Generates raw match suggestions for users
- **Handler**: `src/functions/makeRawSuggestions.makeRawSuggestionsHandler`
- **Path**: `/suggestions`
- **Method**: POST
- **Timeout**: 30 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.userId` - ID of the user to generate suggestions for
  - `body.preferences` (optional) - User preferences for matching
  - `body.limit` (optional) - Number of suggestions to generate
- **Returns**:
  - `201` - Suggestions generated successfully
  - `400` - Invalid user data
  - `401` - Unauthorized
  - `500` - Server error

#### findIncomingSuggestions
**Purpose**: Retrieves incoming match suggestions for a user
- **Handler**: `src/functions/findIncomingSuggestions.findIncomingSuggestionsHandler`
- **Path**: `/suggestions/incoming/{suggestionType}`
- **Method**: GET
- **Timeout**: 30 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.suggestionType` - Type of suggestions to retrieve
  - `queryStringParameters.limit` (optional) - Number of suggestions to retrieve
  - `queryStringParameters.offset` (optional) - Pagination offset
- **Returns**:
  - `200` - Incoming suggestions retrieved successfully
  - `401` - Unauthorized
  - `404` - No suggestions found
  - `500` - Server error

#### findHistInSuggs
**Purpose**: Retrieves historical incoming suggestions for a user
- **Handler**: `src/functions/findHistoryIncomingSuggestions.findHistoryIncomingSuggestionsHandler`
- **Path**: `/suggestions/incoming/history`
- **Method**: GET
- **Timeout**: 15 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.limit` (optional) - Number of historical suggestions to retrieve
  - `queryStringParameters.offset` (optional) - Pagination offset
- **Returns**:
  - `200` - Historical suggestions retrieved successfully
  - `401` - Unauthorized
  - `500` - Server error

### Introduction Management Functions

#### replySuggestion
**Purpose**: Responds to a match suggestion (accept, decline, etc.)
- **Handler**: `src/functions/replySuggestion.replySuggestionHandler`
- **Path**: `/{interactionId}/reactions/{reaction}`
- **Method**: PUT
- **Timeout**: 30 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.interactionId` - ID of the interaction/suggestion
  - `pathParameters.reaction` - User's reaction (accept, decline, maybe)
- **Returns**:
  - `200` - Reaction recorded successfully
  - `400` - Invalid reaction
  - `401` - Unauthorized
  - `404` - Interaction not found
  - `500` - Server error

#### inspectSuggestion
**Purpose**: Inspects and analyzes a match suggestion
- **Handler**: `src/functions/inspectSuggestion.inspectSuggestionHandler`
- **Path**: `/{interactionId}/inspections/{type}`
- **Method**: POST
- **Timeout**: 30 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.interactionId` - ID of the interaction to inspect
  - `pathParameters.type` - Type of inspection to perform
  - `queryStringParameters.silent` (optional) - Whether to perform silent inspection
- **Returns**:
  - `200` - Inspection completed successfully
  - `400` - Invalid inspection type
  - `401` - Unauthorized
  - `404` - Interaction not found
  - `500` - Server error

#### extendsIntroduction
**Purpose**: Extends the duration of an introduction
- **Handler**: `src/functions/extendIntroduction.extendIntroducthionHandler`
- **Path**: `/introductions/{introductionId}/extends`
- **Method**: PUT
- **Timeout**: 30 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.introductionId` - ID of the introduction to extend
  - `body.extensionDays` (optional) - Number of days to extend by
- **Returns**:
  - `200` - Introduction extended successfully
  - `400` - Invalid extension period
  - `401` - Unauthorized
  - `404` - Introduction not found
  - `500` - Server error

### Termination and Reporting Functions

#### partyTerminateMatch
**Purpose**: Terminates a match by one of the parties
- **Handler**: `src/functions/partyTerminateMatch.partyTerminateMatchHandler`
- **Path**: `/{interactionId}/terminations`
- **Method**: PUT
- **Timeout**: 30 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.interactionId` - ID of the interaction to terminate
  - `body.reason` (optional) - Reason for termination
- **Returns**:
  - `200` - Match terminated successfully
  - `400` - Invalid termination request
  - `401` - Unauthorized
  - `404` - Interaction not found
  - `500` - Server error

#### setTerminationReason
**Purpose**: Sets the reason for terminating a match
- **Handler**: `src/functions/setTerminationReason.setTerminationReasonHandler`
- **Path**: `/{interactionId}/terminations/reasons`
- **Method**: PUT
- **Timeout**: 30 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.interactionId` - ID of the interaction
  - `body.reason` - Reason for termination
  - `body.details` (optional) - Additional details about the reason
- **Returns**:
  - `200` - Termination reason set successfully
  - `400` - Invalid reason
  - `401` - Unauthorized
  - `404` - Interaction not found
  - `500` - Server error

#### reportOnParty
**Purpose**: Reports inappropriate behavior by a user
- **Handler**: `src/functions/reportOnParty.reportOnPartyHandler`
- **Path**: `/{interactionId}/report`
- **Method**: POST
- **Timeout**: 30 seconds
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.interactionId` - ID of the interaction
  - `body.reportedUserId` - ID of the user being reported
  - `body.reason` - Reason for the report
  - `body.evidence` (optional) - Supporting evidence
- **Returns**:
  - `200` - Report submitted successfully
  - `400` - Invalid report data
  - `401` - Unauthorized
  - `404` - Interaction not found
  - `500` - Server error

### Administrative Functions

#### adminTerminateMatchHandler
**Purpose**: Administratively terminates a match
- **Handler**: `src/functions/partyTerminateMatch.adminTerminateMatchHandler`
- **Path**: `/private/introductions/{interactionId}/terminations`
- **Method**: PUT
- **Timeout**: 30 seconds
- **CORS**: true
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.interactionId` - ID of the interaction to terminate
  - `body.reason` - Administrative reason for termination
  - `body.adminId` - ID of the administrator
- **Returns**:
  - `200` - Match terminated successfully
  - `400` - Invalid termination request
  - `401` - Unauthorized
  - `404` - Interaction not found
  - `500` - Server error

#### adminFindHandler
**Purpose**: Finds introductions based on administrative criteria
- **Handler**: `src/functions/private/adminFindIntroductions.adminFindIntroductionsHandler`
- **Path**: `/private/introductions`
- **Method**: GET
- **Timeout**: 30 seconds
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.userId` (optional) - Filter by user ID
  - `queryStringParameters.status` (optional) - Filter by introduction status
  - `queryStringParameters.dateFrom` (optional) - Filter by start date
  - `queryStringParameters.dateTo` (optional) - Filter by end date
  - `queryStringParameters.limit` (optional) - Number of results to return
- **Returns**:
  - `200` - Introductions found successfully
  - `401` - Unauthorized
  - `500` - Server error

#### updateStatusIntroHandler
**Purpose**: Updates the status of an introduction
- **Handler**: `src/functions/private/updateStatusIntro.updateStatusIntroHandler`
- **Path**: `/private/introductions/{interactionId}/status`
- **Method**: PUT
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.interactionId` - ID of the interaction
  - `body.newStatus` - New status for the introduction
  - `body.reason` (optional) - Reason for status change
- **Returns**:
  - `200` - Status updated successfully
  - `400` - Invalid status
  - `401` - Unauthorized
  - `404` - Interaction not found
  - `500` - Server error

#### calculatePAHandler
**Purpose**: Calculates profile availability for a user
- **Handler**: `src/functions/calculateProfileAvaiablity.calculateProfileAvaiablityHandler`
- **Path**: `/private/profiles/{profileId}/availability`
- **Method**: POST
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.profileId` - ID of the profile to calculate availability for
- **Returns**:
  - `200` - Availability calculated successfully
  - `400` - Invalid profile ID
  - `401` - Unauthorized
  - `404` - Profile not found
  - `500` - Server error

### Scheduled Functions

#### termiIgnoredSuggestSchedule
**Purpose**: Scheduled function to terminate ignored suggestions
- **Handler**: `src/cron/terminateIgnoredSuggestions.terminateIgnoredSuggestionsScheduleHandler`
- **Timeout**: 60 seconds
- **Trigger**: CloudWatch Events (scheduled)
- **Parameters**:
  - `event.time` - Current execution time
- **Returns**: Number of ignored suggestions terminated

#### quietChatSchedule
**Purpose**: Scheduled function to handle quiet chat conversations
- **Handler**: `src/cron/quietChat.quietChatScheduleHandler`
- **Timeout**: 60 seconds
- **Trigger**: CloudWatch Events (scheduled)
- **Parameters**:
  - `event.time` - Current execution time
- **Returns**: Number of quiet chats processed

#### tryCreateIntroductions
**Purpose**: Scheduled function to attempt creating new introductions
- **Handler**: `src/cron/tryCreateIntroductions.tryCreateIntroductionsHandler`
- **Timeout**: 60 seconds
- **Trigger**: CloudWatch Events (scheduled)
- **Parameters**:
  - `event.time` - Current execution time
- **Returns**: Number of introductions created

#### systemShutDownOnOff
**Purpose**: Controls system shutdown mode
- **Handler**: `src/cron/systemShutDownOnOff.systemShutDownOnOff`
- **Trigger**: CloudWatch Events (scheduled)
- **Parameters**:
  - `event.time` - Current execution time
- **Returns**: System shutdown status

## Environment Variables

The service uses the following environment variables:

- `CX_REPORTING_STRATEGY` - Coralogix reporting strategy
- `CX_DOMAIN` - Coralogix domain
- `CX_APPLICATION_NAME` - Coralogix application name
- `CX_SUBSYSTEM_NAME` - Coralogix subsystem name
- `CX_API_KEY` - Coralogix API key (from SSM)
- `WSS_API_GATEWAY_ENDPOINT` - WebSocket API Gateway endpoint

## Introduction Features

### Suggestion Types
- **Regular Suggestions**: Standard match suggestions
- **Premium Suggestions**: Enhanced suggestions for premium users
- **Compatibility Suggestions**: Suggestions based on deep compatibility analysis
- **Location-Based Suggestions**: Suggestions based on geographic proximity

### Introduction States
- **Pending**: Suggestion sent, waiting for response
- **Accepted**: Both parties accepted the introduction
- **Declined**: One or both parties declined
- **Expired**: Introduction expired without response
- **Terminated**: Introduction was terminated
- **Extended**: Introduction duration was extended

### Matchmaking Criteria
- **Compatibility Score**: Algorithm-based compatibility rating
- **Location**: Geographic proximity
- **Age Range**: Age compatibility preferences
- **Interests**: Shared interests and hobbies
- **Values**: Core values alignment
- **Communication Style**: Preferred communication methods

## Security Features

- **Authentication Required**: All endpoints require valid JWT tokens
- **Privacy Protection**: User data is anonymized in suggestions
- **Rate Limiting**: Protection against abuse of suggestion system
- **Content Moderation**: Reporting system for inappropriate behavior
- **Audit Logging**: All introduction activities are logged

## Error Handling

The service implements comprehensive error handling:

- **Validation Errors**: Invalid suggestion or introduction data
- **Authentication Errors**: Invalid or expired tokens
- **Authorization Errors**: Insufficient permissions
- **Not Found Errors**: Suggestions or introductions not found
- **Conflict Errors**: Conflicting introduction states
- **Service Errors**: External service failures

## Integration Points

- **Profile Service**: User profile data for matching
- **Chat Service**: Communication after successful introductions
- **Notification Service**: User notifications for suggestions
- **Analytics Service**: Matchmaking algorithm optimization
- **Database**: Introduction and match data storage

## Monitoring and Logging

- **Coralogix Integration**: Centralized logging
- **Matchmaking Analytics**: Success rate tracking
- **Performance Monitoring**: CloudWatch metrics
- **Error Tracking**: Failed operations logging
- **User Behavior Analysis**: Introduction pattern analysis

## Scheduled Operations

### Daily Operations
- **Suggestion Generation**: Create new match suggestions
- **Expiration Cleanup**: Handle expired suggestions
- **Quiet Chat Processing**: Manage inactive conversations

### Weekly Operations
- **Compatibility Recalculation**: Update compatibility scores
- **User Activity Analysis**: Analyze user engagement patterns
- **System Health Checks**: Monitor system performance

### Monthly Operations
- **Algorithm Optimization**: Improve matching algorithms
- **Data Cleanup**: Remove old inactive data
- **Performance Review**: Analyze system performance metrics 