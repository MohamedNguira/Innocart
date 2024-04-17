from rest_framework import serializers
from .models import User
from uuid import uuid4
from django.core.exceptions import ValidationError


class UserSerializer(serializers.Serializer):
    id = serializers.IntegerField(read_only=True)
    passwordMd5hash = serializers.CharField(max_length=300)
    name = serializers.CharField(max_length=100)
    phoneNumber = serializers.CharField()
    email = serializers.CharField(max_length=200)
    age = serializers.IntegerField()
    deliveryRate = serializers.DecimalField(decimal_places=1, max_digits=1000)
    createdOrdersHistoryIds = serializers.JSONField(required=False)
    deliveredOrdersHistoryIds = serializers.JSONField(required=False)
    token = serializers.CharField(required=False, read_only=True)

    def create(self, validated_data):
        user = User.objects.create(**validated_data)
        user.token = uuid4()
        return user

    def update(self, instance, validated_data):
        instance.id = validated_data.get('id', instance.id)
        instance.passwordMd5hash = validated_data.get('passwordMd5hash', instance.passwordMd5hash)
        instance.name = validated_data.get('name', instance.name)
        instance.phoneNumber = validated_data.get('phoneNumber', instance.phoneNumber)
        instance.email = validated_data.get('email', instance.email)
        instance.age = validated_data.get('age', instance.age)
        instance.deliveryRate = validated_data.get('deliveryRate', instance.deliveryRate)
        instance.createdOrdersHistoryIds = validated_data.get('createdOrdersHistoryIds',
                                                              instance.createdOrdersHistoryIds)
        instance.deliveredOrdersHistoryIds = validated_data.get('deliveredOrdersHistoryIds',
                                                                instance.deliveredOrdersHistoryIds)
        instance.token = validated_data.get('token', instance.token)
        instance.save()
        return instance


class UserLoginSerializer(serializers.ModelSerializer):
    # to accept either username or email
    id = serializers.IntegerField(read_only=True)
    name = serializers.CharField()
    passwordMd5hash = serializers.CharField(write_only=True)
    token = serializers.CharField(required=False, read_only=True)

    def validate(self, data):
        # user,email,password validator
        name = data.get("name", None)
        passwordMd5hash = data.get("passwordMd5hash", None)
        if not name and not passwordMd5hash:
            raise ValidationError("Details not entered.")
        user = None
        # if the email has been passed
        if '@' in name:
            user = User.objects.get(email=name, passwordMd5hash=passwordMd5hash)
        else:
            user = User.objects.get(phoneNumber=name, passwordMd5hash=passwordMd5hash)
        data['token'] = uuid4()
        user.token = data['token']
        data['id'] = user.id
        data['name'] = user.name
        user.save()
        return data

    class Meta:
        model = User
        fields = (
            'id',
            'name',
            'token',
            'passwordMd5hash',
        )

        read_only_fields = (
            'id',
            'token',
        )
