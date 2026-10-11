variable "role_binding_v1s" {
  description = <<EOT
Map of role_binding_v1s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
        - namespace (optional)
    - role_ref (block):
        - api_group (required)
        - kind (required)
        - name (required)
    - subject (block):
        - api_group (optional)
        - kind (required)
        - name (required)
        - namespace (optional)
EOT

  type = map(object({
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
      namespace     = optional(string)
    })
    role_ref = object({
      api_group = string
      kind      = string
      name      = string
    })
    subject = list(object({
      api_group = optional(string)
      kind      = string
      name      = string
      namespace = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.role_binding_v1s : (
        length(v.subject) >= 1
      )
    ])
    error_message = "Each subject list must contain at least 1 items"
  }
}

