-- Genera el contenido del yml correspondiente a los modelos del directorio y prefijo especificados

{% set models_to_generate = codegen.get_models(directory='marts/core', prefix='dim') %}
{{ codegen.generate_model_yaml(
    model_names = models_to_generate
) }}