from django.db.models import Q
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

#En esta función, simplemente cogeremos todos los datos de la tabla usuarios y los imprimiremos por pantalla
def devolver_usuarios(request):
    if request.method == 'GET':
        usuarios = Users.objects.all()
        array = []
        for usuario in usuarios:
            diccionario = {
                'id': usuario.id,
                'nombre': usuario.nombre,
                'apellidos': usuario.apellidos,
                'contraseña': usuario.contraseña,
                'telefono': usuario.telefono,
                'email': usuario.email,
                'juegoFavoritoId': usuario.juegofavoritoid.id,
                'comentarioJuegoId': usuario.comentariojuegoid.id,
                'sessionToken': usuario.sessiontoken
            }
            array.append(diccionario)
        return JsonResponse(array, safe = False)
    else:
        return JsonResponse("Method not allowed")

#En esta función, simplemente cogeremos todos los datos de la tabla juegos y los imprimiremos por pantalla
def devolver_juegos(request):
    if request.method == 'GET':
        juegos =Juegos.objects.all()
        array = []
        for juego in juegos:
            diccionario = {
                'id': juego.id,
                'nombre': juego.nombre,
                'genero': juego.genero,
                'fechaSalida': juego.fechasalida,
                'consola': juego.consola,
                'descripcion': juego.descripcion,
                'urlImagen': juego.urlimagen,
                'compañia': juego.compañia,
                'valoracion': juego.valoracion,
                'comentarioId': juego.comentarioid.id
            }
            array.append(diccionario)
        return JsonResponse(array, safe = False)
    else:
        return JsonResponse("Method not allowed")

def devolver_juegos_PorNombrePlataforma(request):
    if request.method == 'GET':
        #Introduciremos el nombre después de la palabra "nombre" localizada en la URL del buscador y convertimos la primera letra a mayúscula
        plataformasJuegos_name = request.GET.get('nombre').capitalize()

        #Si existe el nombre de la plataforma
        if plataformasJuegos_name:
            try:
                # Obtener la plataforma de juegos por nombre y seleccionar los juegos relacionados
                plataformas = Plataformasjuegos.objects.select_related('juegoid').filter(nombre__startswith=plataformasJuegos_name)

                # Creación del array
                array = []

                #Guardamos los datos con un bucle
                for juego in plataformas:

                    for plataforma in plataformas:
                        #Esto lo hago para coger siempre el nombre completo de la plataforma y meterlo dentro del array y convertimos la primera letra a mayúscula
                        plataforma_name = plataforma.nombre.capitalize()

                    diccionario = {
                        'id': juego.juegoid.id,
                        'nombre': juego.juegoid.nombre,
                        'genero': juego.juegoid.genero,
                        'fechaSalida': juego.juegoid.fechasalida,
                        'consola': juego.juegoid.consola,
                        'descripcion': juego.juegoid.descripcion,
                        'urlImagen': juego.juegoid.urlimagen,
                        'valoracion': juego.juegoid.valoracion,
                        'comentarioId': juego.juegoid.comentarioid.id,
                        'nombrePlataforma': plataforma_name
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

def devolver_juegos_PorGenero(request):
     if request.method == 'GET':
          #Introduciremos el género después de la palabra "genero" localizada en la URL del buscador y convertimos la primera letra a mayúscula
          genero_name = request.GET.get('genero').capitalize()
          
          #Si existe el nombre del genero
          if genero_name:
               try:
                    #Filtramos la tabla por el género que haya introducido el usuario
                    juegos = Juegos.objects.filter(genero__startswith = genero_name)

                    #Creación del array
                    array = []

                    #Guardamos los datos con un bucle
                    for juego in juegos:
                         diccionario = {
                            'id': juego.id,
                            'nombre': juego.nombre,
                            'genero': juego.genero,
                            'fechaSalida': juego.fechasalida,
                            'consola': juego.consola,
                            'descripcion': juego.descripcion,
                            'urlImagen': juego.urlimagen,
                            'compañia': juego.compañia,
                            'valoracion': juego.valoracion,
                            'comentarioId': juego.comentarioid.id
                         }
                         array.append(diccionario)
                    
                    #Devolvemos el resultado en formato de objeto
                    return JsonResponse(array, safe = False)

               except Juegos.DoesNotExist:
                # Si no se encuentra el juego, devolver un mensaje de error
                    return JsonResponse({'error': 'Juego no encontrado'}, status=404)
               except Exception as e:
                # Manejar cualquier otra excepción que pueda ocurrir
                return JsonResponse({'error': str(e)}, status=500)
     else:
            # Si no se proporcionó el nombre de la plataforma en los parámetros de consulta, devolver un mensaje de error
        return JsonResponse({'error': 'Nombre del juego no proporcionado en la URL'}, status=400)

def devolver_juegos_PorNombre(request):
    if request.method == 'GET':
        #Introduciremos el género después de la palabra "genero" localizada en la URL del buscador y convertimos la primera letra a mayúscula
        juego_name = request.GET.get('nombre').capitalize()
    
    #Si existe el nombre del juego
        if juego_name:
            try:
                #Filtramos la tabla por el nombre del juego que haya introducido el usuario o buscamos el alias del juego
                juegos = Juegos.objects.filter(Q(nombre__startswith = juego_name) | Q(alias__icontains=juego_name.lower()))

                #Creación del array
                array = []

                #Guardamos los datos con un bucle
                for juego in juegos:
                    diccionario = {
                        'id': juego.id,
                        'nombre': juego.nombre,
                        'genero': juego.genero,
                        'fechaSalida': juego.fechasalida,
                        'consola': juego.consola,
                        'descripcion': juego.descripcion,
                        'urlImagen': juego.urlimagen,
                        'compañia': juego.compañia,
                        'valoracion': juego.valoracion,
                        'comentarioId': juego.comentarioid.id
                    }
                    # Verificar si el juego tiene un alias
                    if juego.alias:
                        # Si tiene alias, agregamos el campo 'alias' al diccionario
                        diccionario['alias'] = juego.alias
                    array.append(diccionario)
                
                return JsonResponse(array, safe = False)

            except Juegos.DoesNotExist:
                # Si no se encuentra el juego, devolver un mensaje de error
                return JsonResponse({'error': 'Juego no encontrado'}, status=404)
            except Exception as e:
                # Manejar cualquier otra excepción que pueda ocurrir
                return JsonResponse({'error': str(e)}, status=500)
        else:
            # Si no se proporcionó el nombre de la plataforma en los parámetros de consulta, devolver un mensaje de error
            return JsonResponse({'error': 'Nombre del juego no proporcionado en la URL'}, status=400)