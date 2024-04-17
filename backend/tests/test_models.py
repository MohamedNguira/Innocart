from django.test import TestCase
from delivery.models import Delivery
from feedback.models import Feedback
from orders.models import Order
from users.models import User


class DeliveryModelTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        Delivery.objects.create(customerId=1, angelId=23, orderId=2,
                                customerConfirmation=True, angelConfirmation=True)

    def test_customer_id_label(self):
        delivery = Delivery.objects.get(id=1)
        field_label = delivery._meta.get_field('customerId').verbose_name
        self.assertEquals(field_label, 'customerId')

    def test_angel_id_label(self):
        delivery = Delivery.objects.get(id=1)
        field_label = delivery._meta.get_field('angelId').verbose_name
        self.assertEquals(field_label, 'angelId')

    def test_order_id_label(self):
        delivery = Delivery.objects.get(id=1)
        field_label = delivery._meta.get_field('orderId').verbose_name
        self.assertEquals(field_label, 'orderId')

    def test_customer_confirmation_label(self):
        delivery = Delivery.objects.get(id=1)
        field_label = delivery._meta.get_field('customerConfirmation').verbose_name
        self.assertEquals(field_label, 'customerConfirmation')

    def test_angel_confirmation_label(self):
        delivery = Delivery.objects.get(id=1)
        field_label = delivery._meta.get_field('angelConfirmation').verbose_name
        self.assertEquals(field_label, 'angelConfirmation')


class FeedbackModelTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        Feedback.objects.create(objectId=12, subjectId=23, deal='0', description='seven years bad luck')

    def test_object_id_label(self):
        feedback = Feedback.objects.get(id=1)
        field_label = feedback._meta.get_field('objectId').verbose_name
        self.assertEquals(field_label, 'objectId')

    def test_subject_id_label(self):
        feedback = Feedback.objects.get(id=1)
        field_label = feedback._meta.get_field('subjectId').verbose_name
        self.assertEquals(field_label, 'subjectId')

    def test_deal_label(self):
        feedback = Feedback.objects.get(id=1)
        field_label = feedback._meta.get_field('deal').verbose_name
        self.assertEquals(field_label, 'deal')

    def test_description_label(self):
        feedback = Feedback.objects.get(id=1)
        field_label = feedback._meta.get_field('description').verbose_name
        self.assertEquals(field_label, 'description')

    def test_description_max_length(self):
        feedback = Feedback.objects.get(id=1)
        max_length = feedback._meta.get_field('description').max_length
        self.assertEquals(max_length, 200)


class OrderModelTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        Order.objects.create(customerId=12, name='Del', description='seven years bad luck',
                             expectedDeliveryTime='04:00:00', status='0', weight='100', cost='100',
                             fee='50', address='Inno basement', possibleAngelsIds=[123, 456],
                             picture='https://qwerty.com')

    def test_customer_id_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('customerId').verbose_name
        self.assertEquals(field_label, 'customerId')

    def test_name_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('name').verbose_name
        self.assertEquals(field_label, 'name')

    def test_description_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('description').verbose_name
        self.assertEquals(field_label, 'description')

    def test_expected_delivery_time_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('expectedDeliveryTime').verbose_name
        self.assertEquals(field_label, 'expectedDeliveryTime')

    def test_status_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('status').verbose_name
        self.assertEquals(field_label, 'status')

    def test_weight_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('weight').verbose_name
        self.assertEquals(field_label, 'weight')

    def test_cost_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('cost').verbose_name
        self.assertEquals(field_label, 'cost')

    def test_fee_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('fee').verbose_name
        self.assertEquals(field_label, 'fee')

    def test_address_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('address').verbose_name
        self.assertEquals(field_label, 'address')

    def test_possible_angels_ids_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('possibleAngelsIds').verbose_name
        self.assertEquals(field_label, 'possibleAngelsIds')

    def test_picture_label(self):
        order = Order.objects.get(id=1)
        field_label = order._meta.get_field('picture').verbose_name
        self.assertEquals(field_label, 'picture')

    def test_name_max_length(self):
        order = Order.objects.get(id=1)
        max_length = order._meta.get_field('name').max_length
        self.assertEquals(max_length, 100)

    def test_time_max_length(self):
        order = Order.objects.get(id=1)
        max_length = order._meta.get_field('expectedDeliveryTime').max_length
        self.assertEquals(max_length, 50)

    def test_description_max_length(self):
        order = Order.objects.get(id=1)
        max_length = order._meta.get_field('description').max_length
        self.assertEquals(max_length, 1000)

    def test_weight_max_digits(self):
        order = Order.objects.get(id=1)
        max_digits = order._meta.get_field('weight').max_digits
        self.assertEquals(max_digits, 1000)

    def test_address_max_length(self):
        order = Order.objects.get(id=1)
        max_length = order._meta.get_field('address').max_length
        self.assertEquals(max_length, 200)

    def test_weight_decimal_places(self):
        order = Order.objects.get(id=1)
        decimal_places = order._meta.get_field('weight').decimal_places
        self.assertEquals(decimal_places, 2)


class UserModelTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        User.objects.create(token='qwe-rty', passwordMd5hash='qwerty12345', name='Del',
                            phoneNumber=8123, email='me@gmail.com', age=80, deliveryRate=1.0,
                            createdOrdersHistoryIds=[123], deliveredOrdersHistoryIds=[89, 90])

    def test_token_label(self):
        user = User.objects.get(id=1)
        field_label = user._meta.get_field('token').verbose_name
        self.assertEquals(field_label, 'token')

    def test_password_md5hash_label(self):
        user = User.objects.get(id=1)
        field_label = user._meta.get_field('passwordMd5hash').verbose_name
        self.assertEquals(field_label, 'passwordMd5hash')

    def test_name_label(self):
        user = User.objects.get(id=1)
        field_label = user._meta.get_field('name').verbose_name
        self.assertEquals(field_label, 'name')

    def test_phone_number_label(self):
        user = User.objects.get(id=1)
        field_label = user._meta.get_field('phoneNumber').verbose_name
        self.assertEquals(field_label, 'phoneNumber')

    def test_email_label(self):
        user = User.objects.get(id=1)
        field_label = user._meta.get_field('email').verbose_name
        self.assertEquals(field_label, 'email')

    def test_age_label(self):
        user = User.objects.get(id=1)
        field_label = user._meta.get_field('age').verbose_name
        self.assertEquals(field_label, 'age')

    def test_delivery_rate_label(self):
        user = User.objects.get(id=1)
        field_label = user._meta.get_field('deliveryRate').verbose_name
        self.assertEquals(field_label, 'deliveryRate')

    def test_created_orders_history_ids_label(self):
        user = User.objects.get(id=1)
        field_label = user._meta.get_field('createdOrdersHistoryIds').verbose_name
        self.assertEquals(field_label, 'createdOrdersHistoryIds')

    def test_delivered_orders_history_ids_label(self):
        user = User.objects.get(id=1)
        field_label = user._meta.get_field('deliveredOrdersHistoryIds').verbose_name
        self.assertEquals(field_label, 'deliveredOrdersHistoryIds')

    def test_token_max_length(self):
        user = User.objects.get(id=1)
        max_length = user._meta.get_field('token').max_length
        self.assertEquals(max_length, 50)

    def test_password_md5hash_max_length(self):
        user = User.objects.get(id=1)
        max_length = user._meta.get_field('passwordMd5hash').max_length
        self.assertEquals(max_length, 300)

    def test_name_max_length(self):
        user = User.objects.get(id=1)
        max_length = user._meta.get_field('name').max_length
        self.assertEquals(max_length, 100)

    def test_phone_number_max_length(self):
        user = User.objects.get(id=1)
        max_length = user._meta.get_field('phoneNumber').max_length
        self.assertEquals(max_length, 20)

    def test_email_max_length(self):
        user = User.objects.get(id=1)
        max_length = user._meta.get_field('email').max_length
        self.assertEquals(max_length, 200)

    def test_delivery_rate_max_digits(self):
        user = User.objects.get(id=1)
        max_digits = user._meta.get_field('deliveryRate').max_digits
        self.assertEquals(max_digits, 1000)

    def test_delivery_rate_decimal_places(self):
        user = User.objects.get(id=1)
        decimal_places = user._meta.get_field('deliveryRate').decimal_places
        self.assertEquals(decimal_places, 1)
