# Agent Service

## Overview

The Agent Service is an AI-powered conversational agent that provides personalized relationship advice, conversation insights, and interactive assistance to users of the MeePlus AI platform. Built on OpenAI's GPT models with LangChain integration, it offers intelligent, context-aware responses tailored to each user's profile and relationship history.

## Purpose

The service acts as a personal relationship coach and assistant, providing:
- **Personalized Advice**: Tailored relationship guidance based on user profiles
- **Conversation Analysis**: Insights into communication patterns and preferences
- **Introduction Management**: Help with managing introductions and connections
- **Partner Discovery**: Assistance in finding and understanding potential matches
- **Relationship Insights**: Analysis of relationship patterns and compatibility

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   API Gateway   │───▶│  Lambda Function │───▶│   OpenAI API    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌──────────────────┐
                       │   LangChain      │
                       │   Agent Engine   │
                       └──────────────────┘
                              │
                              ▼
                       ┌──────────────────┐
                       │   PostgreSQL     │
                       │   (User Data)    │
                       └──────────────────┘
```

## Key Components

### 1. AI Inference Engine (`inference.py`)
- **Function**: `inference_handler()`
- **Purpose**: Main handler for conversational AI requests
- **Features**:
  - LangChain ReAct agent integration
  - Multi-tool orchestration
  - Context-aware responses
  - Conversation history management

### 2. Tool Integration
The agent uses several specialized tools to provide comprehensive assistance:

#### Profile Data Tool (`_get_profile_data`)
- **Purpose**: Retrieves detailed user profile information
- **Data**: Hobbies, interests, preferences, background
- **Usage**: Provides context for personalized responses

#### Introduction Management Tool (`_list_introductions`)
- **Purpose**: Lists all people the user has interacted with
- **Data**: Introduction history, interaction status
- **Usage**: Helps with relationship management advice

#### Partner Search Tool (`_get_partner_by_name`)
- **Purpose**: Searches for specific partners by name
- **Data**: Partner profile information, compatibility scores
- **Usage**: Enables targeted advice about specific relationships

### 3. Prompt Management (`prompts/`)
- **System Prompts**: Predefined conversation templates
- **Context Templates**: User-specific context injection
- **Response Formatting**: Structured response guidelines

### 4. Utility Functions (`utils/`)
- **Profile Utils**: Profile data retrieval and processing
- **Introduction Utils**: Introduction management functions
- **User Utils**: User information retrieval
- **Insights Utils**: Conversation analysis and insights generation

## AI Capabilities

### Conversational Intelligence
- **Context Awareness**: Maintains conversation context across interactions
- **Personalization**: Tailors responses based on user profile and history
- **Natural Language**: Human-like conversation flow
- **Multi-turn Dialogue**: Handles complex, multi-step conversations

### Relationship Coaching
- **Dating Advice**: Practical tips for dating and relationships
- **Communication Guidance**: Help with conversation skills
- **Compatibility Analysis**: Insights into relationship dynamics
- **Personal Growth**: Suggestions for self-improvement

### Data-Driven Insights
- **Pattern Recognition**: Identifies relationship patterns
- **Compatibility Analysis**: Analyzes match compatibility
- **Communication Analysis**: Evaluates conversation effectiveness
- **Trend Analysis**: Tracks relationship progress over time

## API Endpoints

### POST /inference

Processes conversational AI requests and returns personalized responses.

**Request**:
```json
{
  "profile_id": "user-profile-id",
  "messages": [
    {
      "role": "user",
      "content": "Hello, can you help me with dating advice?"
    }
  ],
  "model": "openai:gpt-4.1-nano"
}
```

**Response**:
```json
{
  "message": "Hello! I'd be happy to help you with dating advice. Based on your profile, I can see you're interested in...",
  "insights": {
    "conversation_style": "friendly",
    "topics_of_interest": ["dating", "relationships"],
    "communication_preferences": "direct",
    "relationship_goals": "long-term"
  }
}
```

**Parameters**:
- `profile_id` (required): The user's profile ID
- `messages` (required): Array of conversation messages
- `model` (optional): AI model to use (default: "openai:gpt-4.1-nano")

## AI Model Integration

### OpenAI GPT Models
- **Primary Model**: GPT-4.1-nano for fast, cost-effective responses
- **Fallback Models**: Support for other GPT variants
- **Model Selection**: Configurable per request

### LangChain Integration
- **ReAct Agent**: Uses reasoning and action framework
- **Tool Orchestration**: Seamless integration of multiple tools
- **Memory Management**: Maintains conversation context
- **Response Formatting**: Structured output generation

### LangGraph Features
- **Workflow Management**: Complex conversation flows
- **State Management**: Persistent conversation state
- **Error Handling**: Graceful error recovery
- **Performance Optimization**: Efficient resource usage

## Data Integration

### Profile Data Access
- **User Preferences**: Hobbies, interests, relationship goals
- **Demographic Information**: Age, location, background
- **Behavioral Data**: Interaction patterns, preferences
- **Compatibility Scores**: Matching algorithm results

### Introduction History
- **Past Connections**: History of introductions and interactions
- **Success Patterns**: Analysis of successful relationships
- **Communication Styles**: Preferred interaction methods
- **Relationship Outcomes**: Long-term relationship tracking

### Conversation Insights
- **Communication Analysis**: Style and effectiveness assessment
- **Topic Preferences**: Frequently discussed subjects
- **Emotional Patterns**: Sentiment and emotional trends
- **Engagement Metrics**: User interaction and satisfaction

## Configuration

### Environment Variables
```bash
# AI Configuration
OPENAI_API_KEY=your-openai-api-key
ALOVE_API_KEY=your-alove-api-key
ALOVE_API_BASE_URL=https://api.alove.com

