# Demo ArgoCD Static Website - Image Updater

Demo project thực hành GitOps với **ArgoCD Image Updater** - cách được production teams sử dụng nhiều nhất.

## 🚀 Workflow với ArgoCD Image Updater

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Developer     │    │   GitHub Actions │    │   DockerHub     │
│                 │───▶│                  │───▶│                 │
│ git push main   │    │ Build & Push     │    │ New image:tag   │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                                        │
┌─────────────────┐    ┌──────────────────┐            │
│   Kubernetes    │◀───│ ArgoCD Image     │◀───────────┘
│                 │    │ Updater          │
│ Auto Deploy     │    │ Auto Update      │
└─────────────────┘    └──────────────────┘
```

## ✅ Lợi ích:

- **Không loop vô hạn**: GitHub Actions chỉ build/push image
- **Single repo**: Không cần tách config repo
- **Production-ready**: Được Argo team maintain
- **Tự động**: Image Updater tự update manifest khi có image mới

## 🛠 Setup

### 1. Install ArgoCD Image Updater:
```bash
./setup-image-updater.sh
```

### 2. Setup GitHub Secrets:
- `DOCKERHUB_USERNAME`: DockerHub username  
- `DOCKERHUB_TOKEN`: DockerHub access token

### 3. Cập nhật placeholders:
- `.github/workflows/build.yml`: Thay `<your-dockerhub-username>`
- `argocd/application.yaml`: Thay `<your-dockerhub-username>` và `<your-username>`
- `k8s/deployment.yaml`: Thay `<your-dockerhub-username>`

### 4. Deploy Application:
```bash
kubectl apply -f argocd/application.yaml
```

## 🔄 Cách hoạt động:

1. **Push code** → GitHub Actions build image với tag `latest` và `commit-sha`
2. **ArgoCD Image Updater** detect image mới trên DockerHub  
3. **Auto update** `k8s/deployment.yaml` với image tag mới
4. **ArgoCD** sync thay đổi và deploy

## 📋 Key Annotations:

```yaml
annotations:
  # Theo dõi image này
  argocd-image-updater.argoproj.io/image-list: demo-static-site=<dockerhub-user>/demo-static-site
  
  # Ghi thay đổi về git repo
  argocd-image-updater.argoproj.io/write-back-method: git
  
  # Strategy: latest tag
  argocd-image-updater.argoproj.io/demo-static-site.update-strategy: latest
```

## 🔍 Monitoring:

```bash
# Check Image Updater logs
kubectl logs -f deployment/argocd-image-updater -n argocd

# Check Application status  
kubectl get applications -n argocd

# Check if image was updated
git log --oneline | head -5
```

## 🌐 Truy cập:
- NodePort: `http://<node-ip>:30080`
- Port-forward: `kubectl port-forward svc/demo-static-site-service 8080:80`

## 🎯 Production Tips:

- Dùng **semver strategy** thay vì latest cho production
- Setup **webhook** để update nhanh hơn polling
- Configure **Git credentials** cho private repos
