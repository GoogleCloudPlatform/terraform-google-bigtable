// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package bigtable_resource

import (
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestBigTableInstance(t *testing.T) {
	bt_ins := tft.NewTFBlueprintTest(t)

	bt_ins.DefineVerify(func(assert *assert.Assertions) {
		bt_ins.DefaultVerify(assert)

		projectID := bt_ins.GetStringOutput("project_id")
		instanceID := bt_ins.GetStringOutput("instance_id")
		ins_cmd := gcloud.Run(t, "bigtable instances describe", gcloud.WithCommonArgs([]string{instanceID, "--project", projectID, "--format", "json"}))
		assert.Equal(instanceID, ins_cmd.Get("name").String(), "Bigtable instance ID mismatch. Instance is not created successfully.")
	})
	bt_ins.Test()
}
