# FlickrVisualizer
FlickrVisualizer is an iOS app written in Objective-C to view a collection of images provided by Flickr. The user can search images by tags and view the detail of a specific image. This app is universal, it can run on iPad and iPhone.

# How to get started
This project uses [Cocoapods](http://cocoapods.org) as dependency manager. Dependencies are included in the repository so no initial setup is required. When adding new dependencies or updating please use `pod install`on the root of the project folder.

# Dependencies
FlickrVisualizer uses two third party libraries:
- [FlickrKit](https://github.com/devedup/FlickrKit) used for communication with the Flickr API
- [AFNetworking](https://cocoapods.org/?q=afnetwor) used as helper to load the images into the view, could be used in the future to replace FlickrKit.

# Requirements
FlickrVisualizer requires iOS 9 and above.

# Features
- Initial Homescreen shows a grid of images with a predefined search. 
- Search by tag: User can add/remove tags to search on Flickr.
- Detail: On tap on a thumb the user navigates to a detail view of the image.
- Break-it: On tap on the "break it" button phyiscs are applied to the thumbs.

