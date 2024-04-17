from rest_framework import serializers
from .models import Order


class OrderSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    customerId = serializers.IntegerField()
    name = serializers.CharField(max_length=100)
    description = serializers.CharField(max_length=1000)
    expectedDeliveryTime = serializers.CharField(max_length=50)
    status = serializers.CharField(max_length=1)
    weight = serializers.DecimalField(decimal_places=2, max_digits=1000)
    cost = serializers.IntegerField()
    fee = serializers.IntegerField()
    address = serializers.CharField(max_length=200)
    possibleAngelsIds = serializers.JSONField()
    picture = serializers.URLField()

    def create(self, validated_data):
        return Order.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.id = validated_data.get('id', instance.id)
        instance.customerId = validated_data.get('customerId', instance.customerId)
        instance.name = validated_data.get('name', instance.name)
        instance.description = validated_data.get('description', instance.description)
        instance.expectedDeliveryTime = validated_data.get('expectedDeliveryTime', instance.expectedDeliveryTime)
        instance.status = validated_data.get('status', instance.status)
        instance.weight = validated_data.get('weight', instance.weight)
        instance.cost = validated_data.get('cost', instance.cost)
        instance.fee = validated_data.get('fee', instance.fee)
        instance.address = validated_data.get('address', instance.address)
        instance.possibleAngelsIds = validated_data.get('possibleAngelsIds', instance.possibleAngelsIds)
        instance.picture = validated_data.get('picture', instance.picture)
        instance.save()
        return instance


class OrderPutSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ['status', 'possibleAngelsIds']
        extra_kwargs = {'status': {'required': False}}

    def update(self, instance, validated_data):
        instance.status = validated_data.get('status', instance.status)
        instance.possibleAngelsIds = validated_data.get('possibleAngelsIds', instance.possibleAngelsIds)
        instance.save()
        return instance
