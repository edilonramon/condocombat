resource "supabase_project" "db" {
  organization_id = "lggsoyixbvcrucoatoqr"
  name            = "condocombat-db"
  database_password = var.supabase_db_password
  region          = "us-east-1"
}