# flutter_workout_planner

Workout Planner application in Flutter for an ongoing interview.

## Getting Started

Dependencies used:
* Riverpod - Manage the reactive state of the app
* GoRouter - navigation
* uuid -  Generated Unique identifier for the data
* dots_indicator - Dots indicator used together with PageView
* numberpicker - A Scrollable NumberPicker
* Hive - Save the state in a NoSQL Database
* material_design_icons_flutter - Material Design icons
* json_annotation, json_serializable used together with Hive in order to generate fromJson and toJson
* build_runner - run generators

As pointed above this project uses Riverpod as state manamgenet solution, the reason I decided to go with this package was:
1. It's a more recommended for those using Riverpord
2. It's implementation its cleaner and simpler.
3. As requested in the task the application should have 2 screens one to create and edit the workout and one to list the workouts created.
- For the workout screen because it will have TextField widgets the best approach is to use TextEditingController with those TextFields and we need to be able to manage those controllers. The ideal solution is to use ChangeNotifier as it accepts multiple parameters be used in the same Provider.

- Now for the workouts screen where we list the workouts created I decided to use a StateNotifier, when having a list of Data that you want to manage it's best to use StateNotifier. StateNotifier compared to ChangeNotifier accepts only one single state and that's what we need in order to manage a list of workouts.

For the navigation I use the GoRouter as it provides simpler implementaiton of Declerative Navigator 2.0.

The project structure is split like this:
1. screens - Screen widget that would be the root of the navigation route.
* IntroScreen - The introduction screen in case you don't have User Profile yet.
* WorkoutsScreen - The screen where we list the workouts added.
* WorkoutScreen - The screen where we add new workout, edit or remove an existing workout
* SettingsScreen - The screen where we show the User Profile and allow the user to delete the profile.
* ExerciseScreen - The screen where the user can select a exercise for the workout.

2. pages - Although Screens and Pages basically mean the same thing, and most developers don't differentiate them, for this project the pages represent the page for the PageView widget, so you can say that a Screen can have multiple Pages.
* IntroPage - The page where I show some introduction info.
* GenderPage - The page where we allow the user to select the gender during the intial process.
* AgePage - The page where we allow the user to select the birth date.
* HeightPage - The page to select the Height in cm.
* WeightPage - The page to select the Weight in kg.
* MetricPage - a child of Height & Weight Page.
* NamePage - The page to type the user name.

3. models - This represents the Data structure for the app
* Profile - The model data used to create the User Profile based on the data inputed in the Introduction step.
* Intro - The model data used to create the introduction info data.
* Workout - The model data for the workout itself.
* Exercise - The model data used for the exercise selected for the workout.
* WorkoutSet - The model data used for the sets data inputed for the workout.
* WorkoutSetField - The model data used for the TextEditingControllers that manage the sets data when creating or editing a workout.
* ProfileData and WorkoutsData - it's used to keep the Profile and Workouts data and know whether the data was locally loaded yet or not

3. manages - This holds all the providers created using Riverpod in order to manage the state, or as I liked to call them managers.
* SetupManager - Manages the introduction setup data.
* ProfileManager - Manages the data created during the introduction setup process.
* EditWorkoutManager - Manages the data manipulated in the WorkoutScreen
* WorkoutsManager - Manages the list of workouts data created using the EditWorkoutManager and get listed at WorkoutsScreen
* Router - Manages the GoRouter data and assist's in deciding the initial route based on the data available that was being stored using Hive.

4. adapters - This holds all the adapters used by Hive in order to create an object from json and json from object when storing and retreving the box data.
* ProfileAdapter - Convert fromJson/toJson when storing and retrieving Profile Data.
* WorkoutAdapter - Convert fromJson/toJson when storing and retrieving Workout Data.

4. converters - This holds all the converters used by Hive in order to convert the passed or retrieved data.
* Color converter - Convert the color of the workout from `Color` to `int` and visa versa.

5. utils - it holds various utilities like const hardcoded data for the colors, exercises and intro data and a general function to show a confirm dialog.

