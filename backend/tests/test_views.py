from django.test import TestCase
from django.urls import reverse
from delivery.models import Delivery
from feedback.models import Feedback
from orders.models import Order
from users.models import User


class DeliveryViewTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        User.objects.create(token='123', passwordMd5hash='qwerty12345', name='Del',
                            phoneNumber='88005553535',
                            email='yepper@gmail.com', age='14', deliveryRate=5.0,
                            createdOrdersHistoryIds=[123, 456], deliveredOrdersHistoryIds=[45])
        number_of_delivery = 2
        for delivery_num in range(number_of_delivery):
            Delivery.objects.create(customerId=delivery_num, angelId=1, orderId=delivery_num + 2,
                                    customerConfirmation=True, angelConfirmation=True)

    def test_view_url_exists_at_desired_location(self):
        resp = self.client.get('/delivery/?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_accessible_by_name(self):
        resp = self.client.get(reverse('delivery') + '?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_post_url_exists_at_desired_location(self):
        resp = self.client.post('/delivery/?token=123', {
            "customerId": 1,
            "angelId": 1,
            "orderId": 90,
            "customerConfirmation": True,
            "angelConfirmation": True
        })
        self.assertEqual(resp.status_code, 201)

    def test_post_url_accessible_by_name(self):
        resp = self.client.post(reverse('delivery') + '?token=123', {
            "customerId": 1,
            "angelId": 1,
            "orderId": 90,
            "customerConfirmation": True,
            "angelConfirmation": True
        })
        self.assertEqual(resp.status_code, 201)

    def test_view_url_by_order_exists_at_desired_location(self):
        resp = self.client.get('/delivery/3?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_by_order_accessible_by_name(self):
        resp = self.client.get(reverse('delivery by id', args=[3]) + '?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_not_found_at_desired_location(self):
        resp = self.client.get('/delivery/99?token=123')
        self.assertEqual(resp.status_code, 404)

    def test_view_url_not_found_by_name(self):
        resp = self.client.get(reverse('delivery by id', args=[99]) + '?token=123')
        self.assertEqual(resp.status_code, 404)

    def test_put_url_exists_at_desired_location(self):
        resp = self.client.put('/delivery/3?token=123', {
            "customerConfirmation": "true",
            "angelConfirmation": "true"
        }, content_type='application/json')
        self.assertEqual(resp.status_code, 200)

    def test_put_url_accessible_by_name(self):
        resp = self.client.put(reverse('delivery') + '3?token=123', {
            "customerConfirmation": "true",
            "angelConfirmation": "true"
        }, content_type='application/json')
        self.assertEqual(resp.status_code, 200)


class FeedbackViewTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        number_of_feedback = 5
        for feedback_num in range(number_of_feedback):
            Feedback.objects.create(objectId=feedback_num, subjectId=feedback_num + 1,
                                    deal='0', description='seven years bad luck')


class OrdersViewTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        number_of_orders = 5
        User.objects.create(token='123', passwordMd5hash='qwerty12345', name='Del',
                            phoneNumber='88005553535',
                            email='yepper@gmail.com', age='14', deliveryRate=5.0,
                            createdOrdersHistoryIds=[123, 456], deliveredOrdersHistoryIds=[45])
        for order_num in range(number_of_orders):
            Order.objects.create(customerId=order_num, name='Del', description='seven years bad luck',
                                 expectedDeliveryTime='04:00:00', status='0', weight='100', cost='100',
                                 fee='50', address='Inno basement', possibleAngelsIds=[123, 456],
                                 picture='https://qwerty.com')

    def test_view_url_exists_at_desired_location(self):
        resp = self.client.get('/orders/?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_accessible_by_name(self):
        resp = self.client.get(reverse('orders') + '?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_exists_at_desired_location_filter(self):
        resp = self.client.get('/orders/?token=123&weightMin=100&weightMax=500')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_accessible_by_name_filter(self):
        resp = self.client.get(reverse('orders') + '?token=123&weightMin=100&weightMax=500')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_exists_at_desired_location_filter2(self):
        resp = self.client.get('/orders/?token=123&costMin=10&costMax=2000')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_accessible_by_name_filter2(self):
        resp = self.client.get(reverse('orders') + '?token=123&costMin=10&costMax=2000')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_exists_at_desired_location_filter3(self):
        resp = self.client.get('/orders/?token=123&weightMin=100&status=0')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_accessible_by_name_filter3(self):
        resp = self.client.get(reverse('orders') + '?token=123&status=0')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_exists_at_desired_location_filter4(self):
        resp = self.client.get('/orders/?token=123&weightMin=100&weightMax=500&costMin=10&costMax=2000&status=0')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_accessible_by_name_filter4(self):
        resp = self.client.get(reverse('orders') +
                               '?token=123&weightMin=100&weightMax=500&costMin=10&costMax=2000&status=0')
        self.assertEqual(resp.status_code, 200)

    def test_post_url_exists_at_desired_location(self):
        resp = self.client.post('/orders/?token=123', {
            "customerId": 1,
            "name": "Jack",
            "description": "1234",
            "expectedDeliveryTime": "04:00:00",
            "status": "2",
            "weight": "55.00",
            "cost": 55,
            "fee": 33,
            "address": "e532 t",
            "possibleAngelsIds": [
                1,
                2
            ],
            "picture": "http://5.53.125.241:8000/admin/orders/order/add/"
        })
        self.assertEqual(resp.status_code, 201)

    def test_post_url_accessible_by_name(self):
        resp = self.client.post(reverse('orders') + '?token=123', {
            "customerId": 1,
            "name": "Jack",
            "description": "1234",
            "expectedDeliveryTime": "04:00:00",
            "status": "2",
            "weight": "55.00",
            "cost": 55,
            "fee": 33,
            "address": "e532 t",
            "possibleAngelsIds": [
                1,
                2
            ],
            "picture": "http://5.53.125.241:8000/admin/orders/order/add/"
        })
        self.assertEqual(resp.status_code, 201)

    def test_view_url_by_id_exists_at_desired_location(self):
        resp = self.client.get('/orders/1?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_by_id_accessible_by_name(self):
        resp = self.client.get(reverse('order by id', args=[1]) + '?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_not_found_at_desired_location(self):
        resp = self.client.get('/orders/99?token=123')
        self.assertEqual(resp.status_code, 404)

    def test_view_url_not_found_by_name(self):
        resp = self.client.get(reverse('order by id', args=[99]) + '?token=123')
        self.assertEqual(resp.status_code, 404)

    def test_put_url_exists_at_desired_location(self):
        resp = self.client.put('/orders/1?token=123', {
            "status": 2,
            "possibleAngelsIds": [
                789,
                200
            ]
        }, content_type='application/json')
        self.assertEqual(resp.status_code, 200)

    def test_put_url_accessible_by_name(self):
        resp = self.client.put(reverse('orders') + '1?token=123', {
            "status": 2,
            "possibleAngelsIds": [
                789,
                200
            ]
        }, content_type='application/json')
        self.assertEqual(resp.status_code, 200)


class UserViewTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        number_of_users = 10
        for user_num in range(number_of_users):
            User.objects.create(token='123', passwordMd5hash='qwerty12345', name='Del ' + str(user_num),
                                phoneNumber='88005553535 ' + str(user_num),
                                email='yepper@gmail.com ' + str(user_num), age='14', deliveryRate=5.0,
                                createdOrdersHistoryIds=[123, 456], deliveredOrdersHistoryIds=[45])

    def test_view_url_by_user_exists_at_desired_location(self):
        resp = self.client.get('/users/1?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_by_user_accessible_by_name(self):
        resp = self.client.get(reverse('user by id', args=[1]) + '?token=123')
        self.assertEqual(resp.status_code, 200)

    def test_view_url_not_found_at_desired_location(self):
        resp = self.client.get('/users/99?token=123')
        self.assertEqual(resp.status_code, 404)

    def test_view_url_not_found_by_name(self):
        resp = self.client.get(reverse('user by id', args=[99]) + '?token=123')
        self.assertEqual(resp.status_code, 404)

    def test_post_url_sign_in_exists_at_desired_location_number(self):
        resp = self.client.post('/sign_in/', {
            "name": "88005553535 0",
            "passwordMd5hash": "qwerty12345"
        })
        self.assertEqual(resp.status_code, 200)

    def test_post_url_sign_in_accessible_by_name_number(self):
        resp = self.client.post(reverse('sign_in'), {
            "name": "88005553535 0",
            "passwordMd5hash": "qwerty12345"
        })
        self.assertEqual(resp.status_code, 200)

    def test_post_url_sign_in_exists_at_desired_location_email(self):
        resp = self.client.post('/sign_in/', {
            "name": "yepper@gmail.com 0",
            "passwordMd5hash": "qwerty12345"
        })
        self.assertEqual(resp.status_code, 200)

    def test_post_url_sign_in_accessible_by_name_email(self):
        resp = self.client.post(reverse('sign_in'), {
            "name": "yepper@gmail.com 0",
            "passwordMd5hash": "qwerty12345"
        })
        self.assertEqual(resp.status_code, 200)

    def test_post_url_sign_up_exists_at_desired_location(self):
        resp = self.client.post('/sign_up/', {
            "passwordMd5hash": "qwerty12345",
            "name": "Del 8000",
            "phoneNumber": "88005553535",
            "email": "yepper@gmail.com",
            "age": "14",
            "deliveryRate": 5.0,
            "createdOrdersHistoryIds": [666, 777],
            "deliveredOrdersHistoryIds": [1]
        })
        self.assertEqual(resp.status_code, 201)

    def test_post_url_sign_up_accessible_by_name(self):
        resp = self.client.post(reverse('sign_up'), {
            "passwordMd5hash": "qwerty12345",
            "name": "Del 8000",
            "phoneNumber": "88005553535",
            "email": "yepper@gmail.com",
            "age": "14",
            "deliveryRate": 5.0,
            "createdOrdersHistoryIds": [666, 777],
            "deliveredOrdersHistoryIds": [1]
        })
        self.assertEqual(resp.status_code, 201)
