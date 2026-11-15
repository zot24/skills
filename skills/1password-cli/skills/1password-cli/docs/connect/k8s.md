> Source: https://www.1password.dev/connect/k8s/



Kubernetes integrations


# Kubernetes integrations


## Securing secrets across your full deployment stack?


## <a href="#comparison" class="anchor-link" aria-label="Navigate to header: Comparison"></a><span id="_R_79deehkd74t9_" class="min-w-0 break-words cursor-pointer">Comparison</span>


| **Feature** | <a href="#kubernetes-injector" class="link"><strong>Kubernetes Injector</strong></a> | <a href="#kubernetes-operator" class="link"><strong>Kubernetes Operator</strong></a> |
|----|----|----|
| Supports service accounts | <span class="badge badge--primary">Yes</span> | <span class="badge badge--primary">Yes</span> |
| Supports Connect servers | <span class="badge badge--primary">Yes</span> | <span class="badge badge--primary">Yes</span> |
| Allows for granular selection of secrets | <span class="badge badge--primary">Yes</span> | <span class="badge badge--secondary">No</span> |
| Uses Kubernetes Secrets | <span class="badge badge--secondary">No</span> | <span class="badge badge--primary">Yes</span> |
| Injects 1Password items directly into Kubernetes pods | <span class="badge badge--primary">Yes</span> | <span class="badge badge--secondary">No</span> |
| Works with multiple credentials simultaneously | <span class="badge badge--primary">Yes</span> | <span class="badge badge--secondary">No</span> |
| Supports automatic redeployment when 1Password items change | <span class="badge badge--secondary">No</span> | <span class="badge badge--primary">Yes</span> |
| Requires a Connect token to deploy | <span class="badge badge--secondary">No</span> | <span class="badge badge--primary">Yes</span> |


### <a href="#kubernetes-injector" class="anchor-link" aria-label="Navigate to header: Kubernetes Injector"></a><span id="_R_h9deehkd74t9_" class="cursor-pointer">Kubernetes Injector</span>


### <a href="#kubernetes-operator" class="anchor-link" aria-label="Navigate to header: Kubernetes Operator"></a><span id="_R_n9deehkd74t9_" class="cursor-pointer">Kubernetes Operator</span>


- Create Kubernetes Secrets from 1Password items and load them into Kubernetes deployments.
- Automatically restart deployments when 1Password items update.

### <a href="#1password-helm-charts" class="anchor-link" aria-label="Navigate to header: 1Password Helm charts"></a><span id="_R_v9deehkd74t9_" class="cursor-pointer">1Password Helm charts</span>


Was this page helpful?


