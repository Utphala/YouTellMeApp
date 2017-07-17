# About
My first iOS app written in Swift. YouTellMe app is an app to send-out surveys with multiple questions to the users and collecting feedback. Requires users to sign-in to take the app.

# Design
This iOS app provides basic UI/frontend to,
1. Present list of surveys available for a user to take.
2. User selecting survey interested in
3. Going through selected survey question by question, providing multiple choices to select.
4. Submitting finished surveys.

This app provides UI to do above tasks by pulling data and interacting with a backend webservice written in Python-Flask: https://github.com/Utphala/YouTellMeBackendService.

This is first iteration of the app. In the future enhancements, 
1. Surveys can have topics/tags associated.
2. Users can opt-in what topics they are interested in and see/take only those surveys.
3. Targeting surveys to specific group of users.
4. Surveys with different types of data instead of just multiple-choice (like, asking user to write feedback, rate something etc)
5. Improve UI to be more visually appealing. 
etc
