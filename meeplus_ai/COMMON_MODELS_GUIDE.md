# Common Models Layer Integration Guide

This guide explains how to use the `common-models` layer in your `agent-service`.

## Overview

The `common-models` layer provides shared data models that can be used across different services in the MeePlus AI application. This ensures consistency, type safety, and validation across your entire system.

## How It Works

The common-models are included directly in the Lambda deployment package as source code, making them available at runtime without requiring installation as a separate package.

## Setup

### 1. Dependencies

The common-models layer requires Pydantic, which is included in the requirements.txt:

```bash
# From the agent-service directory
pip install -r requirements.txt
```
## Usage Examples

### Basic Import (Lambda Environment)

```python
# In Lambda, import directly from the included source code
from meeplus_common_models.models import Profile, Question, Brand, BaseModel
```

### Data Validation

```python
from meeplus_common_models.models import Profile

# This will validate the data and raise an error if invalid
try:
    profile = Profile(
        id="user-123",
        name="John Doe",
        description="A test profile"
    )
    print(f"Valid profile: {profile.name}")
except Exception as e:
    print(f"Invalid profile data: {e}")
```

### API Request Validation

```python
def validate_request(event):
    """Validate incoming API requests using common models."""
    try:
        body = json.loads(event["body"])
        
        # Validate required fields
        if "profile_id" not in body:
            raise ValueError("profile_id is required")
        
        # You can add more validation here
        return body
    except Exception as e:
        raise ValueError(f"Request validation failed: {e}")
```

### Response Serialization

```python
from meeplus_common_models.models import Profile

def get_profile_response(profile_data):
    """Convert raw data to validated Profile model."""
    try:
        profile = Profile(**profile_data)
        return {
            'statusCode': 200,
            'body': json.dumps(profile.model_dump())
        }
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': f'Invalid profile data: {e}'})
        }
```

## Available Models

The following models are available from the common-models layer:

- **Profile**: User profile data
- **Question**: Question/quiz data
- **QuestionList**: List of questions
- **QuestionCategory**: Question categories
- **Brand**: Brand information
- **Attribute**: Generic attributes
- **Translation**: Multi-language support
- **Introduction**: User introductions
- **ProfileExternalInfo**: External profile data
- **SuggestedProfile**: Suggested profiles
- **BioPrefRelation**: Bio and preference relationships
- **BatchContent**: Batch processing content
- **Execution**: Execution tracking
- **BaseModel**: Base model class

## Benefits

### 1. Type Safety
All models use Pydantic for automatic validation and type checking.

### 2. Consistency
Shared models ensure data consistency across services.

### 3. Validation
Automatic validation of incoming and outgoing data.

### 4. Serialization
Easy conversion to/from JSON for API responses.

### 5. IDE Support
Full type hints for better development experience.

## Testing


# Test in your functions
python -c "
from meeplus_common_models.models import Profile
profile = Profile(id='test', name='Test', description='Test')
print('✅ Model works!')
"
```

### CI/CD Testing
The GitHub Actions workflow automatically:
1. Installs Python dependencies
2. Verifies common-models are available
3. Deploys with the layer included

## Troubleshooting

### Import Errors
If you get import errors in Lambda:
1. Check that the common-models source is included in `serverless.yml`
2. Verify the import path: `from meeplus_common_models.models import ...`
3. Check CloudWatch logs for detailed error messages

### Validation Errors
If you get validation errors, check:
1. Required fields are present
2. Data types match the model definition
3. Field constraints are satisfied

### Deployment Issues
If deployment fails:
1. Check that the layer is properly included in `serverless.yml`
2. Verify pydantic is in requirements.txt
3. Check CloudWatch logs for detailed error messages

## Best Practices

1. **Always validate incoming data** using the common models
2. **Use type hints** for better code clarity
3. **Handle validation errors gracefully** with proper error responses
4. **Test with real data** to ensure models work as expected
5. **Keep models up to date** when requirements change

## Migration from Raw Data

If you're currently using raw dictionaries, you can gradually migrate:

```python
# Before (raw data)
profile_data = {"id": "123", "name": "John"}

# After (with validation)
from meeplus_common_models.models import Profile
profile = Profile(**profile_data)
validated_data = profile.model_dump()
```

This ensures your data is always valid and consistent across your application.

## Local Development

For local development, you can install the common-models as a package:

```bash
# From the agent-service directory
pip install -e ../common-models
```

This allows you to import using:
```python
from common_models import Profile, Question, Brand
```

But in Lambda, use the direct import:
```python
from meeplus_common_models.models import Profile, Question, Brand
``` 