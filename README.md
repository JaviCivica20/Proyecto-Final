# Proyecto Final del curso de Data Engineering de Cívica
Transformación de una base de datos relacional a un modelo dimensional preparado para analítica usando dbt y Snowflake

<h1>BASE DE DATOS DE ALQUILER DE PELÍCULAS</h1>

<h3>MODELO ENTIDAD-RELACIÓN INICIAL</h3>

<p style="text-align: justify;">Las tablas y relaciones según venían de la fuente</p>

![Captura de pantalla 2024-06-19 215059](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/b6254e72-5f2b-4e54-8a41-5a131376e1fe)

<br><br>

<h3>POSIBLES TABLAS DE HECHOS</h3>

<p style="text-align: justify;">Identifico los procesos de negocio, a ser: RENTAL (Alquileres), PAYMENT (Pagos y, en este modelo, devoluciones de las películas) y PURCHASES (Compras de películas por parte de los videoclubs)</p>

![Procesos de negocio](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/5922ac32-9828-464c-bbd9-22811168c508)

<br><br>

<h3>RELACIÓN 1:1 entre RENTAL y PAYMENT</h3>

<p style="text-align: justify;">Hay un solo pago por alquiler y cada pago es de un único alquiler, por lo que tiene sentido que sean una sola tabla de hechos y dejar PAYMENT_ID como dimensión degenerada</p>

![relacion rental payment](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/6ebc4f12-a795-4dbe-b6a6-5823c8139062)

<br><br>

<h3>POSIBLES DIMENSIONES</h3>

<p style="text-align: justify;">Identifico las dimensiones, a ser: CUSTOMER (Cliente), STAFF (Empleado), STORE (Tienda), FILM (Película), ADDRESS (Dirección) y cuatro "subdimensiones" que pertenecerán a ADDRESS (CITY y COUNTRY) y FILM (LANGUAGE y CATEGORY)</p>

![Dimensiones](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/85c7ca15-0052-42d8-b2d5-c3b536383836)

<br><br>

<h3>TABLAS RELACIONALES DE N:N</h3>

<p style="text-align: justify;">Hay dos tablas intermedias de relaciones N:N, de las cuales, FILM_CATEGORY no tiene sentido porque la relación es N:1 en FILM respecto a CATEGORY</p>

![Tablas intermedias](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/fbb7d8d9-7730-4158-b4e9-c4fd8664b34c)

<br><br>

<h3>TABLA AISLADA</h3>

<p style="text-align: justify;">La tabla de actores está "aislada" en el sentido de que no tiene cabida ni en la dimensión películas, ni como dimensión propia porque no es relevante en los procesos de negocio, ni como tabla de hechos pero se usará para hacer un datamart de estadísticas de los clientes</p>

![actor](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/88802822-aa55-47ec-b591-fb22d3c03b59)

<br><br>
<br><br>

<h3>INSERCIÓN DE DATOS CON ARCHIVOS CSV</h3>

<p style="text-align: justify;">La base de datos estaba en 15 archivos CSV que subí directamente a la capa BRONZE de mi base de datos en Snowflake</p>

![Captura de pantalla 2024-06-19 023710](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/d3176289-1af1-4184-87f8-c116e6f9c382)

<br><br>
<br><br>

<h3>LINAJE DEL PROYECTO EN DBT</h3>

<p style="text-align: justify;">Linaje ordenado del proyecto terminado en DBT, con 7 dimensiones, 2 tablas de hechos y 3 datamarts</p>

![Linaje](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/226c3886-8a08-4a4e-afaf-35bfb6ee0bd4)

<br><br>
<br><br>

<h3>MODELO DIMENSIONAL FINAL</h3>

<p style="text-align: justify;">Como queda el modelo dimensional después de todas las transformaciones realizadas en la capa SILVER</p>

![Dimensional](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/352676f9-d2e4-443b-82c3-caf3f18d2692)

<br><br>
<br><br>

<h3>BUILD CORRECTA</h3>

<p style="text-align: justify;">Hago una build para probar la construcción de todas las tablas y la comprobación de todos los test aplicados a los mdelos</p>

![x](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/2842c0e9-4444-4349-a0c6-0357db5fa6c0)

<br><br>
<br><br>

<h3>INCREMENTAL</h3>

<p style="text-align: justify;">Comprobación de que el modelo incremental aplicado en las tablas de hechos y en su linaje predecesor funciona perfectamente</p>

Insertamos 3 nuevas filas en la tabla de alquileres

![Captura de pantalla 2024-06-28 114547](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/d41bc28e-7ff8-464e-bbd0-48403f165c82)

Hacemos dbt run de la stage y de la intermediate que preceden a la tabla de hechos

![Captura de pantalla 2024-06-28 114655](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/906a8627-a210-4ec9-8b12-6b7c520314b9)

Vemos como salen las 3 nuevas filas en la preview de dbt pero con los campos de pago en null

![Captura de pantalla 2024-06-28 114723](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/a6e87350-d2d6-4309-aa45-8b6fff81a1ed)

Después de construir el modelo ya no salen las nuevas filas

![Captura de pantalla 2024-06-28 114821](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/e09a9689-6062-47d3-bca0-2ae677f8b48f)

Insertamos 2 pagos para 2 de los 3 alquileres insertados previamente

![Captura de pantalla 2024-06-28 115725](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/eb5c5b29-d873-41dc-97e2-954c0e032bbf)

Ejecutamos el stage y la intermediate como hicimos anteriormente

![Captura de pantalla 2024-06-28 115751](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/adce2b05-73cc-4d37-bd1f-db6fcea51c17)

Y podemos comprobar como ya si hay pago para los 2 alquileres correspondientes

![Captura de pantalla 2024-06-28 115808](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/88d69fc1-ae00-48a3-b109-df820fd878b3)

<br><br>
<br><br>

<h3>POWER BI</h3>

Dashboard de PowerBI para hacer analítica de los datos de la capa GOLD (modelo dimensional) 

![Captura de pantalla 2024-06-20 125242](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/1d05c9d4-6672-42e0-a9c6-4b03a9748da1)

