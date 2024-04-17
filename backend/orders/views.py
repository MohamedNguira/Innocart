from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Order
from .serializers import OrderSerializer, OrderPutSerializer
from users.models import User


@api_view(['GET', 'POST'])
def order_list(request, format=None):
    token = request.GET.get('token')
    if token is None or token == '':
        return Response(status=status.HTTP_400_BAD_REQUEST)
    customerId_query = request.GET.get('customerId')
    weightMin_query = request.GET.get('weightMin')
    weightMax_query = request.GET.get('weightMax')
    costMin_query = request.GET.get('costMin')
    costMax_query = request.GET.get('costMax')
    status_query = request.GET.get('status')
    if weightMax_query == '' or weightMin_query == '' or costMax_query == '' \
            or costMin_query == '' or status_query == '' or customerId_query == '':
        return Response(status=status.HTTP_400_BAD_REQUEST)

    if request.method == 'GET':
        orders = Order.objects.all()
        if customerId_query is not None:
            orders = orders.filter(customerId=customerId_query)
        if status_query is not None:
            orders = orders.filter(status=status_query)
        if weightMax_query is not None:
            orders = orders.filter(weight__lte=weightMax_query)
        if weightMin_query is not None:
            orders = orders.filter(weight__gte=weightMin_query)
        if costMax_query is not None:
            orders = orders.filter(cost__lte=costMax_query)
        if costMin_query is not None:
            orders = orders.filter(cost__gte=costMin_query)
        serializer = OrderSerializer(orders, many=True)
        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = OrderSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            user = User.objects.all().get(pk=serializer.data['customerId'])
            user.createdOrdersHistoryIds.append(serializer.data['id'])
            user.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET', 'PUT'])
def order_detail(request, pk, format=None):
    token = request.GET.get('token')
    if token is None or token == '':
        return Response(status=status.HTTP_400_BAD_REQUEST)

    try:
        order = Order.objects.get(pk=pk)
    except Order.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = OrderSerializer(order)
        return Response(serializer.data)

    elif request.method == 'PUT':
        serializer = OrderPutSerializer(order, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
