/**
 * Copyright 2024 Google LLC
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

resource "google_bigtable_instance" "instance" {
  name                = var.name
  display_name        = var.display_name
  project             = var.project_id
  deletion_protection = var.deletion_protection

  dynamic "cluster" {
    for_each = var.zones
    content {
      cluster_id   = cluster.value["cluster_id"]
      zone         = cluster.value["zone"]
      storage_type = var.storage_type
      num_nodes    = cluster.value["num_nodes"]
      kms_key_name = cluster.value["kms_key_name"]
      dynamic "autoscaling_config" {
        for_each = cluster.value["autoscaling_config"] == null ? [] : [1]
        content {
          min_nodes      = cluster.value["autoscaling_config"].min_nodes
          max_nodes      = cluster.value["autoscaling_config"].max_nodes
          cpu_target     = cluster.value["autoscaling_config"].cpu_target
          storage_target = cluster.value["autoscaling_config"].storage_target
        }
      }
    }
  }

  labels = var.labels

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_bigtable_table" "table" {
  for_each                = var.tables
  project                 = var.project_id
  name                    = each.value.table_name
  instance_name           = google_bigtable_instance.instance.name
  split_keys              = each.value.split_keys
  deletion_protection     = each.value.deletion_protection
  change_stream_retention = each.value.change_stream_retention

  lifecycle {
    prevent_destroy = false
  }
  dynamic "column_family" {
    for_each = each.value.column_family == null ? {} : each.value.column_family
    content {
      family = column_family.value["family"]
    }
  }
}


