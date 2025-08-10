# Auth Service Documentation

## Service Overview

The Auth Service handles user authentication and authorization for the JLOV dating platform. It provides secure user registration, login, and session management using AWS Cognito User Pools. The service also includes additional authentication features like SMS/email verification codes and custom authentication flows.

## Service Details

- **Runtime**: Node.js 22.x
- **Authentication**: AWS Cognito User Pools
- **External Integrations**: Twilio (SMS), Email services
- **Database**: AWS Cognito User Pool

## Lambda Functions

### Core Authentication Functions

#### createChallenge
**Purpose**: Creates authentication challenges for custom authentication flows
- **Handler**: `src/functions/boilerplate-create-challenge.handler`
- **Trigger**: Cognito Pre-Authentication
- **Parameters**: 
  - `event.request.userAttributes` - User attributes from Cognito
  - `event.request.session` - Current session data
- **Returns**: Challenge response for custom authentication flow

#### defineChallenge
**Purpose**: Defines the structure and parameters of authentication challenges
- **Handler**: `src/functions/boilerplate-define-challenge.handler`
- **Trigger**: Cognito Define Auth Challenge
- **Parameters**:
  - `event.request.session` - Session information
  - `event.request.challengeName` - Name of the challenge
- **Returns**: Challenge definition with next steps

#### verify
**Purpose**: Verifies user responses to authentication challenges
- **Handler**: `src/functions/boilerplate-verify.handler`
- **Trigger**: Cognito Verify Auth Challenge
- **Parameters**:
  - `event.request.challengeAnswer` - User's response to challenge
  - `event.request.privateChallengeParameters` - Private challenge data
- **Returns**: Verification result (success/failure)

### Post-Authentication Functions

#### postAuthentication
**Purpose**: Handles actions after successful user authentication
- **Handler**: `src/functions/post-authentication.handler`
- **Trigger**: Cognito Post Authentication
- **Parameters**:
  - `event.request.userAttributes` - Authenticated user attributes
  - `event.request.newDeviceUsed` - Whether new device was used
- **Returns**: Modified user attributes or claims

#### postConfirmation
**Purpose**: Handles actions after user account confirmation
- **Handler**: `src/functions/post-confirmation.handler`
- **Trigger**: Cognito Post Confirmation
- **Parameters**:
  - `event.request.userAttributes` - Confirmed user attributes
- **Returns**: Success/failure status

### Pre-Authentication Functions

#### preSignup
**Purpose**: Validates and processes user registration before account creation
- **Handler**: `src/functions/pre-signup.handler`
- **Trigger**: Cognito Pre Sign-up
- **Parameters**:
  - `event.request.userAttributes` - User registration data
  - `event.request.validationData` - Additional validation data
- **Returns**: Allow/deny registration decision

#### preTokenGeneration
**Purpose**: Customizes JWT tokens with additional claims before generation
- **Handler**: `src/functions/pre-token-generation.handler`
- **Trigger**: Cognito Pre Token Generation
- **Parameters**:
  - `event.request.userAttributes` - User attributes
  - `event.request.groupConfiguration` - Group membership
- **Returns**: Custom claims to include in tokens

### Additional Authentication Functions

#### sendCode
**Purpose**: Sends verification codes via SMS or email for additional authentication
- **Handler**: `src/functions/additionalAuth-SendCode.SendAuthCodeHandler`
- **Path**: `/sendCode`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.phoneNumber` (optional) - Phone number for SMS code
  - `body.email` (optional) - Email address for email code
  - `body.brandId` (optional) - Brand identifier for customization
- **Returns**:
  - `200` - Code sent successfully
  - `400` - Invalid parameters
  - `500` - Service error

#### verifyCode
**Purpose**: Verifies the authentication codes sent via SMS or email
- **Handler**: `src/functions/additionalAuth-VerifyCode.VerifyAuthCodeHandler`
- **Path**: `/verifyCode`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.code` - Verification code to validate
  - `body.phoneNumber` (optional) - Phone number if SMS code
  - `body.email` (optional) - Email if email code
- **Returns**:
  - `200` - Code verified successfully
  - `400` - Invalid or expired code
  - `500` - Service error

## Environment Variables

The service uses the following environment variables:

- `SMS_SIGNATURE` - SMS signature for Twilio messages
- `EMAIL_TEMPLATE_URL` - URL for email templates
- `TRANSLATIONS_URL` - URL for translation services
- `ACCOUNT_SID` - Twilio account SID
- `AUTH_TOKEN` - Twilio auth token (from SSM)
- `AWS_REAL_REGION` - AWS region for services
- `ASSETS_BUCKET` - S3 bucket for assets
- `ACCOUNT_DB_HOST` - Database host
- `ACCOUNT_DB_USER` - Database username
- `ACCOUNT_DB_PASSWORD` - Database password (from SSM)
- `ALOVE_API_BASE_URL` - External API base URL
- `ALOVE_API_KEY` - External API key (from SSM)

## Authentication Flow

1. **Registration**: User signs up through Cognito
2. **Confirmation**: User confirms account via email/SMS
3. **Login**: User authenticates with username/password
4. **Additional Verification**: Optional SMS/email code verification
5. **Token Generation**: JWT tokens generated with custom claims
6. **Session Management**: Tokens used for API access

## Security Features

- **Multi-factor Authentication**: SMS and email verification codes
- **Custom Claims**: JWT tokens include user-specific claims
- **Device Tracking**: New device detection and handling
- **Rate Limiting**: Protection against brute force attacks
- **Secure Storage**: Sensitive data stored in AWS Systems Manager

## Error Handling

The service implements comprehensive error handling:

- **Validation Errors**: Invalid input parameters
- **Authentication Errors**: Failed login attempts
- **Service Errors**: External service failures
- **Rate Limiting**: Too many requests
- **Network Errors**: Connectivity issues

## Integration Points

- **AWS Cognito**: Primary authentication provider
- **Twilio**: SMS verification service
- **Email Service**: Email verification service
- **Database**: User account storage
- **External APIs**: Additional authentication services

## Monitoring and Logging

- **Coralogix Integration**: Centralized logging
- **CloudWatch Metrics**: Performance monitoring
- **Error Tracking**: Failed authentication attempts
- **Audit Logs**: Security event logging 