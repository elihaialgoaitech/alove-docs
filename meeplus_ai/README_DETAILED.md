# Common Models - Detailed Documentation

## Overview

The Common Models layer provides a comprehensive set of data models that ensure consistency, type safety, and validation across all MeePlus AI services. Built with Pydantic, these models serve as the foundation for data exchange between services and provide robust validation and serialization capabilities.

## Architecture

```
common-models/
├── src/
│   └── meeplus_common_models/
│       └── models/
│           ├── BaseModel.py          # Base model with common functionality
│           ├── Profile.py            # User profile data
│           ├── Brand.py              # Brand/community information
│           ├── Question.py           # Question/quiz data
│           ├── QuestionList.py       # Question collections
│           ├── QuestionCategory.py   # Question categorization
│           ├── Attribute.py          # Generic attributes
│           ├── Translation.py        # Multi-language support
│           ├── Introduction.py       # User introductions
│           ├── ProfileExternal.py    # External profile data
│           ├── SuggestedProfile.py   # Suggested matches
│           ├── BioPrefRelation.py    # Bio/preference relationships
│           ├── BatchContent.py       # Batch processing
│           └── Execution.py          # Execution tracking
```

## Model Details

### 1. BaseModel

**Purpose**: Foundation class providing common functionality for all models.

**Key Features**:
- Database connection management
- Environment variable loading
- Common validation methods
- Serialization utilities

**Usage**:
```python
from meeplus_common_models.models import BaseModel

class CustomModel(BaseModel):
    name: str
    description: str
```

### 2. Profile

**Purpose**: Represents user profile data with comprehensive relationship and preference information.

**Key Fields**:
- `profile_id`: Unique identifier
- `name`: User's display name
- `age`: User's age
- `location`: Geographic location
- `bio`: Personal description
- `preferences`: Relationship preferences
- `attributes_values`: Custom attributes
- `brand_id`: Associated brand/community
- `available_intro_num`: Available introductions

**Usage**:
```python
from meeplus_common_models.models import Profile

profile = Profile(
    profile_id="user-123",
    name="John Doe",
    age=30,
    location="New York, NY",
    bio="Love hiking and coffee",
    brand_id=1,
    available_intro_num=5
)

# Validate and serialize
validated_profile = Profile(**profile_data)
json_data = validated_profile.model_dump()
```

### 3. Brand

**Purpose**: Represents brand/community information and configuration.

**Key Fields**:
- `brand_id`: Unique brand identifier
- `name`: Brand name
- `description`: Brand description
- `settings`: Brand-specific configuration
- `question_sets`: Associated question collections

**Usage**:
```python
from meeplus_common_models.models import Brand

brand = Brand(
    brand_id=1,
    name="MeePlus",
    description="Jewish dating community",
    settings={"matching_algorithm": "advanced"}
)
```

### 4. Question

**Purpose**: Represents individual questions used in compatibility assessments.

**Key Fields**:
- `question_id`: Unique question identifier
- `text`: Question text
- `category_id`: Question category
- `weight`: Importance weight for scoring
- `options`: Available answer options
- `translations`: Multi-language support

**Usage**:
```python
from meeplus_common_models.models import Question

question = Question(
    question_id=1,
    text="What's your ideal weekend activity?",
    category_id=1,
    weight=0.8,
    options=["Outdoor adventure", "Cultural events", "Relaxation"]
)
```

### 5. QuestionList

**Purpose**: Manages collections of questions for different assessment types.

**Key Features**:
- Question grouping and organization
- Brand-specific question sets
- Dynamic question loading
- Caching for performance

**Usage**:
```python
from meeplus_common_models.models import QuestionList

question_list = QuestionList()
question_list.set_questions(brand_id=1)
questions = question_list.get_questions_by_category("personality")
```

### 6. QuestionCategory

**Purpose**: Categorizes questions for better organization and scoring.

**Key Fields**:
- `category_id`: Unique category identifier
- `name`: Category name
- `description`: Category description
- `weight`: Category importance weight
- `parent_category_id`: Hierarchical organization

**Usage**:
```python
from meeplus_common_models.models import QuestionCategory

category = QuestionCategory(
    category_id=1,
    name="Personality",
    description="Personality-related questions",
    weight=0.6
)
```

