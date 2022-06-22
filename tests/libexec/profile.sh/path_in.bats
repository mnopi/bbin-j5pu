#!/usr/bin/env bats

setup_file() { rebash; . "${BATS_TOP}/tests/helpers/libexec::profile.sh::path.bash"; }

@test "path_in /bin " {
  bats::run
  assert_success
}

@test "$(bats::basename) /tmp/bin " {
  bats::run
  assert_failure
}

@test "$(bats::basename) /tmp/bin MANPATH " {
  bats::run
  assert_failure
}

@test "PYTHONPATH=/tmp/bin:/usr/bin; $(bats::basename) /tmp/bin PYTHONPATH" {
  run sh -c "${BATS_TEST_DESCRIPTION}"
  assert_success
}

@test "PYTHONPATH=/tmp/bin:/usr/bin; $(bats::basename) /usr/bin PYTHONPATH" {
  run sh -c "${BATS_TEST_DESCRIPTION}"
  assert_success
}

@test "PYTHONPATH=/tmp/bin:/usr/bin:; $(bats::basename) /usr/bin PYTHONPATH" {
  run sh -c "${BATS_TEST_DESCRIPTION}"
  assert_success
}

@test "$(bats::basename) /tmp/bin PYTHONPATH " {
  bats::run
  assert_failure
}