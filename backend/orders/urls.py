from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from views import order_list, order_detail

urlpatterns = [
    path(r'^orders/$', order_list, name='orders'),
    path(r'^orders/<int:pk>$', order_detail, name='order by id'),
]

urlpatterns = format_suffix_patterns(urlpatterns)
