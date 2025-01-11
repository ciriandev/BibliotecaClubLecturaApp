# BibliotecaClubLecturaApp
Aplicación móvil para la gestión de la biblioteca del club de lectura.

## Notas
Tenemos una api gratuita que no gestionamos nosotros de la que obtenemos las fotos de las portadas.

[Página explicativa de la API externa](https://openlibrary.org/dev/docs/api/covers)

Patrón de acceso a la URI de la API:
`https://covers.openlibrary.org/b/$key/$value-$size.jpg`

key: valor por el que vamos a buscar, en nuestro caso ISBN
value: valor de busqueda, ISBN del libro
size: tamaño de la image, en nuestro caso usamos S (pequeñas) o M (medianas), hay un tamaño más que es L (grandes).
