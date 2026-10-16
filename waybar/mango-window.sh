#!/bin/sh
# waybar custom/window helper for MangoWM.
#
# The installed waybar (0.15.0) has no native mango/* modules, and MangoWM does
# not speak the dwl (zdwl) IPC protocol that waybar's dwl/window module needs.
# MangoWM *does* expose a line-oriented JSON stream over its own IPC socket, so
# stream the focused client and reshape each line into the {"text","class"}
# object that a custom module with "return-type": "json" expects.
#
# MANGO_INSTANCE_SIGNATURE is exported by the compositor into its children, so
# this just works when waybar is started from mango's exec_once.
#
#   {"id":4,"title":"vim","appid":"foot"}  ->  {"text":"vim","class":"foot"}

mmsg watch focusing-client \
	| jq --unbuffered -c '{text: (.title // ""), class: (.appid // "")}'
