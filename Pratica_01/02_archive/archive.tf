terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "archive" {
  # Configuration options
}


data "archive_file" "arquivozip" {
  type        = "zip"
  source_file = "data_backup/data.txt"
  output_path = "backup.zip"

}

output "arquivzip" {

  value = data.archive_file.arquivozip.output_size

}