6. widgets - It holds all the widges used at different pages and screens.
- AppScaffold - General Scaffold used for the nested Navigator.
* ExerciseWidget - Used to render the exercise in the ExerciseScreen.
* GenderWidget - Used to render a single geneder item in the GenderPage.
* ProfileField - Used to render the profile data at SettingsScreen.
* WorkoutSetWidget - Used to render the workout sets at WorkoutScreen.
* WorkoutWidget - Used to list the actual workout in the WorkoutsScreen.

When running the application for the first time you will be greeted with the IntroScreen which shows a brief information about the application, this screen uses PageView dogether with a dots indicator bellow it in order to create intro like screen that's swipable. The screen also has a Skip, a Next and a Done button which are shown according to the page the user is at the moment.

After clicking the Done button, you will be again greated with a IntroScreen, but this time it shows the initial profile setup process. The user can select the standards question asked for this type of applications: Gender, Age, Height, Weight and a Name at this Screen. The Gender Page uses GridView to render the list of Gender selection. At the AgePage user can select the birth date using the CupertinoDatePicker. At the Height and Weight Page user can use the DecimalNumberPicker in order to select the height and weight, and on the NamePage it can input the name, if the user doesn't select a gender or inputs a name the user is presented a Snackbar explaining why he can't move forward and how to fix that.

After compliting the profile process the user is shown the WorkoutsScreen where it's empty and a single Add button with the message 'Add your First Workout!' message on the top. Uppon clicking the Add button the WorkoutScreen page is shown.
Here the user can select the name for the workout, the exercise, add and remove sets, reps and weight for the workout, add a rest between sets using the CupertinoTimePicker, and even select a color and leave a notes. In case the workout is an existing one the user sees a Remove red button at the very bottom, which uppon clicking it will show a confirm dialog asking to confirm the choice.

When selecting an Exercise the user is presented with a separate ExerciseScreen that lists the available exercises in a GridView layout. As pointed above although not requested in the documention, I added a common data shown for this type of application and those are:
- Ability to add and remove sets for the workout.
- Rest time between sets.
- Color selection to make the workout more visually present to the user.
- Notes.

Also I've included validation by taking when creating and editing a workout, where depending on the missing or invalid data the user will be presented with the correct message. To achieve this I used Dart's Enums to create error types and assign specific messages for each.

Uppon saving the first Workout the user no longer sees 'Add your First Workout!' message, instead it sees the WorkoutWidget which nicely renders the workout data saved. The widget show the name and exercise of the workout along with the exercise icon on the very left. Bellow that it shows the lists of sets. If you swipe right on the card above the sets it will show a delete button thank's to the Slidable widget, and as you can see only that portion is sliding the sets portion bellow that stays.

On the bottom of the WorkoutsScreen you can see the BottomNavigationBar with 2 items, Workouts and Settings and a Floating action button that takes you to the WorkoutScreen to add a new workout. 
Clicking Settings will show the SettingsPage which shows the Profile data with a Remove Profile red button which will show a confirm dialog alerting you that all of the data will be removed if you click ok. We also preserve the navigation state here so that when you click back button while you are at SettingsPage it will take you back to WorkoutsPage instead of closing the application. And again the SettingsScreen its an extra implementation which I decided to use in order to demonstrate Nested Navigation using BottomNavigationBar

Lastly all this data is stored in a NoSQL Database using the Hive Package.

## Running

1. Install packages
`flutter pub get`

2. Run the Generators
`flutter pub run build_runner build`

3. Run the application.


## Testing
For this task I did 3 test cases one for each type of test.

1. Unit Test - `test/add_workout_test.dart`

Here I'm testing the EditWorkoutManager and WorkoutsManager by creaing a workout and adding that same workout to the WorkoutsManager. I achieve this by using Riverpod's Container which gives me access to the Providers in a Dart only environment.


2. Widget Test - `test/workout_widget_test.dart`

Here I'm testing a single widget, that is the WorkoutWidget by creating a mock data and testing whether the element is visually correct, like for example testing whether the Container of the WorkoutWidget is correctly colored and has the correct border radius.


3. Integration Test - `integration_test/add_workout_test.dart`

Here I'm testing a complete flow of the app by running it on a real device or emulator/simulator and testing the initial profile creation step and creating and rendering the first workout.