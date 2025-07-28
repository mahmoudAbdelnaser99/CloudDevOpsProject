def buildImage(image) {
  sh "docker build -t ${image} ./app"
}

def scanImage(image) {
  echo "Scanning image: ${image} ... (placeholder)"
  // Integrate with Trivy/Anchore if needed
}

def pushImage(image, credsId) {
  withCredentials([usernamePassword(credentialsId: credsId, passwordVariable: 'PASS', usernameVariable: 'USER')]) {
    sh """
      echo "$PASS" | docker login -u "$USER" --password-stdin
      docker push ${image}
    """
  }
}

def updateManifests(image) {
  def tag = new Date().format("yyyyMMddHHmmss")
  def fullImage = "${image}:${tag}"
  sh """
    sed -i 's|image:.*|image: ${fullImage}|' k8s-manifests/deployment.yaml
  """
}
