#!/bin/bash
#
# Update AWS CDK to latest version.
#
# Requirements
# ============
#
# - curl
# - jq
#
# Usage
# =====
#
# ```bash
# .github/scripts/bump-aws-cdk.sh
# ```
#

set -euo pipefail

# Constants
AWS_CDK_PREFIX="aws-cdk-"
AWS_CDK_LIB="${AWS_CDK_PREFIX}lib"

# Vars
DEPENDENCY_GROUP=${DEPENDENCY_GROUP:-"infrastructure"}

# Functions
function get_pypi_package_latest_version() {
    package="${1}"
    curl -s "https://pypi.org/pypi/${package}/json" | jq -r ".info.version"
}

# OS independent version of `sed -i`
function replace_string() {
    file_name="${1}"
    find_string="${2}"
    replace_to="${3}"
    python3 -c "from pathlib import Path; (p := Path('${file_name}')).write_text(p.read_text().replace('${find_string}', '${replace_to}'))"
}

# Grab current aws-cdk-lib version
current_version="$(poetry show "${AWS_CDK_LIB}" | grep version | awk -F ':' '{print $2}' | xargs)"

# And latest one
latest_version="$(get_pypi_package_latest_version "${AWS_CDK_LIB}")"

# If versions match - do nothing
if [ "${current_version}" = "${latest_version}" ]; then
    echo "${AWS_CDK_LIB} already has latest version installed: ${current_version}"
    echo "All OK!"
    exit 0
fi

# If versions do not match - update to latest one, but before find all alpha dependencies
alpha_dependencies=""
# shellcheck disable=SC2013
for alpha_dependency in $(grep -e "^${AWS_CDK_PREFIX}.*-alpha" pyproject.toml | awk '{print $1}'); do
    alpha_dependencies+="${alpha_dependency}@$(get_pypi_package_latest_version "${alpha_dependency}") "
done

echo "Update ${AWS_CDK_LIB} to ${latest_version}"
# shellcheck disable=SC2086
poetry add -G "${DEPENDENCY_GROUP}" "${AWS_CDK_LIB}"@"${latest_version}" ${alpha_dependencies}

# Update CDK version in Makefile & setup cdk action
replace_string \
    Makefile \
    "CDK_VERSION ?= ${current_version}" \
    "CDK_VERSION ?= ${latest_version}"
replace_string \
    .github/actions/setup_cdk/action.yml \
    "default: \"${current_version}\"" \
    "default: \"${latest_version}\""

# Provide necessary data for CI
if [ -n "${GITHUB_OUTPUT}" ]; then
    echo "current-version=${current_version}" >> "${GITHUB_OUTPUT}"
    echo "latest-version=${latest_version}" >> "${GITHUB_OUTPUT}"
fi

echo "All OK!"