### 7. Attribute

**Purpose**: Generic attribute system for flexible data storage.

**Key Fields**:
- `attribute_id`: Unique attribute identifier
- `name`: Attribute name
- `value`: Attribute value
- `type`: Data type (string, number, boolean, etc.)
- `entity_type`: Associated entity type
- `entity_id`: Associated entity identifier

**Usage**:
```python
from meeplus_common_models.models import Attribute

attribute = Attribute(
    attribute_id=1,
    name="religion",
    value="Jewish",
    type="string",
    entity_type="profile",
    entity_id="user-123"
)
```

### 8. Translation

**Purpose**: Provides multi-language support for application content.

**Key Fields**:
- `translation_id`: Unique translation identifier
- `key`: Translation key
- `language_code`: Language identifier
- `text`: Translated text
- `context`: Translation context

**Usage**:
```python
from meeplus_common_models.models import Translation

translation = Translation(
    translation_id=1,
    key="welcome_message",
    language_code="en",
    text="Welcome to MeePlus!",
    context="homepage"
)
```

### 9. Introduction

**Purpose**: Manages user introductions and connection requests.

**Key Fields**:
- `introduction_id`: Unique introduction identifier
- `from_profile_id`: Initiating user
- `to_profile_id`: Target user
- `status`: Introduction status (pending, accepted, declined)
- `created_at`: Creation timestamp
- `message`: Optional introduction message

**Usage**:
```python
from meeplus_common_models.models import Introduction

introduction = Introduction(
    introduction_id="intro-123",
    from_profile_id="user-1",
    to_profile_id="user-2",
    status="pending",
    message="Hi, I'd love to connect!"
)
```

### 10. ProfileExternalInfo

**Purpose**: Stores external profile data and metadata.

**Key Fields**:
- `profile_id`: Associated profile
- `key`: Data key
- `value`: Data value
- `source`: Data source
- `updated_at`: Last update timestamp

**Usage**:
```python
from meeplus_common_models.models import ProfileExternalInfo

external_info = ProfileExternalInfo(
    profile_id="user-123",
    key="attachment_result",
    value="secure",
    source="personality_assessment"
)
```

### 11. SuggestedProfile

**Purpose**: Represents suggested matches with compatibility scores.

**Key Fields**:
- `id`: Suggestion identifier
- `partner_profile_id`: Suggested partner
- `matching_score_to_user_pref`: Compatibility score
- `matching_score_to_partner_pref`: Mutual compatibility
- `suggestion_reasons`: Why this match was suggested

**Usage**:
```python
from meeplus_common_models.models import SuggestedProfile

suggestion = SuggestedProfile(
    id="suggestion-123",
    partner_profile_id="partner-456",
    matching_score_to_user_pref=85.5,
    matching_score_to_partner_pref=78.2,
    suggestion_reasons=["shared interests", "compatible values"]
)
```

### 12. BioPrefRelation

**Purpose**: Manages relationships between bio preferences and compatibility.

**Key Fields**:
- `relation_id`: Unique relation identifier
- `question_id`: Associated question
- `brand_id`: Brand context
- `compatibility_rules`: Matching rules
- `weight`: Importance weight

**Usage**:
```python
from meeplus_common_models.models import BioPrefRelation

relation = BioPrefRelation(
    relation_id=1,
    question_id=5,
    brand_id=1,
    compatibility_rules={"exact_match": 1.0, "partial_match": 0.5},
    weight=0.8
)
```

### 13. BatchContent

**Purpose**: Handles batch processing operations and data.

**Key Fields**:
- `batch_id`: Unique batch identifier
- `content_type`: Type of content being processed
- `data`: Batch data
- `status`: Processing status
- `created_at`: Creation timestamp

**Usage**:
```python
from meeplus_common_models.models import BatchContent

batch = BatchContent(
    batch_id="batch-123",
    content_type="profile_import",
    data={"profiles": [...]},
    status="pending"
)
```

### 14. Execution

**Purpose**: Tracks execution of operations and processes.

**Key Fields**:
- `execution_id`: Unique execution identifier
- `operation_type`: Type of operation
- `status`: Execution status
- `start_time`: Start timestamp
- `end_time`: End timestamp
- `metadata`: Additional execution data

