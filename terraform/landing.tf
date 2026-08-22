# Busca a referência do site da Landing Page na Netlify pelo ID
data "netlify_site" "landing" {
  id = var.netlify_site_name
}

# Compila o Astro com a URL do Frontend e faz o deploy dos arquivos estáticos via Netlify CLI
resource "terraform_data" "landing_deploy" {
  triggers_replace = [
    data.netlify_site.landing.id,
    render_web_service.frontend.url
  ]

  provisioner "local-exec" {
    working_dir = "${path.module}/../landing"
    environment = {
      PUBLIC_APP_URL = render_web_service.frontend.url
    }
    command = "npm run build && npx netlify-cli deploy --dir=dist --prod --auth=${var.netlify_api_token} --site=${data.netlify_site.landing.id}"
  }
}