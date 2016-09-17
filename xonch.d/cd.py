
def cd(args, stdin=None):
    files = $(ls -la | awk '{print $9}')
    return files

aliases['cdrc'] = cd
