"""InnoCart URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from orders.views import order_list, order_detail
from users.views import user_detail, sign_up, sign_in
from delivery.views import delivery_detail, delivery_list
from rest_framework.schemas import get_schema_view

urlpatterns = [
    path('admin/', admin.site.urls),
    path('orders/', order_list, name='orders'),
    path('orders/<int:pk>', order_detail, name='order by id'),
    path('api_schema/', get_schema_view(title='API Schema', description='Guide for the REST API'), name='api_schema'),
    path('users/<int:pk>', user_detail, name='user by id'),
    path('sign_up/', sign_up, name='sign_up'),
    path('sign_in/', sign_in, name='sign_in'),
    path('delivery/', delivery_list, name='delivery'),
    path('delivery/<int:pk>', delivery_detail, name='delivery by id'),
]

urlpatterns = format_suffix_patterns(urlpatterns)
