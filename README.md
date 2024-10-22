# terraform-modules

Esse projeto disponibiliza módulos Terraform que facilitam o provisionamento de recursos no Google Cloud Platform (GCP).

## Como utilizar

Para utilizar esses módulos no seu projeto Terraform basta adicionar o módulo desejado no seu arquivo **main.tf**, por
exemplo:

```hcl
module "cloud-armor-default-policy" {
  source = "github.com/Hakamad4/tf-core//gcp/{{module_name}}?ref=v0.0.1"
  # Configurações personalizadas (opcional)
}
```

## Release

Esse projeto utiliza [release-me-please](https://github.com/googleapis/release-please) para disponibilização automática,
via GitHub Actions, de cada módulo quando as alterações chegam na branch main. Todo ciclo de vida da disponibilização
das novas funcionalidades são gerenciadas pelo próprio relese-me-please.

É necessário utilizar a mensagem de commit no seguinte formato:

```scss
feat(module_name): descrição da feature
```
