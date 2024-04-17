<img src="https://raw.githubusercontent.com/InnoSWP/InnoCart-04/912ebc85c8e8acee39a292d8a3c35e3cf4368d18/images/Untitled-2%20(2).jpg" width="200">

# InnoCart project 


![GitHub](https://img.shields.io/github/license/InnoSWP/InnoCart-04)
![GitHub contributors](https://img.shields.io/github/contributors/InnoSWP/InnoCart-04)
![GitHub issues](https://img.shields.io/github/issues/InnoSWP/InnoCart-04)
![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/InnoSWP/InnoCart-04)
![GitHub release (latest SemVer including pre-releases)](https://img.shields.io/github/v/release/InnoSWP/InnoCart-04?include_prereleases)


An application that connects Innopolis residents (customers) with people moving around Kazan (Angels). Customer can order some products (medics, food, ..) from Kazan and Angels would deliver it heading their way to Innopolis. 

Customers save time and money for the road & Angels make money while they are doing their own business.

## Demo Video

https://drive.google.com/file/d/18EpAnUjUA7nOSiD0BtouWZ14MJ6CG9fx/view?usp=sharing

## Implemented features
#### Common
* Log in/Log out
* Sign up as a customer/angel
#### As user
* Add an order
* View the order details
* Choose an angel
* View delivery status
#### As Angel
* Send a request
* View the order details
* View delivery status
* Confirm the order

## How to run?
First, clone the repository and go to the backend directory:
```bash
$ git clone git@github.com:ruca905/InnoCart.git
$ cd InnoCart/backend
```
Create venv environment and activate it:
```bash
$ python3 -m venv venv
$ source venv/bin/activate
```
Install all necessary dependencies and migrate the data base:
```bash
$ pip3 install -r requirements.txt
$ python3 manage.py migrate
```
Finally, you can run a server:
```bash
$ python3 manage.py runserver
```
## How to use
After installation you can sign up and use the aplication either like a customer or an Angel. You can do all actions from feature list.

## Figma design
<img src="https://raw.githubusercontent.com/InnoSWP/InnoCart-04/master/images/Frame.png" width="600">

## Technology stack
* Django
* Django Rest Framework
* Flutter
* Dart

## Pipeline stack
* GitHub Actions
* Linter
* SonarCloud

## Additional links
* [Wiki](https://github.com/InnoSWP/InnoCart-04/wiki)
* [REST API](https://app.swaggerhub.com/apis/Innopolis-University1/InnoCart/1.0.0-oas3)
* [Backlog](https://github.com/orgs/InnoSWP/projects/17)

