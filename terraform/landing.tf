data "netlify_site" "landing" {
  id = var.netlify_site_name
}

resource "netlify_environment_variable" "landing_public_url" {
  site_id = data.netlify_site.landing.id
  team_id = "edilon-condoCombat"
  key     = "PUBLIC_APP_URL"
  values = [
    {
      value   = render_web_service.frontend.url
      context = "all"
    }
  ]
}

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

  depends_on = [
    netlify_environment_variable.landing_public_url
  ]
}