function showMessage() {
    const messageDiv = document.getElementById('message');
    messageDiv.innerHTML = `
        <h3>🎉 GitOps Magic Working!</h3>
        <p><strong>✅ Code Updated:</strong> HTML, CSS, JS files modified</p>
        <p><strong>🔄 GitHub Actions:</strong> Built new Docker image</p>
        <p><strong>📦 DockerHub:</strong> Image pushed successfully</p>
        <p><strong>🤖 Image Updater:</strong> Detected new image & updated manifest</p>
        <p><strong>🚀 ArgoCD:</strong> Auto-synced and deployed to Kubernetes</p>
        <p><strong>⏰ Deployed at:</strong> ${new Date().toLocaleString()}</p>
        <hr>
        <p><em>🎯 This is the power of GitOps automation!</em></p>
    `;
    messageDiv.style.display = 'block';
}
