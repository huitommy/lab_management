![Build Status](https://codeship.com/projects/03b2e720-e870-0133-f09f-46bb3aa6b241/status?branch=master)
![Code Climate](https://codeclimate.com/github/huitommy/lab_management.png)

## Description of features
LabSolution allows users to fill out an order request form with all the necessary information, add the items they want purchased, and then submit it for review. Admins will receive an in-app notification whenever a request has been submitted, without having to refresh the page. Once the order request has been approved and ordered, admins can then mark it as completed. Users will also be able to search and view a list of all past order requests. I have also added a built-in text editor so that users can format and add protocols to the page.


## Why I built it?
This is a lab management app for the lab that I used to work in. While working there, we often ran into problems with our orders, mainly because order requests were done through email. This app will expedite the ordering process for labs, allowing them to focus on their research.

## Technology used
Labsolutions is built in Ruby on Rails, utilizing Devise for account management, Carrierwave with AWS S3 for document upload, and TinyMCE for the text editor.
