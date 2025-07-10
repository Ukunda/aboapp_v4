# Plan to Implement Email Subscription Scanning

### 1. Integrate an IMAP Library
- **Action:** Add the `enough_mail` package to the project's `pubspec.yaml` file.
- **Purpose:** To enable communication with IMAP email servers.

### 2. Implement Email Fetching Logic
- **File:** `lib/features/subscriptions/data/datasources/email_subscription_datasource.dart`
- **Method:** `fetchSuggestions` in `EmailSubscriptionDataSourceImpl`
- **Details:**
    - Securely connect to the user's email server using provided credentials.
    - Select the primary inbox for scanning.
    - To ensure efficiency, search only for emails from the last 90 days from known subscription providers.

### 3. Process and Parse Emails
- **Action:** For each relevant email found, download its content.
- **Function:** Use the existing `parseEmail` function to extract subscription details (service, amount, billing cycle).

### 4. Error Handling and Security
- **Action:** Implement robust error handling for issues like incorrect login credentials or network problems.
- **Security Note:** Storing and handling email passwords requires high security. A future iteration should implement a more secure method for storing credentials, such as using the `flutter_secure_storage` package.

### Visual Flow
```mermaid
sequenceDiagram
    participant User
    participant SuggestionScreen
    participant SubscriptionSuggestionCubit
    participant ScanEmailSubscriptionsUseCase
    participant EmailSubscriptionDataSource
    participant IMAPServer

    User->>SuggestionScreen: Enters email credentials and taps "Scan"
    SuggestionScreen->>SubscriptionSuggestionCubit: scan(credentials)
    SubscriptionSuggestionCubit->>SubscriptionSuggestionCubit: emit(loading)
    SubscriptionSuggestionCubit->>ScanEmailSubscriptionsUseCase: call(credentials)
    ScanEmailSubscriptionsUseCase->>EmailSubscriptionDataSource: fetchSuggestions(credentials)
    EmailSubscriptionDataSource->>IMAPServer: Connect & Authenticate
    IMAPServer-->>EmailSubscriptionDataSource: Connection successful
    EmailSubscriptionDataSource->>IMAPServer: Search recent emails
    IMAPServer-->>EmailSubscriptionDataSource: List of emails
    loop For each email
        EmailSubscriptionDataSource->>IMAPServer: Fetch email body
        IMAPServer-->>EmailSubscriptionDataSource: Email body
        EmailSubscriptionDataSource->>EmailSubscriptionDataSource: parseEmail(body)
    end
    EmailSubscriptionDataSource-->>ScanEmailSubscriptionsUseCase: List of SubscriptionSuggestionModel
    ScanEmailSubscriptionsUseCase-->>SubscriptionSuggestionCubit: List of SubscriptionSuggestion
    SubscriptionSuggestionCubit->>SubscriptionSuggestionCubit: emit(loaded/empty)
    SubscriptionSuggestionCubit-->>SuggestionScreen: Update UI with suggestions
    SuggestionScreen-->>User: Displays found subscriptions