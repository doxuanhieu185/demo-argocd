function showMessage() {
    const messageDiv = document.getElementById('message');
    messageDiv.innerHTML = `
        <h3>🎉 Success!</h3>
        <p>Your ArgoCD GitOps deployment is working perfectly!</p>
        <p>Deployed at: ${new Date().toLocaleString()}</p>
    `;
    messageDiv.style.display = 'block';
}
