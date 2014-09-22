#!/usr/bin/env python

import i3
outputs = i3.get_outputs()

i3.workspace(outputs[0]['current_workspace'])
i3.command('move', 'workspace to output right')

