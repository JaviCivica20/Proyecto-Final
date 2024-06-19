# Proyecto Final
Proyecto final del curso de Data Engineering de Cívica

<h1>BASE DE DATOS DE VIDEOCLOUBS</h1>

<h3>MODELO ENTIDAD-RELACIÓN INICIAL</h3>


![Captura de pantalla 2024-06-19 215059](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/b6254e72-5f2b-4e54-8a41-5a131376e1fe)





<h3>PROCESOS DE NEGOCIO</h3>


![Procesos de negocio](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/5922ac32-9828-464c-bbd9-22811168c508)





<h3>POSIBLES DIMENSIONES</h3>


![Dimensiones](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/6434e116-3341-4966-8238-26da97332940)





<h3>TABLAS RELACIONALES DE N:N</h3>


![Tablas intermedias](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/fbb7d8d9-7730-4158-b4e9-c4fd8664b34c)





<h3>TABLA AISLADA</h3>


![actor](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/88802822-aa55-47ec-b591-fb22d3c03b59)







INCREMENTAL

dbt run -f -s fct_rentals_returns

dbt run -f -s stg_dbt_proyecto_final__rental int_rental_payment_combined

dbt run -f -s stg_dbt_proyecto_final__payment int_rental_payment_combined



![Captura de pantalla 2024-06-19 023710](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/d3176289-1af1-4184-87f8-c116e6f9c382)



![Captura de pantalla 2024-06-19 190558](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/dd9b9fed-65b1-4a45-b0bf-5a0d3751fdd5)






