# Unit Tests for tf-atom-nat-gateway-aws
#
# These tests use a mock provider — no real AWS calls are made.
# They assert on plan-KNOWN values only (tf-label id, resource count,
# input pass-throughs) — never on computed arn/id, which are unknown
# under a mock provider.
#
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose

mock_provider "aws" {}

variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  subnet_id         = "subnet-0123456789abcdef0"
  allocation_id     = "eipalloc-0123456789abcdef0"
  connectivity_type = "public"
}

# ---------------------------------------------------------------------------
# Test: Module creates the NAT gateway when enabled
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should report enabled == true by default."
  }

  assert {
    condition     = length(aws_nat_gateway.this) == 1
    error_message = "Exactly one NAT gateway should be planned when enabled."
  }

  assert {
    condition     = aws_nat_gateway.this[0].subnet_id == "subnet-0123456789abcdef0"
    error_message = "NAT gateway subnet_id should pass through the input value."
  }
}

# ---------------------------------------------------------------------------
# Test: Module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled == false when disabled."
  }

  assert {
    condition     = length(aws_nat_gateway.this) == 0
    error_message = "No NAT gateway should be planned when disabled."
  }

  assert {
    condition     = output.id == null
    error_message = "id output should be null when the module is disabled."
  }
}
