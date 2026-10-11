resource "kubernetes_role_binding_v1" "role_binding_v1s" {
  for_each = var.role_binding_v1s


  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
    namespace     = each.value.metadata.namespace
  }

  role_ref {
    api_group = each.value.role_ref.api_group
    kind      = each.value.role_ref.kind
    name      = each.value.role_ref.name
  }

  dynamic "subject" {
    for_each = each.value.subject
    content {
      api_group = subject.value.api_group
      kind      = subject.value.kind
      name      = subject.value.name
      namespace = subject.value.namespace
    }
  }
}

