#!/bin/bash

# defaults
DEFAULT_COLOR_BUILD_SUCCESS="green"
DEFAULT_COLOR_BUILD_FAILURE="red"

# use custom colors if set (not empty string)
is_custom_color=false
if [ -n "${color_build_failure_custom}" ] ; then
    color_build_failure=${color_build_failure_custom}
    is_custom_color=true
fi

if [ -n "${color_build_success_custom}" ] ; then
    color_build_success=${color_build_success_custom}
    is_custom_color=true
fi

# use default colors if no colors provided (empty string)
if [ -z "${color_build_failure}" ] ; then
    color_build_failure=${DEFAULT_COLOR_BUILD_FAILURE}
fi

if [ -z “${color_build_success}” ] ; then
    color_build_success=${DEFAULT_COLOR_BUILD_SUCCESS}
fi

# check which color to use
if [[ "${BITRISE_BUILD_STATUS}" == "0" ]] ; then
    color=${color_build_success}
else
    color=${color_build_failure}
fi

if ${is_custom_color}; then
    body="{\"color\":\"#${color}\",\"power\":\"on\"}"
else
    body="{\"color\":\"${color}\",\"power\":\"on\"}"
fi

# check whether to employ an effect instead of just turning it a solid color
if [[ "${effect}" != "none" ]]; then
    endpoint="lights/label:${bulb_label}/effects/${effect}"
    body="{\"color\":\"${color}\",\"from_color\":\"white\",\"cycles\":10}"
    method="POST"
else
    endpoint="lights/label:${bulb_label}/state"
    method="PUT"
fi

# change bulb color via API
curl -s -X $method \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${auth_token}" \
    -d ${body} "https://api.lifx.com/v1/$endpoint" #> /dev/null
return_code=$?
exit ${return_code}
