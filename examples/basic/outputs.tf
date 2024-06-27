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

output "instance_name" {
  value       = module.bigtable.instance_name
  description = "Bigtable instance name"
}

output "instance_id" {
  value       = module.bigtable.instance_id
  description = "Bigtable instance id"
}

output "table_ids" {
  value       = module.bigtable.table_ids
  description = "List of table being provisioned"
}
