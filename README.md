# Alove Documentation Repository

This repository contains comprehensive documentation for the Alove dating and matchmaking platform ecosystem. It serves as a central hub for understanding the architecture, services, and components that power the platform.

## 🏗️ Platform Architecture Overview

The Alove platform is built as a modern, scalable microservices architecture supporting multiple brands and configurations. The system consists of several interconnected services and applications:

```
┌─────────────────────────────────────────────────────────────┐
│                    Frontend Applications                    │
│  ┌─────────────┐ ┌─────────────┐                          │
│  │  MeePlus    │ │ Backoffice  │                          │
│  │    App      │ │   Client    │                          │
│  │ (Flutter)   │ │  (React)    │                          │
│  └─────────────┘ └─────────────┘                          │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                    Backend Services                        │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐          │
│  │   JLOV      │ │ Backoffice  │ │  MeePlus    │          │
│  │ Backend     │ │  Backend    │ │     AI      │          │
│  └─────────────┘ └─────────────┘ └─────────────┘          │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                    Infrastructure                          │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐          │
│  │     AWS     │ │  Firebase   │ │   Serverless│          │
│  │  Services   │ │  Services   │ │   Framework │          │
│  └─────────────┘ └─────────────┘ └─────────────┘          │
└─────────────────────────────────────────────────────────────┘
```

## 📁 Repository Structure

### 🎯 Frontend Applications

#### [`meeplus_app/`](./meeplus_app/) - End User Mobile Application
**Purpose**: Cross-platform mobile application for end users (dating app users)

**Key Features**:
- **Multi-brand Support**: Single codebase supporting multiple dating app brands (Mujual, Alove, Zuug)
- **Advanced Matchmaking**: AI-powered introduction and matching system
- **Real-time Communication**: Chat, audio, and video calling capabilities
- **Profile Management**: Comprehensive user profile and preference settings
- **Questionnaire System**: Dynamic onboarding and compatibility assessment
- **Payment Integration**: Premium features and subscription management

**Technology Stack**:
- **Framework**: Flutter 3.29.3+ with Dart 3.7.2+
- **State Management**: GetX for reactive programming
- **Navigation**: Go Router for declarative routing
- **Cloud Services**: AWS Amplify, Firebase
- **Platforms**: iOS, Android, Web

**Documentation**: [`PROJECT_DOCUMENTATION.md`](./meeplus_app/PROJECT_DOCUMENTATION.md)

#### [`backoffice_client/`](./backoffice_client/) - Administrative Dashboard
**Purpose**: React-based administrative dashboard for platform administrators and staff

**Key Features**:
- **User Management**: Manage end users, system users, roles, and permissions
- **Content Management**: Handle app content, translations, communications
- **Questionnaire System**: Manage questionnaires, questions, and user responses
- **Matchmaking Operations**: Handle shidduch requests and SME profiles
- **Customer Support**: Ticket management system
- **Reporting & Analytics**: Comprehensive business intelligence
- **Brand Management**: Multi-brand support with brand-specific settings

**Technology Stack**:
- **Framework**: React 18.1.0 with TypeScript
- **UI Library**: Material-UI (MUI) v7.1.1
- **State Management**: React Context API
- **Routing**: React Router DOM 6.3.0
- **Forms**: Formik 2.2.9 with Yup validation

**Documentation**: [`index.md`](./backoffice_client/index.md)

### 🔧 Backend Services

#### [`jlov-backend/`](./jlov-backend/) - Core Platform Services
**Purpose**: Microservices backend handling core platform functionality

**Services Included**:
- **Auth Service**: User authentication and authorization using AWS Cognito
- **User Service**: User profile and account management
- **Profile Service**: Detailed user profile and preference management
- **Chat Service**: Real-time messaging and communication
- **Matchmakers Service**: Human matchmaker operations and workflows
- **Introductions Service**: User introduction and connection management
- **Payments Service**: Payment processing and subscription management
- **LoRA Service**: AI model fine-tuning and customization
- **Utils Service**: Shared utilities and helper functions

**Technology Stack**:
- **Runtime**: Node.js 22.x
- **Framework**: Serverless Framework
- **Authentication**: AWS Cognito User Pools
- **Database**: PostgreSQL with TypeORM
- **External Services**: Twilio, BigQuery, OpenAI

**Documentation**: [`docs/`](./jlov-backend/docs/) directory with individual service documentation

#### [`backoffice_backend/`](./backoffice_backend/) - Administrative API
**Purpose**: Multi-tenant NestJS application for administrative operations

**Key Features**:
- **Multi-tenant Architecture**: Supports 4 brands with isolated data
- **Role-based Access Control**: Granular permissions system
- **Multi-language Support**: Content translation management
- **Real-time Monitoring**: Session tracking and activity monitoring
- **External Integrations**: AWS services, Twilio, BigQuery, OpenAI

**Technology Stack**:
- **Framework**: NestJS (Node.js)
- **Database**: PostgreSQL with TypeORM
- **Authentication**: JWT with refresh tokens
- **File Storage**: AWS S3
- **External Services**: Twilio, BigQuery, OpenAI

**Documentation**:
- [`README.md`](./backoffice_backend/README.md) - Overview and quick start
- [`API_DOCUMENTATION.md`](./backoffice_backend/API_DOCUMENTATION.md) - Complete API reference
- [`API_QUICK_REFERENCE.md`](./backoffice_backend/API_QUICK_REFERENCE.md) - Quick reference guide
- [`groups-api.md`](./backoffice_backend/groups-api.md) - Groups API documentation

