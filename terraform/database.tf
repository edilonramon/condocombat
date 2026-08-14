resource "supabase_project" "db" {
  organization_id = "SEU_ORGANIZATION_ID_REAL_AQUI"
  name            = "condocombat-db"
  database_password = var.supabase_db_password
  region          = "us-east-1"
}