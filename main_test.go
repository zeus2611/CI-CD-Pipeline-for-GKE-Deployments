package main

import (
	"testing"
)

func TestLocal(t *testing.T) {
	p := PodMetadata{}
	err := p.Populate("test", "1", "blue")
	if err == nil {
		t.Error("Running inside k8s on accident?")
	}
}