# Database Configuration
ACCOUNT_DB_HOST=your-db-host
ACCOUNT_DB_NAME=your-db-name
ACCOUNT_DB_USER=your-db-user
ACCOUNT_DB_PASSWORD=your-db-password
ACCOUNT_DB_PORT=5432

# Monitoring
DatadogApiKey=your-datadog-api-key
```

### Model Configuration
- **Default Model**: Configurable default AI model
- **Model Fallbacks**: Automatic fallback to alternative models
- **Performance Tuning**: Model-specific optimization settings

## Monitoring and Analytics

### Datadog Integration
- **Performance Monitoring**: Response time and throughput tracking
- **Error Tracking**: AI model errors and failures
- **Usage Analytics**: Conversation patterns and user engagement
- **Custom Metrics**: Business-specific KPIs

### Key Metrics
- **Response Latency**: AI response generation time
- **User Satisfaction**: Conversation quality metrics
- **Tool Usage**: Frequency of different tool usage
- **Model Performance**: AI model effectiveness and accuracy

## Development

### Local Development
```bash
# Install dependencies
pip install -r requirements.txt

# Set up environment variables
cp .env.example .env
# Edit .env with your configuration

# Test the service
python test_partner_tool.py
```

### Testing
```bash
# Run partner tool test
python test_partner_tool.py

# Test specific components
python -c "
from src.utils.profile_utils import get_profile_data
print('Profile utils working!')
"
```

### Prompt Development
- **System Prompts**: Edit `prompts/prompt-v1.txt` for conversation style
- **Context Templates**: Modify context injection logic
- **Response Formatting**: Update response structure guidelines

## Deployment

### Serverless Deployment
```bash
# Deploy to dev environment
serverless deploy --stage dev

# Deploy to production
serverless deploy --stage prod
```

### Infrastructure
- **Runtime**: Python 3.9
- **Memory**: 1024MB (configurable)
- **Timeout**: 30 seconds
- **Concurrency**: Auto-scaling based on demand

## Security and Privacy

### Data Protection
- **User Privacy**: Secure handling of personal information
- **API Security**: Protected endpoints with authentication
- **Data Encryption**: Encrypted data transmission and storage
- **Access Control**: Role-based access to sensitive data

### AI Safety
- **Content Filtering**: Safe and appropriate responses
- **Bias Mitigation**: Fair and unbiased advice
- **Ethical Guidelines**: Adherence to ethical AI principles
- **User Consent**: Transparent data usage policies

## Performance Optimization

### Response Optimization
- **Caching**: Intelligent caching of frequently accessed data
- **Async Processing**: Non-blocking operations for better performance
- **Resource Management**: Efficient memory and CPU usage
- **Connection Pooling**: Optimized database connections

### AI Model Optimization
- **Prompt Engineering**: Optimized prompts for better responses
- **Context Management**: Efficient context handling
- **Tool Selection**: Smart tool usage for optimal results
- **Response Formatting**: Streamlined output generation

## Troubleshooting

### Common Issues

1. **AI Model Errors**
   - Check OpenAI API key and quota
   - Verify model availability
   - Review prompt formatting

2. **Database Connection Issues**
   - Verify database credentials
   - Check network connectivity
   - Ensure proper permissions

3. **Tool Integration Problems**
   - Validate tool function signatures
   - Check data format compatibility
   - Review error handling

### Debugging
- Enable detailed logging in Datadog
- Check CloudWatch logs for errors
- Monitor API Gateway metrics
- Review AI model response quality

## Future Enhancements

### Planned Features
- **Multi-modal Support**: Image and voice interaction capabilities
- **Advanced Analytics**: Deeper conversation and relationship insights
- **Personalization Engine**: Enhanced user-specific customization
- **Integration Expansion**: Additional third-party service integrations

### AI Improvements
- **Fine-tuned Models**: Custom models for relationship coaching
- **Emotional Intelligence**: Enhanced emotional understanding
- **Predictive Analytics**: Relationship outcome predictions
- **Learning Capabilities**: Continuous improvement from interactions

### Scalability Enhancements
- **Microservice Architecture**: Further service decomposition
- **Event-driven Processing**: Asynchronous event handling
- **Global Deployment**: Multi-region deployment for better performance
- **Advanced Caching**: Redis and CDN integration 