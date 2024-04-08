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

def devolver_plataformasJuegos_PorNombre(request):
    if request.method == 'GET':
        # Obtener el nombre de la plataforma de juegos desde los parámetros de consulta de la URL
        plataformasJuegos_name = request.GET.get('nombre')

        # Verificar si se proporcionó un nombre de plataforma en los parámetros de consulta
        if plataformasJuegos_name:
            try:
                # Obtener la plataforma de juegos por nombre y seleccionar los juegos relacionados
                plataforma = Plataformasjuegos.objects.select_related('juegoid').filter(nombre__icontains=plataformasJuegos_name)

                # Crear un array para almacenar los juegos
                array = []

                # Iterar sobre los juegos y crear un diccionario para cada uno
                for juego in plataforma:
                    diccionario = {
                        'id': juego.juegoid.id,
                        'nombre': juego.juegoid.nombre,
                        'genero': juego.juegoid.genero,
                        'fechaSalida': juego.juegoid.fechasalida,
                        'consola': juego.juegoid.consola,
                        'descripcion': juego.juegoid.descripcion,
                        'urlImagen': juego.juegoid.urlimagen,  # Imagen codificada en base64 o None si no hay imagen
                        'valoracion': juego.juegoid.valoracion,
                        'comentarioId': juego.juegoid.comentarioid.id,
                    }
                    array.append(diccionario)

                return JsonResponse(array, safe=False)
            except Plataformasjuegos.DoesNotExist:
                # Si no se encuentra la plataforma, devolver un mensaje de error
                return JsonResponse({'error': 'Plataforma no encontrada'}, status=404)
            except Exception as e:
                # Manejar cualquier otra excepción que pueda ocurrir
                return JsonResponse({'error': str(e)}, status=500)
        else:
            # Si no se proporcionó el nombre de la plataforma en los parámetros de consulta, devolver un mensaje de error
            return JsonResponse({'error': 'Nombre de plataforma de juegos no proporcionado en la URL'}, status=400)