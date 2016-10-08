#!/bin/bash

# defaults
DEFAULT_COLOR_BUILD_STARTED="yellow"
DEFAULT_COLOR_BUILD_SUCCESS="green"
DEFAULT_COLOR_BUILD_FAILURE="red"

# use custom colors if set (not empty string)
is_custom_color=false
if [ -n "${color_build_started_custom}" ] ; then
    color_build_started=${color_build_started_custom}
    is_custom_color=true
fi

if [ -n "${color_build_failure_custom}" ] ; then
    color_build_failure=${color_build_failure_custom}
    is_custom_color=true
fi

if [ -n "${color_build_success_custom}" ] ; then
    color_build_success=${color_build_success_custom}
    is_custom_color=true
fi

# use default colors if no colors provided (empty string)
if [ -z "${color_build_started}" ] ; then
    color_build_started=${DEFAULT_COLOR_BUILD_STARTED}
fi

if [ -z "${color_build_failure}" ] ; then
    color_build_failure=${DEFAULT_COLOR_BUILD_FAILURE}
fi

if [ -z “${color_build_success}” ] ; then
    color_build_success=${DEFAULT_COLOR_BUILD_SUCCESS}
fi

# check which color to use
if [[ "${workflow_start}" == "yes" ]] ; then
    color=${color_build_started}
else
    if [[ "${BITRISE_BUILD_STATUS}" == "0" ]] ; then
        color=${color_build_success}
    else
        color=${color_build_failure}
    fi
fi

if ${is_custom_color}; then
    body="{\"color\":\"#${color}\",\"power\":\"on\"}"
else
    body="{\"color\":\"${color}\",\"power\":\"on\"}"
fi

# change bulb color via API
curl -s -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer ${auth_token}" -d ${body} "https://api.lifx.com/v1/lights/label:${bulb_label}/state" #> /dev/null
return_code=$?
exit ${return_code}