#### [`meeplus_ai/`](./meeplus_ai/) - AI-Powered Services
**Purpose**: AI and machine learning services for intelligent matchmaking and conversation

**Services Included**:
- **Matching Service**: Core matching engine with compatibility scoring
  - Profile matching and compatibility analysis
  - Bio preferences scoring
  - Personality predictor calculations
  - Geographic matching using haversine distance
  - Introduction management

- **Agent Service**: AI conversational agent for relationship guidance
  - OpenAI GPT-powered conversations
  - Personalized relationship advice
  - Introduction insights and analysis
  - Partner search capabilities
  - Conversation pattern analysis

- **Common Models**: Shared data models and validation
  - Pydantic-based model validation
  - Type safety with full type hints
  - Reusable across all services

**Technology Stack**:
- **Runtime**: Python 3.9
- **Framework**: Serverless Framework
- **AI/ML**: OpenAI GPT, LangChain, LangGraph
- **Database**: PostgreSQL (via Peewee ORM)
- **Monitoring**: Coralogix, Datadog

**Documentation**:
- [`README.md`](./meeplus_ai/README.md) - Overview and architecture
- [`README_DETAILED.md`](./meeplus_ai/README_DETAILED.md) - Detailed documentation
- [`matching-service.md`](./meeplus_ai/matching-service.md) - Matching service details
- [`agent-service.md`](./meeplus_ai/agent-service.md) - Agent service details
- [`COMMON_MODELS_GUIDE.md`](./meeplus_ai/COMMON_MODELS_GUIDE.md) - Common models guide

## 🚀 Getting Started

### For Developers
1. **Mobile App Development**: Start with [`meeplus_app/PROJECT_DOCUMENTATION.md`](./meeplus_app/PROJECT_DOCUMENTATION.md)
2. **Backend Development**: Review [`jlov-backend/docs/`](./jlov-backend/docs/) for service-specific documentation
3. **Admin Dashboard**: Check [`backoffice_client/index.md`](./backoffice_client/index.md) for frontend development
4. **AI Services**: Begin with [`meeplus_ai/README.md`](./meeplus_ai/README.md) for AI/ML development

### For System Administrators
1. **Backend Operations**: Review [`backoffice_backend/README.md`](./backoffice_backend/README.md)
2. **API Reference**: Use [`backoffice_backend/API_QUICK_REFERENCE.md`](./backoffice_backend/API_QUICK_REFERENCE.md)
3. **Service Architecture**: Check [`meeplus_ai/README_DETAILED.md`](./meeplus_ai/README_DETAILED.md)

### For Business Stakeholders
1. **Platform Overview**: Review this README and service descriptions
2. **API Documentation**: Check [`backoffice_backend/API_DOCUMENTATION.md`](./backoffice_backend/API_DOCUMENTATION.md)
3. **Feature Documentation**: Explore individual service documentation for specific features

## 🔗 Service Dependencies

```
Mobile App (meeplus_app)
├── JLOV Backend (jlov-backend)
│   ├── Auth Service
│   ├── User Service
│   ├── Profile Service
│   ├── Chat Service
│   └── Other Services...
├── MeePlus AI (meeplus_ai)
│   ├── Matching Service
│   └── Agent Service
└── Backoffice Backend (backoffice_backend)

Admin Dashboard (backoffice_client)
└── Backoffice Backend (backoffice_backend)
```

## 🛠️ Technology Stack Summary

### Frontend Technologies
- **Flutter/Dart**: Cross-platform mobile development
- **React/TypeScript**: Web-based admin dashboard
- **Material-UI**: Design system and components

### Backend Technologies
- **Node.js**: Primary runtime environment
- **Python**: AI/ML services
- **NestJS**: Administrative API framework
- **Serverless Framework**: Cloud deployment

### Cloud & Infrastructure
- **AWS**: Primary cloud provider
  - Lambda, Cognito, S3, RDS, CloudFront
- **Firebase**: Mobile services
  - Push notifications, analytics, crash reporting
- **PostgreSQL**: Primary database
- **Redis**: Caching and session management

### External Integrations
- **Twilio**: SMS and communication services
- **OpenAI**: AI and language model services
- **BigQuery**: Data analytics and reporting
- **Coralogix**: Logging and monitoring

## 📊 Platform Capabilities

### Core Features
- **Multi-brand Support**: Single codebase serving multiple dating app brands
- **AI-Powered Matchmaking**: Intelligent compatibility scoring and suggestions
- **Real-time Communication**: Chat, audio, and video calling
- **Comprehensive Admin Tools**: Full administrative dashboard
- **Payment Processing**: Subscription and premium feature management
- **Analytics & Reporting**: Business intelligence and user insights

### Security & Compliance
- **Multi-tenant Architecture**: Data isolation between brands
- **Role-based Access Control**: Granular permissions system
- **JWT Authentication**: Secure token-based authentication
- **AWS Cognito**: Managed user authentication
- **Data Encryption**: End-to-end encryption for sensitive data

## 🤝 Contributing

When contributing to this documentation:

1. **Update Service Documentation**: When making changes to services, update the corresponding documentation
2. **Maintain Consistency**: Follow the established documentation structure and format
3. **Include Examples**: Provide code examples and use cases where appropriate
4. **Version Control**: Keep documentation in sync with code changes

## 📞 Support

For technical support or questions about the platform:

- **Development Issues**: Check individual service documentation
- **Architecture Questions**: Review this README and service overviews
- **API Questions**: Refer to the detailed API documentation in each service

---

**Last Updated**: December 2024  
**Platform Version**: 2.0.1  
**Documentation Version**: 1.0.0 