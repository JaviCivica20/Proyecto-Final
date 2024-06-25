# Proyecto Final
Proyecto final del curso de Data Engineering de Cívica

<h1>BASE DE DATOS DE VIDEOCLUBS</h1>

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

<p style="text-align: justify;">La tabla de actores está "aislada" en el sentido de que no tiene cabida ni en la dimensión películas, ni como dimensión propia, ni como tabla de hechos pero se usará para hacer un datamart de estadísticas de los clientes</p>

![actor](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/88802822-aa55-47ec-b591-fb22d3c03b59)

<br><br>
<br><br>

<h3>INSERCIÓN DE DATOS CON ARCHIVOS CSV</h3>

<p style="text-align: justify;">La base de datos estaba en 15 archivos CSV que subí directamente a la BRONZE de mi base de datos en Snowflake</p>

![Captura de pantalla 2024-06-19 023710](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/d3176289-1af1-4184-87f8-c116e6f9c382)

<br><br>
<br><br>

<h3>LINAJE DEL PROYECTO EN DBT</h3>

<p style="text-align: justify;">Linaje ordenado del proyecto terminado en DBT, con 7 dimensiones, 2 tablas de hechos y 3 datamarts</p>

![Linaje](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/226c3886-8a08-4a4e-afaf-35bfb6ee0bd4)

<br><br>
<br><br>

<h3>MODELO DIMENSIONAL FINAL</h3>

<p style="text-align: justify;">Como queda el modelo dimensional después de todas las transformaciones realizadas en la capa Silver</p>

![Dimensional](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/352676f9-d2e4-443b-82c3-caf3f18d2692)

<br><br>
<br><br>

<h3>BUILD CORRECTA</h3>

<p style="text-align: justify;">Hago una build para probar la construcción de todas las tablas y la comprobación de todos los test</p>

![x](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/2842c0e9-4444-4349-a0c6-0357db5fa6c0)

<br><br>
<br><br>

<h3>INCREMENTAL</h3>

<p style="text-align: justify;">Video de comprobación de que el modelo incremental aplicado en las tablas de hechos y en su linaje predecesor funciona perfectamente</p>

[https://drive.google.com/file/d/1yQAqfh5d5dqlAzGVorP1kxC_Dxb6cVy9/view?usp=sharing](https://drive.google.com/file/d/11-6qgZCQSRwjxQObszFgwZMwRPyPe_Gd/view?usp=sharing)

<br><br>
<br><br>

<h3>POWER BI</h3>

Dashboard de PowerBI para hacer analítica de los datos de la capa Gold 

![Captura de pantalla 2024-06-20 125242](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/1d05c9d4-6672-42e0-a9c6-4b03a9748da1)

