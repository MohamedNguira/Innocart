from django.db import models


class Feedback(models.Model):
    DEAL = (
        ('0', 'DELIVERY'),
        ('1', 'ORDERING'),
    )
    objectId = models.IntegerField(null=False, blank=False)
    subjectId = models.IntegerField(null=False, blank=False)
    deal = models.CharField(max_length=1, choices=DEAL, null=False, blank=False)
    description = models.CharField(max_length=200, null=False, blank=False)
