from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from views import delivery_list, delivery_detail

urlpatterns = [
    path(r'^delivery/$', delivery_list, name='delivery'),
    path(r'^delivery/<int:pk>$', delivery_detail, name='delivery by id'),
]

urlpatterns = format_suffix_patterns(urlpatterns)
