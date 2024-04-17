from rest_framework import serializers
from .models import Delivery


class DeliverySerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    customerId = serializers.IntegerField()
    angelId = serializers.IntegerField()
    orderId = serializers.IntegerField()
    customerConfirmation = serializers.BooleanField()
    angelConfirmation = serializers.BooleanField()

    def create(self, validated_data):
        return Delivery.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.customerId = validated_data.get('customerId', instance.customerId)
        instance.angelId = validated_data.get('angelId', instance.angelId)
        instance.orderId = validated_data.get('orderId', instance.orderId)
        instance.customerConfirmation = validated_data.get('customerConfirmation', instance.customerConfirmation)
        instance.angelConfirmation = validated_data.get('angelConfirmation', instance.angelConfirmation)
        instance.save()
        return instance


class DeliveryPutSerializer(serializers.ModelSerializer):
    class Meta:
        model = Delivery
        fields = ['customerConfirmation', 'angelConfirmation']
        extra_kwargs = {'customerConfirmation': {'required': False}, 'angelConfirmation': {'required': False}}

    def update(self, instance, validated_data):
        instance.customerConfirmation = validated_data.get('customerConfirmation', instance.customerConfirmation)
        instance.angelConfirmation = validated_data.get('angelConfirmation', instance.angelConfirmation)
        instance.save()
        return instance
