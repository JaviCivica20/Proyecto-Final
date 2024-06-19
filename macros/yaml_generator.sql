-- Genera el contenido del yml correspondiente a los modelos del directorio y prefijo especificados

{% set models_to_generate = codegen.get_models(directory='models/staging/base', prefix='base_') %}
{{ codegen.generate_model_yaml(
    model_names = models_to_generate
) }}



{{ codegen.generate_model_yaml(
    model_names = ['base_dbt_proyecto_final__country']
) }}
