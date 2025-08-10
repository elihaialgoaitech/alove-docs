# Payments Service Documentation

## Service Overview

The Payments Service handles all payment processing, token management, and financial transactions for the JLOV dating platform. It manages payment methods, processes transactions, handles in-app purchases, manages token balances, and provides payment-related administrative functions. The service integrates with various payment providers and supports multiple payment methods.

## Service Details

- **Runtime**: Node.js 22.x
- **Authentication**: AWS Cognito User Pools
- **Payment Providers**: Stripe, Google Play, Apple App Store
- **Database**: Payment and transaction database

## Lambda Functions

### Payment Settings and Configuration Functions

#### settings
**Purpose**: Retrieves payment settings and configuration
- **Handler**: `src/functions/paymentSettings.getPaymentsSettingsHandler`
- **Path**: `/settings`
- **Method**: GET
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.brandId` - Brand identifier for settings
- **Returns**:
  - `200` - Payment settings retrieved successfully
  - `401` - Unauthorized
  - `500` - Server error

### Token Management Functions

#### useTokens
**Purpose**: Uses tokens for platform features
- **Handler**: `src/functions/useTokens.useTokensHandler`
- **Path**: `/tokensLogs`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.userId` - ID of the user using tokens
  - `body.tokenAmount` - Number of tokens to use
  - `body.feature` - Feature or service using the tokens
  - `body.description` (optional) - Description of token usage
- **Returns**:
  - `200` - Tokens used successfully
  - `400` - Insufficient tokens or invalid request
  - `401` - Unauthorized
  - `500` - Server error

#### adminUseTokens
**Purpose**: Administratively uses tokens for a user (private function)
- **Handler**: `src/functions/useTokens.useTokensHandler`
- **Path**: `/private/tokensLogs`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.userId` - ID of the user
  - `body.tokenAmount` - Number of tokens to use
  - `body.feature` - Feature or service using the tokens
  - `body.adminId` - ID of the administrator
  - `body.reason` (optional) - Reason for administrative token usage
- **Returns**:
  - `200` - Tokens used successfully
  - `400` - Insufficient tokens or invalid request
  - `401` - Unauthorized
  - `500` - Server error

#### tokensHistory
**Purpose**: Retrieves token usage history for a user
- **Handler**: `src/functions/getTokensHistory.getTokensHistoryHandler`
- **Path**: `/tokensLogs`
- **Method**: GET
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.userId` (optional) - User ID (uses authenticated user if not provided)
  - `queryStringParameters.limit` (optional) - Number of records to retrieve
  - `queryStringParameters.offset` (optional) - Pagination offset
  - `queryStringParameters.dateFrom` (optional) - Start date for filtering
  - `queryStringParameters.dateTo` (optional) - End date for filtering
- **Returns**:
  - `200` - Token history retrieved successfully
  - `401` - Unauthorized
  - `500` - Server error

### Payment Method Management Functions

#### cards
**Purpose**: Retrieves saved payment methods for a user
- **Handler**: `src/functions/getCards.getCardsHandler`
- **Path**: `/cards`
- **Method**: GET
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**: None (uses authenticated user context)
- **Returns**:
  - `200` - Payment methods retrieved successfully
  - `401` - Unauthorized
  - `500` - Server error

### Payment Processing Functions

#### getPaymentIntent
**Purpose**: Creates a payment intent for processing payments
- **Handler**: `src/functions/getPaymentIntent.getPaymentIntentHandler`
- **Path**: `/paymentIntent`
- **Method**: GET
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `queryStringParameters.cardId` (optional) - ID of the payment method to use
  - `queryStringParameters.paymentMethod` - Type of payment method
  - `queryStringParameters.planId` - ID of the subscription plan
  - `queryStringParameters.tokensPackageLevel` - Token package level
- **Returns**:
  - `200` - Payment intent created successfully
  - `400` - Invalid payment parameters
  - `401` - Unauthorized
  - `500` - Server error

#### confirmPayment
**Purpose**: Confirms and processes a payment
- **Handler**: `src/functions/confirmPayment.confirmPaymentHandler`
- **Path**: `/confirmPayment`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.paymentIntentId` - ID of the payment intent to confirm
  - `body.paymentMethodId` (optional) - ID of the payment method
  - `body.confirmationData` (optional) - Additional confirmation data
- **Returns**:
  - `200` - Payment confirmed successfully
  - `400` - Payment confirmation failed
  - `401` - Unauthorized
  - `500` - Server error

### In-App Purchase Functions

#### inAppPurchase
**Purpose**: Processes in-app purchases
- **Handler**: `src/functions/inAppPurchase.inAppPurchaseHandler`
- **Path**: `/inAppPurchase`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.purchaseData` - Purchase transaction data
  - `body.platform` - Platform (iOS, Android)
  - `body.productId` - Product identifier
  - `body.transactionId` - Transaction identifier
- **Returns**:
  - `200` - Purchase processed successfully
  - `400` - Invalid purchase data
  - `401` - Unauthorized
  - `409` - Duplicate transaction
  - `500` - Server error

