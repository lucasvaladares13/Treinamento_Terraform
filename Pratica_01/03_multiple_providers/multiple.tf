terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
  }
}

provider "archive" {
  # Configuration options
}
provider "random" {
  # Configuration options
}

resource "random_string" "random" {
  length  = 5
  special = false
}

data "archive_file" "arquivozip" {
  type        = "zip"
  source_file = "data_backup/data.txt"
  output_path = "backup.zip"

}

output "arquivzip" {

  value = data.archive_file.arquivozip.output_size

}

output "random_string" {

  value = random_string.random.result

}
