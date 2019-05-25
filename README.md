# Tempelhof Reviews

This app allows you to browse reviews on The Berlin Tempelhof Airport posted on Get Your Guide.

## Using The App

There are two screens in the app, the main reviews list screen where a summary of different reviews can be seen and a details screen. On tapping on any of the cells on the list, a details screen can be seen that allows a more in depth look at the review.

## Technical Implementation

The app uses the MVVM-C architecture. The coordinator creates an instance of the ReviewViewController and returns it to the App Delegate where it is set as the root view controller of a navigation controller which itself becomes the root of window. Each view controller is injected with a view model which handles fetching and providing data to the view controller. The decision to avoid using a storyboard is in appreciation of the fact that storyboards are difficult to manage in a shared development team.

The fetching is done is a paginated manner. Each request fetches 10 review objects and a new request is triggered everytime the table view is scrolled to its bottom.

## Third Party Frameworks

1. SDWebImage
	- Used to asynchronously fetch profile images.

2. UIImageView+Letters
	- An extension that lets you set an alphabet and a background to image views. Used to show first initial on profile image where user's image is not available.

