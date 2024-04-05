from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views import View
from .models import Users
from .models import Juegos
from .models import Comentariosjuegos
from .models import Favoritos
from .models import Plataformasjuegos
import json, jwt
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.hashers import check_password
import datetime
from django.core.paginator import Paginator
from django.views.decorators.http import require_POST

# Create your views here.

def devolver_usuarios(request):
	usuarios = Users.objects.all()
	array = []
	for usuario in usuarios:
		diccionario = {}
		diccionario['id'] = usuario.id
		diccionario['nombre'] = usuario.nombre
		diccionario['apellidos'] = usuario.apellidos
		diccionario['contraseña'] = usuario.contraseña
		diccionario['telefono'] = usuario.telefono
		diccionario['email'] = usuario.email
		diccionario['juegoFavoritoId'] = usuario.juegofavoritoid.id
		diccionario['comentarioJuegoId'] = usuario.comentariojuegoid.id
		array.append(diccionario)
	return JsonResponse(array, safe = False)

def devolver_juegos(request):
	juegos =Juegos.objects.all()
	array = []
	for juego in juegos:
		diccionario = {}
		diccionario['id'] = juego.id
		diccionario['nombre'] = juego.nombre
		diccionario['genero'] = juego.genero
		diccionario['fechaSalida'] = juego.fechasalida
		diccionario['consola'] = juego.consola
		diccionario['descripcion'] = juego.descripcion
		diccionario['urlImagen'] = juego.urlimagen
		diccionario['valoracion'] =juego.valoracion
		diccionario['comentarioId'] = juego.comentarioid.id
		array.append(diccionario)
	return JsonResponse(array, safe = False)