**Usage**:
```python
from meeplus_common_models.models import Execution

execution = Execution(
    execution_id="exec-123",
    operation_type="matching_algorithm",
    status="running",
    start_time=datetime.now(),
    metadata={"profiles_processed": 1000}
)
```

## Validation and Serialization

### Pydantic Validation

All models use Pydantic for automatic validation:

```python
from meeplus_common_models.models import Profile

# This will raise a validation error if data is invalid
try:
    profile = Profile(
        profile_id="user-123",
        name="John",  # Valid
        age="invalid_age"  # Will raise validation error
    )
except ValidationError as e:
    print(f"Validation error: {e}")
```

### Serialization

Easy conversion to/from JSON:

```python
# Model to JSON
profile_dict = profile.model_dump()
profile_json = profile.model_dump_json()

# JSON to Model
profile = Profile.model_validate_json(json_string)
```

## Database Integration

### Peewee ORM Integration

Models integrate with Peewee ORM for database operations:

```python
from meeplus_common_models.models import Profile

# Create new profile
profile = Profile.create(
    profile_id="user-123",
    name="John Doe",
    age=30
)

# Query profiles
profiles = Profile.select().where(Profile.age > 25)

# Update profile
profile.name = "John Smith"
profile.save()
```

## Best Practices

### 1. Model Usage

```python
# Always validate incoming data
def process_profile_data(data):
    try:
        profile = Profile.model_validate(data)
        return profile
    except ValidationError as e:
        raise ValueError(f"Invalid profile data: {e}")

# Use type hints for better code clarity
def get_profile_by_id(profile_id: str) -> Profile:
    return Profile.get(Profile.profile_id == profile_id)
```

### 2. Error Handling

```python
# Graceful error handling
def safe_model_creation(data, model_class):
    try:
        return model_class.model_validate(data)
    except ValidationError as e:
        logger.error(f"Validation failed for {model_class.__name__}: {e}")
        return None
```

### 3. Performance Optimization

```python
# Use model_dump() for serialization
def api_response(profile: Profile):
    return {
        'statusCode': 200,
        'body': json.dumps(profile.model_dump())
    }

# Batch operations for better performance
def create_multiple_profiles(profiles_data):
    profiles = [Profile.model_validate(data) for data in profiles_data]
    Profile.bulk_create(profiles)
```

## Testing

### Model Testing

```python
import pytest
from meeplus_common_models.models import Profile

def test_profile_validation():
    # Valid profile
    profile = Profile(
        profile_id="test-123",
        name="Test User",
        age=25
    )
    assert profile.name == "Test User"
    
    # Invalid profile
    with pytest.raises(ValidationError):
        Profile(profile_id="test-123", age="invalid")

def test_profile_serialization():
    profile = Profile(
        profile_id="test-123",
        name="Test User",
        age=25
    )
    
    # Test serialization
    data = profile.model_dump()
    assert data['name'] == "Test User"
    
    # Test deserialization
    new_profile = Profile.model_validate(data)
    assert new_profile.name == "Test User"
```

## Migration and Versioning

### Model Evolution

When updating models:

1. **Add new fields as optional** to maintain backward compatibility
2. **Use field aliases** for renamed fields
3. **Provide migration scripts** for database schema updates
4. **Version your models** for API compatibility

### Example Migration

```python
# Old model
class Profile(BaseModel):
    user_id: str
    name: str

# New model with backward compatibility
class Profile(BaseModel):
    profile_id: str = Field(alias="user_id")  # Alias for backward compatibility
    name: str
    age: Optional[int] = None  # New optional field
```

## Integration Examples

### Service Integration

```python
# In matching-service
from meeplus_common_models.models import Profile, SuggestedProfile

def get_suggestions(profile_id: str) -> List[SuggestedProfile]:
    profile = Profile.get(Profile.profile_id == profile_id)
    # ... matching logic ...
    return suggestions

# In agent-service
from meeplus_common_models.models import Profile, Introduction

def get_user_context(profile_id: str):
    profile = Profile.get(Profile.profile_id == profile_id)
    introductions = Introduction.select().where(
        Introduction.from_profile_id == profile_id
    )
    return {"profile": profile, "introductions": introductions}
```

This comprehensive model system ensures data consistency, type safety, and maintainability across the entire MeePlus AI platform. 