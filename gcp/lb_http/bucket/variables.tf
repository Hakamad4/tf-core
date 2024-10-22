variable "project_id" {
  description = "O ID do projeto ao qual o recurso pertence."
  type        = string
}

variable "name" {
  description = "Nome para a regra de encaminhamento e prefixo para recursos de suporte."
  type        = string
}

variable "labels" {
  description = "Tags associadas a este recurso."
  type        = map(string)
  default     = {}
}

variable "create_address" {
  description = "Criar novo endereço de IP global."
  type        = bool
  default     = true
}

variable "address" {
  description = "Auto link do endereço IP."
  type        = string
  default     = null
}

variable "ip_version" {
  description = "Versão IP para o endereço global (IPv4 ou v6)."
  type        = string
  default     = "IPV4"
}

variable "create_url_map" {
  description = "Defina como `false` se a variável url_map for fornecida."
  type        = bool
  default     = true
}

variable "default_url_map_name" {
  description = "Nome padrão do LB."
  type        = string
  default     = null
}

variable "default_url_map_redirect_name" {
  description = "Nome padrão do LB (HTTP)."
  type        = string
  default     = null
}

variable "url_map" {
  description = "O recurso url_map a ser usado. O padrão é enviar todo o tráfego para o primeiro back-end."
  type        = string
  default     = null
}

variable "http_forward" {
  description = "Defina como `false` para desativar o encaminhamento da porta 80 HTTP."
  type        = bool
  default     = true
}

variable "ssl" {
  description = "Definido como `true` para habilitar o suporte SSL, requer a variável` ssl_certificates` - uma lista de certificados self_link."
  type        = bool
  default     = false
}

variable "ssl_policy" {
  description = "Auto-link para política SSL."
  type        = string
  default     = null
}

variable "quic" {
  description = "Defina como `true` para habilitar o suporte QUIC."
  type        = bool
  default     = false
}

variable "private_key" {
  description = "Conteúdo da chave SSL privada. Obrigatório se `ssl` for` true` e `ssl_certificates` estiver vazio."
  type        = string
  default     = null
}

variable "certificate" {
  description = "Conteúdo do certificado SSL. Obrigatório se `ssl` for` true` e `ssl_certificates` estiver vazio."
  type        = string
  default     = null
}

variable "managed_ssl_certificate_domains" {
  description = "Crie certificados SSL gerenciados pelo Google para domínios especificados. Requer que `ssl` seja definido como` true` e `use_ssl_certificates` definido como` false`."
  type        = list(string)
  default     = []
}

variable "use_ssl_certificates" {
  description = "Se verdadeiro, use os certificados fornecidos por `ssl_certificates`, caso contrário, crie um certificado de` private_key` e `certificate`."
  type        = bool
  default     = false
}

variable "ssl_certificates" {
  description = "Lista de auto-link para certificado SSL. Obrigatório se `ssl` for` true` e nenhum `private_key` e` certificate` forem fornecidos."
  type        = list(string)
  default     = []
}

variable "cdn" {
  description = "Defina como `true` para habilitar o cdn no backend."
  type        = bool
  default     = true
}

variable "https_redirect" {
  description = "Defina como `true` para habilitar o redirecionamento https no lb."
  type        = bool
  default     = false
}

variable "bucket_name" {
  description = "Nome do bucket backend."
  type        = string
}

variable "backend_description" {
  description = "Descrição do bucket backend."
  type        = string
  default     = null
}

variable "backend_cdn_default_ttl" {
  description = "TTL padrão para conteúdo em cache servido por esta origem para responses que não têm um TTL válido existente (max-age ou s-max-age)."
  type        = number
  default     = null
}

variable "backend_cdn_client_ttl" {
  description = " TTL máximo permitido para conteúdo em cache servido por esta origem."
  type        = number
  default     = null
}

variable "backend_cdn_max_ttl" {
  description = " TTL máximo permitido para conteúdo em cache servido por esta origem."
  type        = number
  default     = null
}

variable "backend_cdn_cache_mode" {
  description = "Modo de cache do backend."
  type        = string
  default     = "USE_ORIGIN_HEADERS"
}

variable "backend_customer_response_headers" {
  description = "Substituir response headers."
  type        = list(string)
  default = [
    "X-Cache-Hit: {cdn_cache_status}",
    "Strict-Transport-Security: max-age=31536000; includeSubDomains",
    "Permissions-Policy: geolocation=()",
    "X-Frame-Options: DENY",
    "X-Content-Type-Options: nosniff",
    "Referrer-Policy: strict-origin-when-cross-origin",
    "Content-Security-Policy: default-src https: 'unsafe-inline' 'unsafe-eval'"
  ]
}
