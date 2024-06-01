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
module "bigtable" {
  source       = "googlestaging/bigtable/google"
  project      = var.project
  name         = "bigtable-tf1"
  display_name = "bigtable-tf1"
  storage_type = "HDD"
  zones = {
    zone1 = {
      "cluster_id" = "cluster1"
      "zone"       = "us-central1-a"
      "num_nodes"  = 2
    }
    zone2 = {
      "cluster_id" = "cluster2"
      "zone"       = "us-east1-b"
      "autoscaling_config" = {
        "min_nodes"  = 1
        "max_nodes"  = 3
        "cpu_target" = 50
      }
    }
  }
  labels = {
    my-label = "prod-label"
  }
  tables = {
    table1 = {
      "table_name" = "test-table1"
      split_keys   = ["a", "b", "c"]
      "column_family" = {
        family1 = {
          "family" = "first-family"
        }
        family2 = {
          "family" = "second-family"
        }
      }
    }
    table2 = {
      "table_name" = "test-table2"
      table3 = {
        "table_name" = "test-table3"
      }
    }
  }
}
