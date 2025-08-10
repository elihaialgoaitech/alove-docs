# Example Usage of LLM Task Generator Prompt

## Sample Requirement
"Add a new feature that allows users to block other users and prevents blocked users from seeing each other in matches, chat, or any other interactions."

## How the LLM Would Use the Prompt

### Step 1: Analyze the Requirement
The LLM would first analyze this requirement to understand:
- **Scope**: User blocking functionality across the entire platform
- **Impact**: Affects matching, chat, profile visibility, and user interactions
- **Dependencies**: Requires changes to multiple services and frontend applications

### Step 2: Read Relevant Documentation
The LLM would read documentation from:
- `jlov-backend/docs/user-service.md` - to understand user management
- `jlov-backend/docs/profile-service.md` - to understand profile visibility
- `jlov-backend/docs/chat-service.md` - to understand chat functionality
- `jlov-backend/docs/matchmakers-service.md` - to understand matching logic
- `meeplus_ai/matching-service.md` - to understand AI matching algorithms
- `meeplus_app/PROJECT_DOCUMENTATION.md` - to understand mobile app structure
- `backoffice_client/index.md` - to understand admin dashboard capabilities

### Step 3: Generate Task Breakdown

Based on the prompt guidelines, the LLM would generate:

```markdown
# Task Breakdown for: User Blocking Feature

## Overview
Implement a comprehensive user blocking system that prevents blocked users from interacting with each other across all platform features including matching, chat, profile visibility, and administrative functions.

## Affected Repositories
- jlov-backend (multiple services)
- meeplus_ai (matching service)
- meeplus_app (mobile app)
- backoffice_client (admin dashboard)
- backoffice_backend (admin API)

## Repository Tasks

## Repository: jlov-backend

### Task: Implement User Blocking in User Service

**Context**: Add blocking functionality to the core user service to manage user block relationships and provide blocking status to other services.

**Technical Requirements**:
- Create new database table `user_blocks` with fields: blocker_id, blocked_id, created_at, reason (optional)
- Add API endpoints: POST /users/{userId}/block, DELETE /users/{userId}/block, GET /users/{userId}/blocks
- Implement blocking validation in user service
- Add blocking status to user profile responses
- Ensure blocking is bidirectional (if A blocks B, B cannot see A either)

**Acceptance Criteria**:
- [ ] Blocking relationship is properly stored in database
- [ ] API endpoints return appropriate HTTP status codes and responses
- [ ] Blocking validation prevents blocked users from interacting
- [ ] Blocking status is included in user profile responses
- [ ] Database indexes are created for efficient blocking queries
- [ ] API documentation is updated

**Implementation Notes**:
- Consider soft deletion for block records to maintain audit trail
- Implement proper error handling for invalid user IDs
- Ensure blocking works across all brands in multi-tenant setup
- Add appropriate logging for security monitoring

**Testing Requirements**:
- Unit tests for blocking logic
- Integration tests for API endpoints
- Performance tests for blocking queries
- Security tests to ensure proper authorization

**Estimated Complexity**: Medium
**Dependencies**: None (core service)

---

### Task: Update Profile Service for Blocking Visibility

**Context**: Modify profile service to respect blocking relationships when returning user profiles and preferences.

**Technical Requirements**:
- Integrate with user service to check blocking status
- Filter out blocked users from profile visibility
- Update profile matching queries to exclude blocked users
- Add blocking status to profile API responses
- Implement caching for blocking status to improve performance

**Acceptance Criteria**:
- [ ] Blocked users are not visible in profile searches
- [ ] Profile API responses include blocking status
- [ ] Performance impact is minimal (<100ms additional latency)
- [ ] Caching reduces database load for blocking checks
- [ ] Blocking works correctly in multi-brand environment

**Implementation Notes**:
- Use Redis caching for blocking status to improve performance
- Implement proper cache invalidation when blocking status changes
- Consider batch operations for multiple blocking checks

**Testing Requirements**:
- Unit tests for blocking visibility logic
- Performance tests with large user datasets
- Integration tests with user service
- Cache invalidation tests

**Estimated Complexity**: Medium
**Dependencies**: jlov-backend/user-service

---

### Task: Update Chat Service for Blocking Restrictions

**Context**: Prevent blocked users from sending messages or seeing chat history with each other.

**Technical Requirements**:
- Add blocking validation to message sending endpoints
- Filter chat history to exclude messages from blocked users
- Update real-time chat events to respect blocking
- Add blocking status to chat participant lists
- Implement proper error messages for blocked interactions

**Acceptance Criteria**:
- [ ] Blocked users cannot send messages to each other
- [ ] Chat history excludes messages from blocked users
- [ ] Real-time events respect blocking relationships
- [ ] Appropriate error messages are shown for blocked interactions
- [ ] Chat participant lists show blocking status

**Implementation Notes**:
- Consider message delivery status for blocked messages
- Implement proper cleanup of existing chat history
- Ensure real-time events are properly filtered

**Testing Requirements**:
- Unit tests for blocking validation
- Integration tests for chat functionality
- Real-time event testing
- Performance tests for chat filtering

**Estimated Complexity**: High
**Dependencies**: jlov-backend/user-service

---

### Task: Update Matching Services for Blocking Logic

**Context**: Ensure blocked users are excluded from all matching algorithms and introduction systems.

**Technical Requirements**:
- Update matchmakers service to exclude blocked users
- Modify introductions service to respect blocking relationships
- Add blocking validation to matching queries
- Update matching algorithms to consider blocking status
- Ensure blocking works across all matching types (AI, human, etc.)

**Acceptance Criteria**:
- [ ] Blocked users are excluded from all matching results
- [ ] Introduction requests respect blocking relationships
- [ ] Matching algorithms perform efficiently with blocking filters
- [ ] Blocking works for both AI and human matchmaking
- [ ] Matching statistics exclude blocked interactions

**Implementation Notes**:
- Optimize database queries to efficiently filter blocked users
- Consider impact on matching algorithm performance
- Ensure blocking works for all brands and matching types

**Testing Requirements**:
- Unit tests for matching blocking logic
- Performance tests for matching algorithms
- Integration tests with user service
- End-to-end matching flow tests

**Estimated Complexity**: High
**Dependencies**: jlov-backend/user-service

---

## Repository: meeplus_ai

### Task: Update AI Matching Service for Blocking

**Context**: Modify the AI matching service to exclude blocked users from compatibility scoring and matching recommendations.

**Technical Requirements**:
- Integrate blocking status checks into matching algorithms
- Update compatibility scoring to exclude blocked users
- Modify introduction management to respect blocking
- Add blocking validation to AI agent responses
- Ensure blocking works with personality matching

**Acceptance Criteria**:
- [ ] AI matching excludes blocked users from recommendations
- [ ] Compatibility scores don't include blocked users
- [ ] AI agent doesn't suggest interactions with blocked users
- [ ] Performance impact is minimal on matching algorithms
- [ ] Blocking works with all AI matching features

**Implementation Notes**:
- Consider caching blocking status in AI service
- Optimize blocking checks for large user datasets
- Ensure blocking works with real-time matching updates

**Testing Requirements**:
- Unit tests for AI blocking logic
- Performance tests for matching algorithms
- Integration tests with user service
- AI agent response validation

**Estimated Complexity**: Medium
**Dependencies**: jlov-backend/user-service

---

## Repository: meeplus_app

### Task: Implement Blocking UI in Mobile App

**Context**: Add user interface for blocking functionality in the mobile application, including blocking actions and visual indicators.

**Technical Requirements**:
- Add "Block User" option to user profile screens
- Implement blocking confirmation dialogs
- Add visual indicators for blocked users in chat and matches
- Update chat interface to show blocking status
- Add blocking management screen in user settings
- Implement proper error handling for blocking actions

**Acceptance Criteria**:
- [ ] Users can block other users from profile screens
- [ ] Blocking confirmation is clear and user-friendly
- [ ] Blocked users are visually indicated in the app
- [ ] Chat interface shows blocking status appropriately
- [ ] Blocking management is accessible in settings
- [ ] App handles blocking errors gracefully

**Implementation Notes**:
- Follow existing UI/UX patterns for consistency
- Consider offline functionality for blocking actions
- Implement proper loading states for blocking operations
- Ensure blocking works across all app brands

**Testing Requirements**:
- UI/UX testing for blocking flows
- Integration tests with backend services
- Cross-platform testing (iOS, Android, Web)
- Offline functionality testing

**Estimated Complexity**: Medium
**Dependencies**: jlov-backend/user-service, jlov-backend/chat-service

---

## Repository: backoffice_client

### Task: Add Blocking Management to Admin Dashboard

**Context**: Provide administrative tools to view and manage user blocking relationships for customer support and moderation.

**Technical Requirements**:
- Add blocking management section to admin dashboard
- Implement blocking relationship viewer
- Add ability for admins to remove blocks
- Show blocking statistics and reports
- Add blocking history and audit trail
- Implement proper role-based access for blocking management

**Acceptance Criteria**:
- [ ] Admins can view all blocking relationships
- [ ] Blocking management interface is intuitive
- [ ] Admins can remove blocks with proper authorization
- [ ] Blocking statistics are available
- [ ] Blocking history is properly logged
- [ ] Role-based access controls work correctly

**Implementation Notes**:
- Follow existing admin dashboard patterns
- Implement proper audit logging for admin actions
- Consider pagination for large blocking datasets
- Ensure proper authorization for blocking management

**Testing Requirements**:
- UI/UX testing for admin interface
- Authorization testing for different admin roles
- Integration tests with backend services
- Audit logging verification

**Estimated Complexity**: Low
**Dependencies**: backoffice_backend

---

## Repository: backoffice_backend

### Task: Add Blocking API Endpoints to Admin Backend

**Context**: Provide administrative API endpoints for managing user blocking relationships and generating blocking reports.

**Technical Requirements**:
- Add admin API endpoints for blocking management
- Implement blocking relationship queries
- Add blocking statistics and reporting endpoints
- Implement admin block removal functionality
- Add proper audit logging for admin actions
- Ensure multi-tenant support for blocking data

**Acceptance Criteria**:
- [ ] Admin API endpoints are properly secured
- [ ] Blocking relationships can be queried efficiently
- [ ] Blocking statistics are accurate and up-to-date
- [ ] Admin actions are properly logged
- [ ] Multi-tenant isolation works correctly
- [ ] API documentation is complete

**Implementation Notes**:
- Use existing authentication and authorization patterns
- Implement proper rate limiting for admin endpoints
- Consider caching for blocking statistics
- Ensure proper error handling and validation

**Testing Requirements**:
- Unit tests for admin blocking logic
- Integration tests with user service
- Authorization and security testing
- Performance tests for blocking queries

**Estimated Complexity**: Medium
**Dependencies**: jlov-backend/user-service

## Cross-Repository Considerations
- **Deployment Order**: User service must be deployed first, followed by dependent services
- **Database Migration**: User blocking table must be created before other services are updated
- **API Versioning**: Consider if blocking changes require API version updates
- **Testing Coordination**: End-to-end testing requires all services to be updated
- **Rollback Strategy**: Each service should be able to rollback independently

## Risk Assessment
- **Performance Impact**: Blocking checks may impact matching and chat performance
- **Data Consistency**: Ensure blocking status is consistent across all services
- **User Experience**: Blocking should be seamless and not disrupt existing functionality
- **Security**: Proper authorization must be maintained for all blocking operations
- **Rollback Plan**: Each service should have independent rollback capability

## Implementation Timeline
1. **Phase 1**: Core blocking functionality (User Service)
2. **Phase 2**: Service integrations (Profile, Chat, Matching)
3. **Phase 3**: Frontend implementations (Mobile App, Admin Dashboard)
4. **Phase 4**: Testing and optimization
5. **Phase 5**: Deployment and monitoring
```

This example demonstrates how the LLM would use the prompt to:
- Analyze the requirement comprehensively
- Break it down into specific, actionable tasks for each repository
- Consider technical dependencies and implementation details
- Provide clear acceptance criteria and testing requirements
- Account for the multi-repository architecture and cross-service dependencies 