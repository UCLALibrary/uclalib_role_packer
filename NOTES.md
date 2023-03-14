# Notes

[Template Literals](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md#template-literals)

```hcl
%{ if true ~} hello %{~ endif } produces "hello".
```

`~` in `{ ... }` is a strip marker

```hcl
%{ if vm_ip != null ~}ip=${ vm_ip }{~ endif }
```

Assumes `vm_ip` is defaulted to null in the variables definition
