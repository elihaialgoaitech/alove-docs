# Utils Service Documentation

## Service Overview

The Utils Service provides utility functions and administrative tools for the JLOV dating platform. It handles image verification, JSON deployment, settings management, translation services, version control, and various administrative operations. The service serves as a central utility hub for platform-wide functionality and maintenance tasks.

## Service Details

- **Runtime**: Node.js 22.x
- **Authentication**: AWS Cognito User Pools (for most functions)
- **Utility Functions**: Platform-wide utility operations
- **Administrative Tools**: System administration and maintenance

## Lambda Functions

### Image Management Functions

#### checkImagesVirificationHandler
**Purpose**: Verifies and validates uploaded images
- **Handler**: `src/functions/checkImagesVirification.CheckImagesVirificationHandler`
- **Path**: `/ImagesVirification`
- **Method**: POST
- **Timeout**: 15 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.imageData` - Image data to verify
  - `body.imageType` (optional) - Type of image being verified
  - `body.verificationLevel` (optional) - Level of verification required
- **Returns**:
  - `200` - Image verification completed successfully
  - `400` - Invalid image data
  - `401` - Unauthorized
  - `500` - Server error

### JSON Deployment Functions

#### deployJSON
**Purpose**: Deploys JSON configuration files
- **Handler**: `src/functions/deployJSONs.deployAllJSONHandler`
- **Path**: `/deployJSONs`
- **Method**: GET
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.environment` (optional) - Target environment for deployment
  - `queryStringParameters.force` (optional) - Force deployment even if no changes
- **Returns**:
  - `200` - JSON files deployed successfully
  - `400` - Invalid deployment parameters
  - `401` - Unauthorized
  - `500` - Server error

#### deploySettings
**Purpose**: Deploys settings JSON files for specific types and brands
- **Handler**: `src/functions/deploySettingsJSONs.deploySettingsJSONHandler`
- **Path**: `/deploySettings/{type}/{brand}/{brandID}`
- **Method**: GET
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.type` - Type of settings to deploy
  - `pathParameters.brand` - Brand identifier
  - `pathParameters.brandID` - Brand ID
- **Returns**:
  - `200` - Settings deployed successfully
  - `400` - Invalid settings parameters
  - `401` - Unauthorized
  - `404` - Settings not found
  - `500` - Server error

#### copySettingsHandler
**Purpose**: Copies settings from one configuration to another
- **Handler**: `src/functions/copySettings.copySettingsHandler`
- **Path**: `/copySettings`
- **Method**: POST
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.sourceType` - Source settings type
  - `body.sourceBrand` - Source brand identifier
  - `body.targetType` - Target settings type
  - `body.targetBrand` - Target brand identifier
- **Returns**:
  - `200` - Settings copied successfully
  - `400` - Invalid copy parameters
  - `401` - Unauthorized
  - `404` - Source settings not found
  - `500` - Server error

### Version Management Functions

#### changeMinimalVersion
**Purpose**: Updates the minimum version requirement for the platform
- **Handler**: `src/functions/changeMinimalVersion.changeMinimalVersionHandler`
- **Path**: `/versions/{type}`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `pathParameters.type` - Type of version to update (iOS, Android, etc.)
  - `body.newVersion` - New minimum version
  - `body.reason` (optional) - Reason for version change
- **Returns**:
  - `200` - Version updated successfully
  - `400` - Invalid version data
  - `401` - Unauthorized
  - `500` - Server error

### Translation Management Functions

#### getTrPositionsHandler
**Purpose**: Retrieves translation positions and configurations
- **Handler**: `src/functions/getTrPositions.getTrPositionsHandler`
- **Path**: `/translations`
- **Method**: GET
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.brandId` - Brand identifier
  - `queryStringParameters.languageId` - Language identifier
- **Returns**:
  - `200` - Translation positions retrieved successfully
  - `401` - Unauthorized
  - `404` - Translations not found
  - `500` - Server error

#### setTrPositionsHandler
**Purpose**: Sets translation positions and configurations
- **Handler**: `src/functions/setTrPositions.setTrPositionsHandler`
- **Path**: `/translations/positions`
- **Method**: PUT
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.brandId` - Brand identifier
  - `body.languageId` - Language identifier
  - `body.positions` - Translation position data
- **Returns**:
  - `200` - Translation positions set successfully
  - `400` - Invalid position data
  - `401` - Unauthorized
  - `500` - Server error

### Event Management Functions

#### addProfileEventHandler
**Purpose**: Adds profile-related events for tracking
- **Handler**: `src/functions/categoryClick.categoryClickHandler`
- **Path**: `/categoryClick`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.category` - Category being clicked
  - `body.userId` - ID of the user
  - `body.timestamp` (optional) - Event timestamp
- **Returns**:
  - `200` - Event added successfully
  - `400` - Invalid event data
  - `401` - Unauthorized
  - `500` - Server error

#### createUsageEventHandler
**Purpose**: Creates usage events for analytics
- **Handler**: `src/functions/createUsageEvent.createUsageEventHandler`
- **Path**: `/usageEvent`
- **Method**: POST
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.eventType` - Type of usage event
  - `body.userId` - ID of the user
  - `body.eventData` - Event-specific data
  - `body.timestamp` (optional) - Event timestamp