#### googleConfirmationHandler
**Purpose**: Handles Google Play purchase confirmations
- **Handler**: `src/functions/inAppPurchase.googleConfirmationHandler`
- **Path**: `/googleConfirmation`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.purchaseToken` - Google Play purchase token
  - `body.productId` - Product identifier
  - `body.purchaseTime` - Purchase timestamp
  - `body.orderId` - Google Play order ID
- **Returns**:
  - `200` - Google purchase confirmed successfully
  - `400` - Invalid confirmation data
  - `401` - Unauthorized
  - `500` - Server error

#### publishProducts
**Purpose**: Publishes product information (private function)
- **Handler**: `src/functions/publishProducts.publishProductsHandler`
- **Path**: `/publishProducts`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Private**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.products` - Array of product information to publish
  - `body.platform` - Target platform (iOS, Android)
- **Returns**:
  - `200` - Products published successfully
  - `400` - Invalid product data
  - `401` - Unauthorized
  - `500` - Server error

### Special Payment Functions

#### betaPayHandler
**Purpose**: Handles beta testing payment scenarios
- **Handler**: `src/functions/betaPay.betaPayHandler`
- **Path**: `/betaPay`
- **Method**: POST
- **Timeout**: 20 seconds
- **CORS**: true
- **Authentication**: Required (Cognito User Pools)
- **Parameters**:
  - `body.betaTestData` - Beta testing payment data
  - `body.testScenario` - Test scenario identifier
  - `body.userId` - User ID for beta testing
- **Returns**:
  - `200` - Beta payment processed successfully
  - `400` - Invalid beta test data
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

## Payment Features

### Payment Methods
- **Credit/Debit Cards**: Visa, MasterCard, American Express
- **Digital Wallets**: Apple Pay, Google Pay
- **In-App Purchases**: iOS App Store, Google Play Store
- **Bank Transfers**: ACH, SEPA (where applicable)

### Token System
- **Token Types**: Platform tokens for premium features
- **Token Packages**: Various token amounts and pricing tiers
- **Token Usage**: Features, services, and premium content
- **Token Expiration**: Time-limited token validity

### Subscription Plans
- **Monthly Plans**: Recurring monthly subscriptions
- **Annual Plans**: Discounted annual subscriptions
- **Premium Plans**: Enhanced features and benefits
- **Trial Periods**: Free trial subscriptions

### Payment Processing
- **Secure Processing**: PCI DSS compliant payment processing
- **Fraud Protection**: Advanced fraud detection and prevention
- **Refund Handling**: Automated and manual refund processing
- **Dispute Resolution**: Chargeback and dispute management

## Security Features

- **PCI Compliance**: Payment Card Industry Data Security Standard compliance
- **Tokenization**: Secure storage of payment method information
- **Encryption**: End-to-end encryption of payment data
- **Authentication Required**: All endpoints require valid JWT tokens
- **Audit Logging**: Comprehensive payment transaction logging

## Error Handling

The service implements comprehensive error handling:

- **Validation Errors**: Invalid payment data or parameters
- **Authentication Errors**: Invalid or expired tokens
- **Payment Errors**: Declined payments, insufficient funds
- **Fraud Detection**: Suspicious transaction patterns
- **Service Errors**: External payment provider failures
- **Network Errors**: Connectivity issues with payment providers

## Integration Points

- **Stripe**: Primary payment processor
- **Google Play**: Android in-app purchases
- **Apple App Store**: iOS in-app purchases
- **User Service**: User account and billing information
- **Notification Service**: Payment confirmation notifications
- **Analytics Service**: Payment analytics and reporting

## Monitoring and Logging

- **Coralogix Integration**: Centralized logging
- **Payment Analytics**: Transaction success rate tracking
- **Fraud Monitoring**: Suspicious activity detection
- **Performance Monitoring**: Payment processing performance
- **Error Tracking**: Failed payment attempts logging

## Compliance and Regulations

### Financial Compliance
- **PCI DSS**: Payment Card Industry Data Security Standard
- **GDPR**: General Data Protection Regulation compliance
- **Local Regulations**: Country-specific payment regulations
- **Tax Compliance**: Automated tax calculation and reporting

### Security Standards
- **Encryption**: AES-256 encryption for sensitive data
- **Tokenization**: Secure token storage and management
- **Access Controls**: Role-based access to payment data
- **Audit Trails**: Complete audit trail for all transactions

## Scheduled Operations

### Daily Operations
- **Transaction Reconciliation**: Reconcile daily transactions
- **Fraud Monitoring**: Daily fraud detection analysis
- **Failed Payment Retry**: Retry failed payment attempts

### Weekly Operations
- **Payment Analytics**: Weekly payment performance analysis
- **Refund Processing**: Process pending refunds
- **Subscription Renewals**: Process recurring subscriptions

### Monthly Operations
- **Financial Reporting**: Monthly financial reports
- **Compliance Audits**: Monthly compliance checks
- **Performance Review**: Payment system performance analysis 