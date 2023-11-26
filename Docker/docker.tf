resource "docker_image" "nginx" {
    name = "nginx:latest"
    keep_locally = false
}

resource "docker_container" "nginx" {
    image = docker_image.nginx.image_id // w wersji 3.0.2 terraforma zamiast "latest" używamy "image_id"
    name = "terraform-nginx-demo"
    ports {
        internal = 80
        external = 8003
    }
}
