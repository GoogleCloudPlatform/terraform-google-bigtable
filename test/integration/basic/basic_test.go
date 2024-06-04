// Copyright 2022 Google LLC
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

package multiple_buckets

import (
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
	"github.com/stretchr/testify/assert"
)

func TestBigTableInstance(t *testing.T) {
	bt_ins := tft.NewTFBlueprintTest(t)

	bt_ins.DefineVerify(func(assert *assert.Assertions) {
		bt_ins.DefaultVerify(assert)

		projectID := bt_ins.GetStringOutput("project_id")
		services := gcloud.Run(t, "services list", gcloud.WithCommonArgs([]string{"--project", projectID, "--format", "json"})).Array()

		match := utils.GetFirstMatchResult(t, services, "config.name", "bigtable.googleapis.com")
		assert.Equal("ENABLED", match.Get("state").String(), "bigtable service should be enabled")
	})
	bt_ins.Test()
}
