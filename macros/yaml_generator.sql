-- Genera el contenido del yml correspondiente a los modelos del directorio y prefijo especificados

{% set models_to_generate = codegen.get_models(directory='staging/dbt_proyecto_final', prefix='stg') %}
{{ codegen.generate_model_yaml(
    model_names = models_to_generate
) }}