#!/bin/bash
#
# Print output value of given key for given stack.
#
# Usage
# =====
#
# ```bash
# ./.github/scripts/stack-output-value.sh STACK_NAME OUTPUT_KEY
# ```
#

stack_name="${1}"
if [ -z "${stack_name}" ]; then
    echo >&2 "Usage: ./.github/scripts/stack-output-value.sh STACK_NAME OUTPUT_KEY"
    exit 2
fi

output_key="${2}"
if [ -z "${output_key}" ]; then
    echo >&2 "Usage: ./.github/scripts/stack-output-value.sh STACK_NAME OUTPUT_KEY"
    exit 2
fi

set -euo pipefail

output="$(aws cloudformation describe-stacks --stack-name="${stack_name}" --query "Stacks[0].Outputs[?OutputKey==\`${output_key}\`].OutputValue" --output text)"
if [ -z "${output}" ]; then
    echo >&2 "ERROR: ${output_key} output not yet available for ${stack_name}. Please wait until it will be available and try again later."
    exit 2
fi

echo "${output}"