- **Returns**:
  - `200` - Usage event created successfully
  - `400` - Invalid event data
  - `401` - Unauthorized
  - `500` - Server error

### Administrative Functions

#### copyQuestionnaireHandler
**Purpose**: Copies questionnaire configurations
- **Handler**: `src/functions/copyQuestionnaire.copyQuestionnaireHandler`
- **Path**: `/copyQuestionnaire`
- **Method**: POST
- **Timeout**: 60 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.sourceQuestionnaireId` - Source questionnaire ID
  - `body.targetQuestionnaireId` - Target questionnaire ID
  - `body.copyOptions` (optional) - Copy configuration options
- **Returns**:
  - `200` - Questionnaire copied successfully
  - `400` - Invalid copy parameters
  - `401` - Unauthorized
  - `404` - Source questionnaire not found
  - `500` - Server error

#### flushLogs
**Purpose**: Flushes and processes log data
- **Handler**: `src/functions/flushLogs.flushLogsLambadaHandler`
- **Path**: `/flushLogs`
- **Method**: POST
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.logLevel` (optional) - Log level to flush
  - `body.force` (optional) - Force flush all logs
- **Returns**:
  - `200` - Logs flushed successfully
  - `400` - Invalid flush parameters
  - `401` - Unauthorized
  - `500` - Server error

## Environment Variables

The service uses the following environment variables:

- `CX_REPORTING_STRATEGY` - Coralogix reporting strategy
- `CX_DOMAIN` - Coralogix domain
- `CX_APPLICATION_NAME` - Coralogix application name
- `CX_SUBSYSTEM_NAME` - Coralogix subsystem name
- `CX_API_KEY` - Coralogix API key (from SSM)
- `WSS_API_GATEWAY_ENDPOINT` - WebSocket API Gateway endpoint

## Utility Features

### Image Processing
- **Image Verification**: Content validation and safety checks
- **Format Validation**: Supported format verification
- **Size Optimization**: Image size and quality optimization
- **Metadata Processing**: Image metadata extraction and validation

### Configuration Management
- **JSON Deployment**: Automated configuration deployment
- **Settings Management**: Centralized settings administration
- **Version Control**: Platform version management
- **Environment Management**: Multi-environment configuration

### Translation Services
- **Multi-language Support**: Multiple language configurations
- **Position Management**: Translation element positioning
- **Brand Customization**: Brand-specific translation settings
- **Language Detection**: Automatic language detection

### Event Tracking
- **Usage Analytics**: User behavior tracking
- **Performance Monitoring**: System performance events
- **Error Tracking**: Error and exception logging
- **Audit Logging**: Administrative action logging

## Security Features

- **Authentication Required**: Most endpoints require valid JWT tokens
- **Role-Based Access**: Different permissions for different utility functions
- **Data Validation**: Input validation for all utility operations
- **Audit Logging**: All administrative actions are logged
- **Rate Limiting**: Protection against abuse of utility services

## Error Handling

The service implements comprehensive error handling:

- **Validation Errors**: Invalid input data or parameters
- **Authentication Errors**: Invalid or expired tokens
- **Authorization Errors**: Insufficient permissions for operations
- **File System Errors**: File operation failures
- **Configuration Errors**: Invalid configuration data
- **Service Errors**: External service failures

## Integration Points

- **S3**: File storage for configurations and images
- **CloudWatch**: Logging and monitoring
- **Translation Services**: External translation providers
- **Image Processing Services**: External image verification services
- **Database**: Configuration and event data storage
- **Notification Service**: Administrative notifications

## Monitoring and Logging

- **Coralogix Integration**: Centralized logging
- **Performance Monitoring**: Utility function performance tracking
- **Error Tracking**: Failed utility operations logging
- **Usage Analytics**: Utility service usage patterns
- **System Health**: Overall system health monitoring

## Administrative Operations

### Daily Operations
- **Log Management**: Daily log processing and cleanup
- **Configuration Checks**: Daily configuration validation
- **System Health Monitoring**: Daily system health checks

### Weekly Operations
- **Configuration Backups**: Weekly configuration backups
- **Performance Review**: Weekly performance analysis
- **Error Analysis**: Weekly error pattern analysis

### Monthly Operations
- **System Maintenance**: Monthly system maintenance tasks
- **Configuration Optimization**: Monthly configuration optimization
- **Security Review**: Monthly security and access review

## Deployment and Configuration

### Configuration Types
- **Application Settings**: Core application configurations
- **Brand Settings**: Brand-specific configurations
- **Feature Flags**: Feature enablement/disablement
- **Environment Settings**: Environment-specific configurations

### Deployment Strategies
- **Blue-Green Deployment**: Zero-downtime configuration updates
- **Rolling Updates**: Gradual configuration updates
- **Emergency Rollbacks**: Quick configuration rollback capabilities
- **Validation**: Pre-deployment configuration validation 