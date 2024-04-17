from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import User
from .serializers import UserSerializer, UserLoginSerializer


@api_view(['GET'])
def user_detail(request, pk, format=None):
    token = request.GET.get('token')
    if token is None or token == '':
        return Response(status=status.HTTP_400_BAD_REQUEST)

    try:
        user = User.objects.get(pk=pk)
    except User.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = UserSerializer(user)
        user_data = serializer.data
        del user_data['passwordMd5hash']
        return Response(user_data)


@api_view(['POST'])
def sign_up(request, format=None):
    if request.method == 'POST':
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def sign_in(request, format=None):
    serializer_class = UserLoginSerializer(data=request.data)
    if serializer_class.is_valid(raise_exception=True):
        return Response(serializer_class.data, status=status.HTTP_200_OK)
    return Response(serializer_class.errors, status=status.HTTP_400_BAD_REQUEST)
