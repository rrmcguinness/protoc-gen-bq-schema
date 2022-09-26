/*
Copyright 2014 Google Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package converter

import (
	"strconv"
	"strings"

	"github.com/golang/protobuf/protoc-gen-go/descriptor"
)

const (
	messagePath    = 4 // FileDescriptorProto.message_type
	fieldPath      = 2 // DescriptorProto.field
	subMessagePath = 3 // DescriptorProto.nested_type
)

// Comments is a map between path in FileDescriptorProto and leading/trailing comments for each field.
type Comments map[string]string

// ParseComments reads FileDescriptorProto and parses comments into a map.
func ParseComments(fd *descriptor.FileDescriptorProto) Comments {
	comments := make(Comments)

	for _, loc := range fd.GetSourceCodeInfo().GetLocation() {
		if !hasComment(loc) {
			continue
		}

		path := loc.GetPath()
		key := make([]string, len(path))
		for idx, p := range path {
			key[idx] = strconv.FormatInt(int64(p), 10)
		}

		comments[strings.Join(key, ".")] = buildComment(loc)
	}

	return comments
}

// Get returns comment for path or empty string if path has no comment.
func (c Comments) Get(path string) string {
	if val, ok := c[path]; ok {
		return val
	}

	return ""
}

func hasComment(loc *descriptor.SourceCodeInfo_Location) bool {
	if loc.GetLeadingComments() == "" && loc.GetTrailingComments() == "" {
		return false
	}

	return true
}

func buildComment(loc *descriptor.SourceCodeInfo_Location) string {
	comment := strings.TrimSpace(loc.GetLeadingComments()) + "\n\n" + strings.TrimSpace(loc.GetTrailingComments())
	return strings.Trim(comment, "\n")
}
