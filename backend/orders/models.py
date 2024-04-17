from django.db import models


class Order(models.Model):
    STATUS = (
        ('0', 'CREATED'),
        ('1', 'IN_PROGRESS'),
        ('2', 'COMPLETED'),
    )
    customerId = models.IntegerField(null=False, blank=False)
    name = models.CharField(max_length=100, null=False, blank=False)
    description = models.CharField(max_length=1000, null=True, blank=True, default='')
    expectedDeliveryTime = models.CharField(max_length=50, null=False, blank=False)
    status = models.CharField(max_length=1, choices=STATUS, null=False, blank=False)
    weight = models.DecimalField(decimal_places=2, max_digits=1000, null=False, blank=False)
    cost = models.IntegerField(null=False, blank=False)
    fee = models.IntegerField(null=False, blank=False)
    address = models.CharField(max_length=200, null=False, blank=False)
    possibleAngelsIds = models.JSONField(null=False, blank=False, default=dict)
    picture = models.URLField(null=True, blank=True, default='')
