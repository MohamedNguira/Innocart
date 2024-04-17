# Backend
[REST API](https://app.swaggerhub.com/apis/Innopolis-University1/InnoCart/1.0.0-oas3)

## Technologies
- Python
- Django
- Django REST framework

## How to run?
First, clone the repository and go to the backend directory:
```bash
$ git clone git@github.com:ruca905/InnoCart.git
$ cd InnoCart/backend
```
Create venv enviroment and activate it:
```bash
$ python3 -m venv venv
$ source venv/bin/activate
```
Install all necessary dependencies and migrate the data base:
```bash
$ pip3 install -r requirements.txt
$ python3 manage.py migrate
```
Finally, you can ran a server:
```bash
$ python3 manage.py runserver
```
