/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "name" {
  description = "The unique name of the Bigtable instance."
  type        = string
  validation {
    condition     = length(var.name) >= 6 && length(var.name) <= 33
    error_message = "Must be 6-33 characters and must only contain hyphens, lowercase letters and numbers."
  }
}

variable "display_name" {
  description = "The human-readable display name of the Bigtable instance. Defaults to the instance name"
  type        = string
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the instance"
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "The storage type to use. One of SSD or HDD. Defaults to SSD"
  type        = string
  default     = "SSD"
  validation {
    condition     = var.storage_type == "SSD" || var.storage_type == "HDD"
    error_message = "Must be SSD or HDD."
  }
}


variable "zones" {
  description = "Zones of the Bigtable cluster."
  type = map(object({
    zone         = string
    cluster_id   = string
    num_nodes    = optional(number)
    kms_key_name = optional(string)
    autoscaling_config = optional(object({
      min_nodes      = number
      max_nodes      = number
      cpu_target     = number
      storage_target = optional(number)
    }))
  }))
}


variable "labels" {
  description = "labels associated to the Bigtable instance."
  type        = map(string)
  default     = {}
}


variable "tables" {
  description = "Tables to created in the Bigtable instance."
  type = map(object({
    table_name              = string
    split_keys              = optional(list(string))
    deletion_protection     = optional(string)
    change_stream_retention = optional(number)
    column_family = optional(map(object({
      family = string
      }))
    )
  }))

  validation {
    condition = alltrue(flatten([
      for k, v in var.tables : (length(v.table_name) >= 1 && length(v.table_name) <= 50)
    ]))
    error_message = "table_name must be between 1 and 50."
  }
  default = {}
}

