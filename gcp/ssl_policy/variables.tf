variable "project_id" {
  description = "O ID do projeto ao qual o recurso pertence."
  type        = string
}

variable "name" {
  description = "Nome da política."
  type        = string
}

variable "profile" {
  description = "Perfil da política, que pode ser COMPATIBLE, MODERN ou COMPATIBLE."
  type        = string
  default     = "MODERN"
}

variable "min_tls_version" {
  description = "Versão mínima do protocolo SSL que pode ser utilizado pelo cliente para conectar ao Load Balancer."
  type        = string
  default     = "TLS_1_2"
}
